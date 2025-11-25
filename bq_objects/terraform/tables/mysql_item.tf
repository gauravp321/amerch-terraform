# BigQuery Tables - Mysql Item
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_item_items" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_item"].dataset_id
  table_id   = "items"

  description = "This table stores information about items in an inventory or product catalog. It tracks item identification, descriptions, and codes. The table also records creation and modification details. It includes data related to item status and any associated barcode information."

  schema = jsonencode([
    {
      name        = "itemid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the item."
    },
    {
      name        = "upc"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The item's Universal Product Code."
    },
    {
      name        = "primeitemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The identifier of the primary item, potentially for variations or related items."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the item."
    },
    {
      name        = "description_2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A secondary description of the item."
    },
    {
      name        = "upcwithcheckdigit"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The item's UPC including the check digit."
    },
    {
      name        = "checkdigit"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The check digit associated with the item's UPC."
    },
    {
      name        = "barcodetype"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of barcode associated with the item."
    },
    {
      name        = "lockedforedit"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An indicator of whether the item is locked for editing."
    },
    {
      name        = "isdeleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean indicating if the item is marked as deleted."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who created the item."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the item was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who last modified the item."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the item was last modified."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean indicating if the item was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the data was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "itemid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "itemid",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_item"]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_item")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_item' must exist before creating table 'gcloud_mysql_performance_item_items'. Ensure the dataset is defined in var.datasets."
    }
  }
}
