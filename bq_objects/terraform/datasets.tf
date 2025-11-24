# Create all BigQuery datasets
# Business Purpose: Datasets serve as containers for BigQuery tables, organizing data by source system
# (MySQL Performance, Salesforce, Workday HCM) and providing access control boundaries.
# Design Decision: Uses for_each with local.dataset_ids to avoid duplicating dataset ID computation logic.
# All datasets use prevent_destroy lifecycle to prevent accidental data loss.
# Datasets are created with null expiration (no automatic table expiration) per architect decision.
resource "google_bigquery_dataset" "datasets" {
  for_each = {
    for dataset_id, key in local.dataset_ids : dataset_id => var.datasets[key]
  }

  dataset_id                  = each.key
  friendly_name               = each.value.friendly_name
  description                 = each.value.description
  location                    = each.value.location != "" ? each.value.location : var.region
  default_table_expiration_ms = null
  delete_contents_on_destroy  = false

  labels = merge(local.labels, each.value.labels)

  # Prevent accidental deletion of datasets and their contents
  lifecycle {
    prevent_destroy = true
  }
}
