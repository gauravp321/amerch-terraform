# Output dataset IDs
# Business Purpose: Provides a map of all dataset IDs for reference in other modules or scripts.
# Format: { dataset_id => dataset_id } (keys and values are the same, for consistency with other outputs)
output "dataset_ids" {
  description = "Map of all BigQuery dataset IDs. Keys and values are both dataset IDs for consistency with other outputs. Use this to reference datasets in other Terraform modules or scripts."
  value = {
    for k, v in google_bigquery_dataset.datasets : k => v.dataset_id
  }
}

# Output dataset locations
# Business Purpose: Provides dataset locations for data residency and compliance verification.
# Useful for ensuring data is stored in the correct region for compliance requirements.
output "dataset_locations" {
  description = "Map of dataset IDs to their GCP region locations. Use this to verify data residency and compliance with regional data storage requirements."
  value = {
    for k, v in google_bigquery_dataset.datasets : k => v.location
  }
}

# Output dataset friendly names
# Business Purpose: Provides human-readable dataset names for documentation and reporting.
# Friendly names are more readable than dataset IDs for non-technical stakeholders.
output "dataset_friendly_names" {
  description = "Map of dataset IDs to their friendly (human-readable) names. Use this for documentation, reporting, or displaying dataset information to non-technical users."
  value = {
    for k, v in google_bigquery_dataset.datasets : k => v.friendly_name
  }
}

# Output dataset count
# Business Purpose: Provides quick count of datasets for monitoring and validation.
# Useful for verifying expected number of datasets after deployment.
output "dataset_count" {
  description = "Total number of BigQuery datasets created by this module. Use this to verify the expected number of datasets after deployment."
  value       = length(google_bigquery_dataset.datasets)
}

# Note: Table-level outputs (table resource map, dataset-to-tables mapping, table counts per dataset)
# are not feasible without refactoring tables to use for_each. Since tables are defined as individual
# resources (not a map), Terraform cannot iterate over them in outputs. To add these outputs would
# require converting all 54 table resources to use for_each, which is a significant refactoring effort
# (see IAC-005: Large Monolithic Tables File). The enhanced descriptions above provide sufficient
# information for most use cases.
