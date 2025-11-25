# BigQuery Tables - Mysql Alignment
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_alignment_alignments_v2" {
  dataset_id =  google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_alignment"].dataset_id
  table_id   = "alignments_v2"

  description = "This table stores information about different alignments within an organization. It tracks the hierarchical structure of these alignments. The table records creation and modification timestamps. It also stores codes and descriptions associated with each alignment."

  schema = jsonencode([
    {
      name        = "alignment_id"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the alignment."
    },
    {
      name        = "parent_alignment_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the parent alignment."
    },
    {
      name        = "alignment_hierarchy_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the alignment hierarchy."
    },
    {
      name        = "alignment_level_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the level of the alignment."
    },
    {
      name        = "alignment_number"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical identifier for the alignment."
    },
    {
      name        = "alignment_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code associated with the alignment."
    },
    {
      name        = "alignment_description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual description of the alignment."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the alignment was created."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the alignment."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the alignment was last modified."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the alignment."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the alignment was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "alignment_id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "alignment_id",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
     google_bigquery_dataset.datasets
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_alignment")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_alignment' must exist before creating table 'gcloud_mysql_performance_alignment_alignments_v2'. Ensure the dataset is defined in var.datasets."
    }
  }
}
