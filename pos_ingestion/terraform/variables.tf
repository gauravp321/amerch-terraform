variable "project_id" {
  description = "GCP Project ID. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be a valid GCP project ID (lowercase letters, numbers, hyphens, 6-30 characters)."
  }
}

variable "region" {
  description = "GCP Region for resources. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition = contains([
      "us-central1", "us-central2", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4",
      "europe-west1", "europe-west2", "europe-west3", "europe-west4", "europe-west6",
      "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2", "asia-northeast3",
      "asia-south1", "asia-southeast1", "asia-southeast2",
      "australia-southeast1", "southamerica-east1", "northamerica-northeast1"
    ], var.region)
    error_message = "Region must be a valid GCP region."
  }
}

variable "bucket_name" {
  description = "Name of the GCS bucket for POS file landing zone. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9._-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Bucket name must be 3-63 characters, start and end with lowercase letter or number, and contain only lowercase letters, numbers, dots, dashes, and underscores."
  }
}

variable "function_name" {
  description = "Name of the Cloud Function. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z](?:[-_a-z0-9]{0,61}[a-z0-9])?$", var.function_name))
    error_message = "Function name must be 1-63 characters, start with lowercase letter, and contain only lowercase letters, numbers, hyphens, and underscores."
  }
}

variable "service_account_email" {
  description = "Service account email for Cloud Function runtime. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z0-9-]+@[a-z0-9.-]+\\.iam\\.gserviceaccount\\.com$", var.service_account_email))
    error_message = "Service account email must be a valid GCP service account email format (name@project.iam.gserviceaccount.com)."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = contains(["dev", "staging", "prod", "test"], lower(var.environment))
    error_message = "Environment must be one of: dev, staging, prod, test."
  }
}

variable "cost_center" {
  description = "Cost center for resource billing and tracking. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = length(var.cost_center) > 0 && length(var.cost_center) <= 63 && can(regex("^[a-z0-9_-]+$", var.cost_center))
    error_message = "Cost center must be 1-63 characters and contain only lowercase letters, numbers, hyphens, and underscores."
  }
}

variable "cloud_function_trigger" {
  description = "Eventarc Trigger name. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?$", var.cloud_function_trigger))
    error_message = "Trigger name must be 1-63 characters, start with lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "email_enabled" {
  description = "Email flag. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = var.email_enabled == "" || can(regex("^(?i)(true|false|yes|no|1|0)$", var.email_enabled))
    error_message = "Email enabled must be empty string or one of: true, false, yes, no, 1, 0 (case-insensitive)."
  }
}

variable "enable_bucket_versioning" {
  description = "Enable versioning on the POS files bucket for data recovery. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = bool
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment
}

variable "kms_key_name" {
  description = "KMS key name for bucket encryption. Leave null for default encryption"
  type        = string
  default     = null
}

variable "function_source_bucket_name" {
  description = "Name of the GCS bucket for Cloud Function source code archive. If null, will create a new bucket with suffix '-gcf-source'"
  type        = string
  default     = null

  validation {
    condition     = var.function_source_bucket_name == null || can(regex("^[a-z0-9][a-z0-9._-]{1,61}[a-z0-9]$", var.function_source_bucket_name))
    error_message = "Function source bucket name must be 3-63 characters, start and end with lowercase letter or number, and contain only lowercase letters, numbers, dots, dashes, and underscores."
  }
}

variable "retention_policy_locked" {
  description = "Whether the retention policy is locked. Set to true in production for compliance. Once locked, retention period cannot be reduced. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = bool
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment
}
