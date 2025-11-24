terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0" # Pinned for reproducibility. See README for upgrade process.
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0" # Updated for darwin_arm64 compatibility
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0" # Updated for darwin_arm64 compatibility
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# GCS Bucket for POS file landing zone
# This bucket serves as the landing zone for POS configuration files and CSV data files.
# Files are uploaded by users and trigger the Cloud Function via Eventarc when *_config.json files are created.
# Business Purpose: Enables event-driven ingestion of POS sales data into BigQuery for analytics.
# Design Decision: Separate bucket from function source for security isolation and clearer access controls.
resource "google_storage_bucket" "pos_files" {
  name          = var.bucket_name
  location      = var.region
  storage_class = "STANDARD" # Initial storage class; Autoclass will optimize based on access patterns

  # Autoclass automatically transitions objects to cost-optimized storage classes:
  # - Standard (initial): Frequently accessed data
  # - Nearline: Not accessed for 30 days
  # - Coldline: Not accessed for 90 days
  # - Archive: Not accessed for 365 days
  # Compatible with lifecycle deletion rules (no SetStorageClass conflicts)
  # Design Decision: Autoclass reduces storage costs by automatically moving old files to cheaper storage
  # classes without manual intervention, while maintaining data availability for compliance requirements.
  autoclass {
    enabled = true
  }

  uniform_bucket_level_access = true

  # Enable versioning for data recovery (can be added to existing bucket)
  versioning {
    enabled = var.enable_bucket_versioning
  }

  # Encryption configuration (uses default encryption if kms_key_name is null)
  dynamic "encryption" {
    for_each = var.kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.kms_key_name
    }
  }

  # Retention policy (7 years) - can be added to existing bucket
  # Business Requirement: Sales data must be retained for 7 years for compliance and audit purposes.
  # Design Decision: Retention policy prevents accidental deletion and ensures data availability
  # for the required retention period. Lifecycle rule automatically deletes after retention period.
  retention_policy {
    retention_period = 2555 # 7 years in days
    is_locked        = var.retention_policy_locked
  }

  # Lifecycle rule for automatic deletion after retention period
  # Design Decision: Automatically delete files after 7 years to comply with retention policy
  # and prevent unbounded storage costs. This ensures data is deleted once retention requirement is met.
  lifecycle_rule {
    condition {
      age = 2555 # 7 years in days
    }
    action {
      type = "Delete"
    }
  }

  # Resource labels for cost tracking and organization
  labels = {
    environment = var.environment
    project     = "pos-ingestion"
    managed_by  = "terraform"
    cost_center = var.cost_center
    # Enhanced labels for cost tracking and resource organization
    data_classification = "internal"                                      # For security/compliance
    backup_required     = var.enable_bucket_versioning ? "true" : "false" # Based on versioning setting
    retention_days      = "2555"                                          # 7 years in days (matches retention policy)
    owner               = "data-engineering"                              # For ownership tracking
  }

  # Prevent Terraform from destroying/recreating the bucket
  # This allows us to update mutable attributes (versioning, lifecycle, retention, labels)
  # without replacing the bucket
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      # Location and storage_class are immutable - ignore changes to prevent replacement
      location,
      storage_class,
    ]
  }
}

# Cloud Function for POS file processing
# Business Purpose: Processes POS configuration files and CSV data files uploaded to GCS,
# validates file formats, and loads data into BigQuery tables for analytics.
# Design Decision: Uses Cloud Functions 2nd gen for better reliability, longer timeouts (600s),
# and Eventarc integration. Event-driven architecture allows automatic processing without polling.
# The function reads config files to determine target BigQuery tables and load parameters.
resource "google_cloudfunctions2_function" "pos_file_processor" {
  name        = var.function_name
  location    = var.region
  description = "Cloud Function triggered by POS config file uploads to GCS. Processes configuration files and CSV data, validates formats, and loads data into BigQuery for analytics."

  build_config {
    runtime     = "python311"
    entry_point = "process_config_file"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    max_instance_count = 10
    min_instance_count = 0
    available_memory   = "512Mi"
    # Design Decision: 600s timeout allows BigQuery load jobs up to 540s to complete
    # (BigQuery default timeout is 540s). This provides buffer for large file processing.
    timeout_seconds       = 600 # 10 minutes to allow BigQuery jobs up to 540s to complete
    service_account_email = var.service_account_email
    environment_variables = {
      EMAIL_ENABLED = var.email_enabled != "" ? var.email_enabled : ""
    }
  }

  lifecycle {
    precondition {
      condition     = var.service_account_email != null && var.service_account_email != ""
      error_message = "service_account_email must be set. It is required for Cloud Function execution and must be explicitly provided in terraform.tfvars."
    }
    precondition {
      condition     = google_storage_bucket.function_source != null
      error_message = "Function source bucket must exist before creating Cloud Function. Ensure google_storage_bucket.function_source is created first."
    }
  }

  # event_trigger {
  #   trigger_region = var.region
  #   event_type     = "google.cloud.storage.object.v1.finalized"
  #   retry_policy   = "RETRY_POLICY_DO_NOT_RETRY" # Changed from RETRY to avoid multiple failure emails
  #   event_filters {
  #     attribute = "bucket"
  #     value     = var.bucket_name
  #   }
  #   event_filters {
  #     attribute = "object"
  #     value     = "*_config.json"
  #   }
  # }
}


# Eventarc Trigger for GCS object finalization events
# Business Purpose: Triggers Cloud Function when POS config files (*_config.json) are uploaded to GCS.
# Design Decision: Uses Eventarc instead of direct GCS trigger for better reliability, retry handling,
# and integration with Cloud Functions 2nd gen. Eventarc provides better observability and error handling.
# The trigger filters for *_config.json files to ensure only configuration files trigger processing.
# Note: Eventarc trigger location must match the bucket location. For multi-region buckets (e.g., "US"),
# use the bucket's location string (lowercase).
resource "google_eventarc_trigger" "gcs_trigger" {
  name     = var.cloud_function_trigger
  location = lower(data.google_storage_bucket.pos_files.location)

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }

  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.pos_files.name
  }

  service_account = var.service_account_email

  destination {
    cloud_run_service {
      service = google_cloudfunctions2_function.pos_file_processor.service_config[0].service
      region  = var.region
    }
  }

  depends_on = [
    google_cloudfunctions2_function.pos_file_processor
  ]

  lifecycle {
    precondition {
      condition     = google_storage_bucket.pos_files != null
      error_message = "POS files bucket (google_storage_bucket.pos_files) must exist before creating Eventarc trigger. Ensure the bucket is created first."
    }
    precondition {
      condition     = google_cloudfunctions2_function.pos_file_processor != null
      error_message = "Cloud Function (google_cloudfunctions2_function.pos_file_processor) must exist before creating Eventarc trigger. Ensure the function is created first."
    }
    precondition {
      condition     = var.service_account_email != null && var.service_account_email != ""
      error_message = "service_account_email must be set for Eventarc trigger. It is required and must be explicitly provided in terraform.tfvars."
    }
  }

}


# Dedicated bucket for Cloud Function source code archive
# Business Purpose: Stores Cloud Function source code archives for deployment.
# Design Decision: Separated from POS files bucket for security isolation, clearer access controls,
# and to avoid mixing application code with data files. This bucket has different lifecycle rules
# (30-day retention) since function source archives are temporary and replaced on each deployment.
resource "google_storage_bucket" "function_source" {
  name     = var.function_source_bucket_name != null ? var.function_source_bucket_name : "${var.bucket_name}-gcf-source"
  location = var.region

  uniform_bucket_level_access = true

  # Function source code doesn't need versioning or retention policies
  # Design Decision: These archives are temporary and replaced on each deployment.
  # Versioning would increase costs without benefit since we only need the latest version.
  # Retention policy not needed since lifecycle rule deletes old archives after 30 days.

  # Resource labels for cost tracking
  labels = {
    environment = var.environment
    project     = "pos-ingestion"
    managed_by  = "terraform"
    cost_center = var.cost_center
    purpose     = "cloud-function-source"
    # Enhanced labels for cost tracking and resource organization
    data_classification = "internal"         # For security/compliance
    backup_required     = "false"            # Function source archives are temporary
    owner               = "data-engineering" # For ownership tracking
  }

  # Lifecycle rule: delete old function source archives after 30 days
  lifecycle_rule {
    condition {
      age = 30 # 30 days
    }
    action {
      type = "Delete"
    }
  }
}

# Upload Cloud Function source code archive to GCS
# Business Purpose: Stores the Cloud Function source code archive that Cloud Functions uses for deployment.
# Design Decision: Archive name includes MD5 hash to enable cache busting and ensure new deployments
# use updated code. The archive is created from the src/ directory and contains all Python dependencies.
# Using dedicated function source bucket (separate from POS files bucket) for security and organization.
resource "google_storage_bucket_object" "function_source" {
  name   = "function-source-${data.archive_file.function_source.output_md5}.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path

  lifecycle {
    precondition {
      condition     = google_storage_bucket.function_source != null
      error_message = "Function source bucket (google_storage_bucket.function_source) must exist before uploading function source code. Ensure the bucket is created first."
    }
    precondition {
      condition     = data.archive_file.function_source != null
      error_message = "Function source archive (data.archive_file.function_source) must be created before uploading to GCS. Ensure the archive is generated first."
    }
  }
}
