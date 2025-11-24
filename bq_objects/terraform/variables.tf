variable "project_id" {
  description = "The GCP project ID where BigQuery resources will be created. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be a valid GCP project ID (lowercase letters, numbers, hyphens, 6-30 characters)."
  }
}

variable "region" {
  description = "The GCP region for BigQuery datasets. Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
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

variable "gcloud_mysql_dataset_prefix" {
  description = "Prefix for MySQL dataset names (e.g., 'raw_fivetran_gcloud_performance' for datasets like raw_fivetran_gcloud_performance_coreapp). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z_][a-z0-9_]{0,99}$", var.gcloud_mysql_dataset_prefix)) && length(var.gcloud_mysql_dataset_prefix) >= 1 && length(var.gcloud_mysql_dataset_prefix) <= 100
    error_message = "Dataset prefix must be 1-100 characters, start with lowercase letter or underscore, and contain only lowercase letters, numbers, and underscores."
  }
}

variable "salesforce_dataset_prefix" {
  description = "Prefix for Salesforce dataset names (e.g., 'raw_fivetran_salesforce' for dataset like raw_fivetran_salesforce). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z_][a-z0-9_]{0,99}$", var.salesforce_dataset_prefix)) && length(var.salesforce_dataset_prefix) >= 1 && length(var.salesforce_dataset_prefix) <= 100
    error_message = "Dataset prefix must be 1-100 characters, start with lowercase letter or underscore, and contain only lowercase letters, numbers, and underscores."
  }
}

variable "workday_hcm_dataset_prefix" {
  description = "Prefix for Workday HCM dataset names (e.g., 'raw_fivetran_workday_hcm' for the workday_hcm dataset). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = string
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition     = can(regex("^[a-z_][a-z0-9_]{0,99}$", var.workday_hcm_dataset_prefix)) && length(var.workday_hcm_dataset_prefix) >= 1 && length(var.workday_hcm_dataset_prefix) <= 100
    error_message = "Dataset prefix must be 1-100 characters, start with lowercase letter or underscore, and contain only lowercase letters, numbers, and underscores."
  }
}

variable "datasets" {
  description = "Map of dataset keys and their configurations. For MySQL datasets, use suffixes (e.g., 'coreapp') which will be prefixed with gcloud_mysql_dataset_prefix. For Salesforce and Workday HCM, the prefix is used directly (no suffix). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type = map(object({
    friendly_name  = string
    description    = string
    location       = string
    labels         = map(string)
    is_mysql       = bool
    is_salesforce  = bool
    is_workday_hcm = bool
  }))
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment
  # See terraform.tfvars.example for the required dataset configuration

  validation {
    condition = alltrue([
      for key, config in var.datasets : (
        # Dataset key validation: 1-1024 chars, start with letter or underscore, contain only letters, numbers, underscores
        can(regex("^[a-zA-Z_][a-zA-Z0-9_]{0,1023}$", key)) &&
        length(key) >= 1 &&
        length(key) <= 1024 &&
        # Location must be non-empty (GCP will validate the actual location value)
        length(config.location) > 0 &&
        # Validate labels within dataset config (handle empty maps)
        length(config.labels) == 0 || alltrue([
          for label_key, label_value in config.labels : (
            can(regex("^[a-z][a-z0-9_-]{0,62}$", label_key)) &&
            length(label_key) >= 1 &&
            length(label_key) <= 63 &&
            can(regex("^[a-z0-9_-]*$", label_value)) &&
            length(label_value) >= 0 &&
            length(label_value) <= 63
          )
        ])
      )
    ])
    error_message = "Dataset keys must be 1-1024 characters, start with letter or underscore, and contain only letters, numbers, and underscores. Location must be non-empty. Labels must follow GCP label constraints (keys: 1-63 chars starting with lowercase letter; values: 0-63 chars, lowercase alphanumeric with hyphens/underscores only, no dots)."
  }
}

variable "labels" {
  description = "Common labels to apply to all resources (project-specific labels are added automatically). Must be explicitly set in terraform.tfvars (no default to prevent environment coupling)."
  type        = map(string)
  # No default - must be explicitly set in terraform.tfvars to prevent accidental cross-environment deployment

  validation {
    condition = alltrue([
      for key, value in var.labels : (
        # Label key validation: 1-63 chars, start with lowercase letter, contain only lowercase letters, numbers, hyphens, underscores
        can(regex("^[a-z][a-z0-9_-]{0,62}$", key)) &&
        length(key) >= 1 &&
        length(key) <= 63 &&
        # Label value validation: 0-63 chars, contain only lowercase letters, numbers, hyphens, underscores (no dots)
        can(regex("^[a-z0-9_-]*$", value)) &&
        length(value) >= 0 &&
        length(value) <= 63
      )
    ])
    error_message = "Label keys must be 1-63 characters, start with lowercase letter, and contain only lowercase letters, numbers, hyphens, and underscores. Label values must be 0-63 characters and contain only lowercase letters, numbers, hyphens, and underscores (no dots allowed)."
  }
}
