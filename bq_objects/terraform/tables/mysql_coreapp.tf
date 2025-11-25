# BigQuery Tables - Mysql Coreapp
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_coreapp_chains" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"].dataset_id
  table_id   = "chains"

  description = "This table stores information about different chains. It tracks creation and modification details for each chain. The table also includes data related to the chain's logo, syndication status, and demographic tab settings. It captures the current status of each chain."

  schema = jsonencode([
    {
      name        = "chainid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the chain."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Name of the chain."
    },
    {
      name        = "abbrev"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Abbreviated name or code for the chain."
    },
    {
      name        = "chain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical identifier for the chain."
    },
    {
      name        = "statusflag"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Flag indicating the current status of the chain."
    },
    {
      name        = "demographictabflag"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Flag indicating whether the demographic tab is enabled for the chain."
    },
    {
      name        = "incomm_merchant_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the merchant associated with the chain."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the chain record was created."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the chain record."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the chain record."
    },
    {
      name        = "modifiedat"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the chain record was last modified."
    },
    {
      name        = "logoattachmentid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the logo attachment associated with the chain."
    },
    {
      name        = "issyndicated"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Flag indicating whether the chain is syndicated."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the record was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "chain",
    "chainid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "chainid",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]
    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_coreapp")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_coreapp' must exist before creating table 'chains'. Ensure the dataset is defined in var.datasets with is_mysql=true and key='coreapp'."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_coreapp_stores" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"].dataset_id
  table_id   = "stores"

  description = "This table stores information about physical store locations. It includes details regarding store addresses, geographic coordinates, and various identifiers. The table also tracks store attributes, such as square footage and store type. It maintains information about store management and operational status."

  schema = jsonencode([
    {
      name        = "storeid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the store."
    },
    {
      name        = "chain"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The chain identifier to which the store belongs."
    },
    {
      name        = "storenumber"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The store number."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the store."
    },
    {
      name        = "address"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The physical street address of the store."
    },
    {
      name        = "city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The city in which the store is located."
    },
    {
      name        = "state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The state in which the store is located."
    },
    {
      name        = "zip"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The postal zip code of the store."
    },
    {
      name        = "phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The phone number of the store."
    },
    {
      name        = "fax"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The fax number of the store."
    },
    {
      name        = "divnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The division number associated with the store."
    },
    {
      name        = "divmgremployeenum"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The employee number of the divisional manager."
    },
    {
      name        = "divmgrcompanyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The company identifier of the divisional manager."
    },
    {
      name        = "divmgrname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the divisional manager."
    },
    {
      name        = "regnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The region number associated with the store."
    },
    {
      name        = "regmgremployeenum"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The employee number of the regional manager."
    },
    {
      name        = "regmgrcompanyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The company identifier of the regional manager."
    },
    {
      name        = "regmgrname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the regional manager."
    },
    {
      name        = "distnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The distribution number associated with the store."
    },
    {
      name        = "distmgremployeenum"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The employee number of the distribution manager."
    },
    {
      name        = "distmgrcompanyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The company identifier of the distribution manager."
    },
    {
      name        = "distmgrname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the distribution manager."
    },
    {
      name        = "terrnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The territory number associated with the store."
    },
    {
      name        = "alignment"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The alignment of the store."
    },
    {
      name        = "wmdivnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The Walmart division number associated with the store."
    },
    {
      name        = "wmregnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The Walmart region number associated with the store."
    },
    {
      name        = "wmdistnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The Walmart distribution number associated with the store."
    },
    {
      name        = "companyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The company identifier associated with the store."
    },
    {
      name        = "comment"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Any comments or notes related to the store."
    },
    {
      name        = "statusflag"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The status flag of the store."
    },
    {
      name        = "posessiondate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of possession for the store."
    },
    {
      name        = "shipdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of shipment to the store."
    },
    {
      name        = "grandopendate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of the grand opening of the store."
    },
    {
      name        = "status"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The status code of the store."
    },
    {
      name        = "specialinstructions"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Any special instructions related to the store."
    },
    {
      name        = "walmart_business_unit_number"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The business unit number associated with the Walmart store."
    },
    {
      name        = "store_manager_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the store manager."
    },
    {
      name        = "store_square_feet"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The square footage of the store."
    },
    {
      name        = "walmart_store_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of Walmart store."
    },
    {
      name        = "store_latitude"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The latitude coordinate of the store."
    },
    {
      name        = "store_longitude"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The longitude coordinate of the store."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the store record was created."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the user or system that created the store record."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the store record was last modified."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the user or system that last modified the store record."
    },
    {
      name        = "tdlinx_store_master_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The unique identifier for the store in the TDLinx system."
    },
    {
      name        = "customer_latitude"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The latitude coordinate of the customer."
    },
    {
      name        = "customer_longitude"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The longitude coordinate of the customer."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean flag indicating if the record was deleted in the source."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "chain",
    "storenumber",
  ]

  table_constraints {
    primary_key {
      columns = [
        "storeid",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_coreapp")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_coreapp' must exist before creating table 'gcloud_mysql_performance_coreapp_stores'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_coreapp_store_alignment" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"].dataset_id
  table_id   = "store_alignment"

  description = "This table tracks the alignment of employees to specific stores. It defines the hierarchical relationships between different employee roles and store locations. The table captures the effective dates for these alignments. It facilitates analysis of employee coverage and responsibilities across the organization."

  schema = jsonencode([
    {
      name        = "store_alignment_id"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the store alignment record."
    },
    {
      name        = "start_date"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date when the alignment became effective."
    },
    {
      name        = "storeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the store."
    },
    {
      name        = "chain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the chain."
    },
    {
      name        = "storenumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the store."
    },
    {
      name        = "divnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the division."
    },
    {
      name        = "regnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the region."
    },
    {
      name        = "distnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the district."
    },
    {
      name        = "terrnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number identifying the territory."
    },
    {
      name        = "divisional_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the divisional employee."
    },
    {
      name        = "regional_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the regional employee."
    },
    {
      name        = "dm_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the district manager employee."
    },
    {
      name        = "sales_rep_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the sales representative employee."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the record was deleted in the source system."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the record was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "storeid",
    "store_alignment_id",
  ]

  depends_on = [
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"],
    google_bigquery_table.gcloud_mysql_performance_coreapp_chains,
    google_bigquery_table.gcloud_mysql_performance_coreapp_stores,
  ]

  table_constraints {
    primary_key {
      columns = [
        "store_alignment_id",
      ]
    }
    foreign_keys {
      name = "fk_store_alignment_stores"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_coreapp"].dataset_id
        project_id = var.project_id
        table_id   = "stores"
      }
      column_references {
        referencing_column = "storeid"
        referenced_column  = "storeid"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_coreapp")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_coreapp' must exist before creating table 'gcloud_mysql_performance_coreapp_store_alignment'. Ensure the dataset is defined in var.datasets."
    }
  }
}
