terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0" # Pinned for reproducibility. See README for upgrade process.
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Merge labels with project_id to create complete label set
# Business Purpose: Labels enable cost allocation, compliance tracking, resource organization, and data governance.
# Design Decision: Centralized label management ensures consistency across all resources. Enhanced labels
# (data_classification, backup_required, owner) support security, compliance, and operational requirements.
# Schema version labels enable tracking of schema changes over time for audit and rollback purposes.
locals {
  labels = merge(
    var.labels,
    {
      dataplex-data-documentation-published-project = var.project_id
      schema_version                                = "1-0-0"
      schema_version_date                           = "2025-11-19"
      # Enhanced labels for cost tracking and resource organization
      data_classification = "internal"         # For security/compliance classification
      backup_required     = "false"            # BigQuery has built-in replication, no additional backup needed
      owner               = "data-engineering" # For ownership tracking and resource management
    }
  )

  # Compute full dataset IDs from keys and prefix
  # This mapping transforms dataset keys (e.g., "coreapp", "salesforce", "workday_hcm")
  # into full dataset IDs based on their type:
  # - MySQL datasets: {prefix}_{key} (e.g., "raw_fivetran_gcloud_performance_coreapp")
  # - Salesforce datasets: {prefix} only (e.g., "raw_fivetran_salesforce")
  # - Workday HCM datasets: {prefix} only (e.g., "raw_fivetran_workday_hcm")
  # - Other datasets: use key as-is
  #
  # Single source of truth for dataset ID computation
  dataset_id_map = {
    for key, config in var.datasets : key => (
      config.is_mysql ? "${var.gcloud_mysql_dataset_prefix}_${key}" : (
        config.is_salesforce ? var.salesforce_dataset_prefix : (
          config.is_workday_hcm ? (
            key == "workday_hcm" ? var.workday_hcm_dataset_prefix : "${var.workday_hcm_dataset_prefix}_${replace(key, "workday_hcm_", "")}"
          ) : key
        )
      )
    )
  }

  # Dataset IDs for for_each keys (using computed dataset IDs)
  dataset_ids = {
    for key, dataset_id in local.dataset_id_map : dataset_id => key
  }

  # Reverse mapping: full dataset ID -> dataset key (for table references)
  # Derived from dataset_id_map to avoid duplication
  dataset_id_to_key = {
    for key, dataset_id in local.dataset_id_map : dataset_id => key
  }

  # Data lineage labels for automated lineage tracking
  # Business Purpose: Enables data governance, compliance tracking, and audit trails by documenting
  # data source, ingestion method, and ownership. Supports regulatory requirements and data catalog integration.
  # Design Decision: Separate label sets per source system allow consistent application across all tables
  # from the same source. Labels are merged with base labels in table resources for complete metadata.
  # These labels enable automated data lineage tracking without manual documentation.
  lineage_labels_mysql = {
    data_source     = "fivetran"                 # Data ingestion tool
    source_system   = "gcloud_mysql_performance" # Source database system
    ingestion_type  = "replication"              # CDC replication via Fivetran
    last_updated_by = "terraform"                # Infrastructure management tool
  }

  lineage_labels_salesforce = {
    data_source     = "fivetran"    # Data ingestion tool
    source_system   = "salesforce"  # Source CRM system
    ingestion_type  = "replication" # CDC replication via Fivetran
    last_updated_by = "terraform"   # Infrastructure management tool
  }

  lineage_labels_workday_hcm = {
    data_source     = "fivetran"    # Data ingestion tool
    source_system   = "workday_hcm" # Source HR system
    ingestion_type  = "replication" # CDC replication via Fivetran
    last_updated_by = "terraform"   # Infrastructure management tool
  }

  lineage_labels_pos_files = {
    data_source     = "gcs"         # Data source (GCS bucket)
    source_system   = "pos_files"   # Source system identifier
    ingestion_type  = "file_upload" # Manual file upload process
    last_updated_by = "terraform"   # Infrastructure management tool
  }
}


module "bq_tables" {
  source = "./tables"

  project_id                  = var.project_id
  region                      = var.region
  datasets                    = google_bigquery_dataset.datasets
  gcloud_mysql_dataset_prefix = var.gcloud_mysql_dataset_prefix
  salesforce_dataset_prefix   = var.salesforce_dataset_prefix
  workday_hcm_dataset_prefix  = var.workday_hcm_dataset_prefix

  labels = local.labels
  #lineage_labels_mysql = local.lineage_labels_mysql
}
