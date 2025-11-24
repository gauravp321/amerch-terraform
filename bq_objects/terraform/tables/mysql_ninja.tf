# BigQuery Tables - Mysql Ninja
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_templates" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "templates"

  description = "This table stores information about templates. It tracks the creation, modification, and status of templates. The table also records details such as the template type, associated AI model, and approval status. It provides a historical record of template revisions and retirements."

  schema = jsonencode([
    {
      name        = "templateid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the template."
    },
    {
      name        = "templatenumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number assigned to the template."
    },
    {
      name        = "revisionnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number indicating the template's revision."
    },
    {
      name        = "islatest"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Integer indicating if the template is the latest version."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the template."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the template's status."
    },
    {
      name        = "repeattypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the template's repeat type."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the template type."
    },
    {
      name        = "dispositionid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the template's disposition."
    },
    {
      name        = "retiredby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who retired the template."
    },
    {
      name        = "approvedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who approved the template."
    },
    {
      name        = "submittedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who submitted the template."
    },
    {
      name        = "issaved"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Flag indicating if the template is saved."
    },
    {
      name        = "rejectreason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason for rejecting the template."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the template."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the template was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the template."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the template was last modified."
    },
    {
      name        = "ismultiexecution"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Flag indicating if the template supports multiple executions."
    },
    {
      name        = "discriminatorfieldid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a field used to differentiate templates."
    },
    {
      name        = "effectivedate"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date when the template becomes effective."
    },
    {
      name        = "aimodelid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the AI model associated with the template."
    },
    {
      name        = "owner_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the employee who owns the template."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Flag indicating if the row was deleted."
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
    "templateid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "templateid",
      ]
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_templates'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_fields" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "fields"

  description = "This table stores information about fields used within a system. It tracks various attributes and configurations associated with each field. The data includes settings for validation, display, and data capture. This allows for the management and customization of fields within the application."

  schema = jsonencode([
    {
      name        = "fieldid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "A unique integer identifier for the field."
    },
    {
      name        = "templateid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "An integer identifying the template associated with the field."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for the field type."
    },
    {
      name        = "label"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The text label for the field."
    },
    {
      name        = "instructions"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual instructions associated with the field."
    },
    {
      name        = "bucketid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for a bucket associated with the field."
    },
    {
      name        = "rank"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer representing the rank of the field."
    },
    {
      name        = "parentfieldid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for the parent field."
    },
    {
      name        = "optional"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer indicating whether the field is optional."
    },
    {
      name        = "minimum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The minimum acceptable integer value for the field."
    },
    {
      name        = "maximum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The maximum acceptable integer value for the field."
    },
    {
      name        = "floatmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The minimum acceptable value for a floating-point field."
    },
    {
      name        = "floatmax"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The maximum acceptable value for a floating-point field."
    },
    {
      name        = "datemin"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The earliest acceptable date for a date field."
    },
    {
      name        = "datemax"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The latest acceptable date for a date field."
    },
    {
      name        = "advancedvalidation"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether advanced validation is enabled."
    },
    {
      name        = "advancedvalidationoption"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer representing an advanced validation option."
    },
    {
      name        = "autoapprove"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer indicating whether automatic approval is enabled."
    },
    {
      name        = "multipleselection"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer indicating whether multiple selections are allowed."
    },
    {
      name        = "featureid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifying a feature associated with the field."
    },
    {
      name        = "exceptiontypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for an exception type."
    },
    {
      name        = "gradable"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the field is gradable."
    },
    {
      name        = "textcorrect"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The corrected text for a text field."
    },
    {
      name        = "numcorrect"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The corrected number for a numeric field."
    },
    {
      name        = "floatcorrect"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The corrected value for a floating-point field."
    },
    {
      name        = "datecorrect"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The corrected date for a date field."
    },
    {
      name        = "metadatainput"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual data representing metadata input for the field."
    },
    {
      name        = "metadatainputid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for metadata input."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who created the field."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the field was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who last modified the field."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the field was last modified."
    },
    {
      name        = "hierarchy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual data representing the hierarchical structure of the field."
    },
    {
      name        = "attachmentid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for an attachment."
    },
    {
      name        = "attachmentname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of an attachment associated with the field."
    },
    {
      name        = "itemattachmentnameid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for an item attachment name."
    },
    {
      name        = "aimmresponsemodulargroup"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual data related to a modular group of an AI-driven response."
    },
    {
      name        = "aimmresponsemodularsegment"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual data related to a modular segment of an AI-driven response."
    },
    {
      name        = "aimmresponsecapturephoto"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether photo capture is enabled for an AI-driven response."
    },
    {
      name        = "aimmresponsetraitcategory"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual data representing a trait category of an AI-driven response."
    },
    {
      name        = "scantypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for a scan type."
    },
    {
      name        = "aimmresponsecapturequantity"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether quantity capture is enabled for an AI-driven response."
    },
    {
      name        = "internalonly"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the field is for internal use only."
    },
    {
      name        = "aimmresponseshopcomordering"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether shop.com ordering is enabled for an AI-driven response."
    },
    {
      name        = "hyperlink"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A URL associated with the field."
    },
    {
      name        = "ailabelid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for an AI label."
    },
    {
      name        = "isaipicture"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer indicating whether the field is an AI picture."
    },
    {
      name        = "rootfieldid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer identifier for the root field."
    },
    {
      name        = "picislandscape"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "An integer indicating whether a picture is in landscape orientation."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the record was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "fieldid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_ninja_templates,
  ]

  table_constraints {
    primary_key {
      columns = [
        "fieldid",
      ]
    }
    foreign_keys {
      name = "fk_fields_templates"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "templates"
      }
      column_references {
        referencing_column = "templateid"
        referenced_column  = "templateid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_fields'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_responses" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "responses"

  description = "This table stores individual responses. It tracks the content of each response, along with creation and modification timestamps. The table also records who created and last modified each response. This data can be used to analyze response patterns and track changes over time."

  schema = jsonencode([
    {
      name        = "responseid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Integer representing the unique identifier for the response."
    },
    {
      name        = "responsetext"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String representing the text content of the response."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Datetime representing when the response was created."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String representing the user who created the response."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Datetime representing when the response was last modified."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String representing the user who last modified the response."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the row was marked as deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp representing when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "responseid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "responseid",
      ]
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_responses'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_fieldresponses" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "fieldresponses"

  description = "This table stores individual responses to specific fields within a form or survey. It tracks the association between responses and their corresponding fields. The table also captures metadata about the creation and modification of these responses. This allows for analysis of response data and tracking changes over time."

  schema = jsonencode([
    {
      name        = "fieldresponseid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the field response."
    },
    {
      name        = "fieldid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the field the response belongs to."
    },
    {
      name        = "responseid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the response."
    },
    {
      name        = "rank"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical ranking associated with the response."
    },
    {
      name        = "reportable"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical value indicating if the response is reportable."
    },
    {
      name        = "iscorrect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the response is correct."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the response."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the response was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the response."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the response was last modified."
    },
    {
      name        = "airesponsetypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the AI response type."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the record was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last synchronization with the source system."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "fieldid",
    "responseid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_ninja_fields,
    google_bigquery_table.gcloud_mysql_performance_ninja_responses,
  ]

  table_constraints {
    primary_key {
      columns = [
        "fieldresponseid",
      ]
    }
    foreign_keys {
      name = "fk_fieldresponses_fields"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "fields"
      }
      column_references {
        referencing_column = "fieldid"
        referenced_column  = "fieldid"
      }
    }
    foreign_keys {
      name = "fk_fieldresponses_responses"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "responses"
      }
      column_references {
        referencing_column = "responseid"
        referenced_column  = "responseid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_fieldresponses'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_datapoints" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "datapoints"

  description = "This table stores individual data points collected from a monitoring system. It tracks numerical or textual values associated with specific metrics. The table facilitates analysis of performance trends and identification of anomalies. It also allows for correlating data points with their associated status and collection context."

  schema = jsonencode([
    {
      name        = "datapointid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the data point."
    },
    {
      name        = "bucketid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the bucket associated with the data point."
    },
    {
      name        = "value"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The actual data value recorded for the data point."
    },
    {
      name        = "datacollectionid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the data collection associated with the data point."
    },
    {
      name        = "fieldid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the field associated with the data point."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the status of the data point."
    },
    {
      name        = "comments"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Any comments or notes related to the data point."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean flag indicating if the data point has been deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the data point was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "datapointid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "datapointid",
      ]
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_datapoints'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_datacollectionscans" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "datacollectionscans"

  description = "This table stores data related to the scanning of items. It records details about each scan event, including timestamps for creation and modification. The table facilitates tracking of scanned items and their associated quantities. It also captures information related to responses and data points associated with each scan."

  schema = jsonencode([
    {
      name        = "datacollectionscansid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the data collection scan event."
    },
    {
      name        = "datapointid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the data point associated with the scan."
    },
    {
      name        = "barcode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The processed or cleaned barcode string after the scan."
    },
    {
      name        = "qty"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The quantity of the item scanned."
    },
    {
      name        = "itemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The unique identifier for the item being scanned."
    },
    {
      name        = "aimmresponseid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The unique identifier for the response associated with the scan."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the scan event was created."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time when the scan event was last modified."
    },
    {
      name        = "rawbarcode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The raw barcode string captured during the scan."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating if the row was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp indicating when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "datapointid",
    "datacollectionscansid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "datacollectionscansid",
      ]
    }
    foreign_keys {
      name = "fk_datacollectionscans_items"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_item"].dataset_id
        project_id = var.project_id
        table_id   = "items"
      }
      column_references {
        referencing_column = "itemid"
        referenced_column  = "itemid"
      }
    }
    foreign_keys {
      name = "fk_datacollectionscans_datapoints"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "datapoints"
      }
      column_references {
        referencing_column = "datapointid"
        referenced_column  = "datapointid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_datacollectionscans'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_collectionrequests" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "collectionrequests"

  description = "This table stores information about collection requests. It tracks the status and activities associated with each request. The table also records creation and modification details, including who created and modified the request and when. This data can be used to analyze collection request workflows and performance."

  schema = jsonencode([
    {
      name        = "collectionrequestid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Unique identifier for the collection request."
    },
    {
      name        = "storeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the store associated with the collection request."
    },
    {
      name        = "employeeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the employee associated with the collection request."
    },
    {
      name        = "activityid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the activity associated with the collection request."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the status of the collection request."
    },
    {
      name        = "discriminator"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Discriminator value associated with the collection request."
    },
    {
      name        = "discriminatorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the discriminator associated with the collection request."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the collection request."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the collection request was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the collection request."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the collection request was last modified."
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
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "activityid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_coreapp_stores,
    google_bigquery_table.gcloud_mysql_performance_employee_employees,
    google_bigquery_table.gcloud_mysql_performance_activity_activities,
  ]

  table_constraints {
    primary_key {
      columns = [
        "collectionrequestid",
      ]
    }
    foreign_keys {
      name = "fk_collectionrequests_stores"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_coreapp"].dataset_id
        project_id = var.project_id
        table_id   = "stores"
      }
      column_references {
        referencing_column = "storeid"
        referenced_column  = "storeid"
      }
    }
    foreign_keys {
      name = "fk_collectionrequests_employees"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_employee"].dataset_id
        project_id = var.project_id
        table_id   = "employees"
      }
      column_references {
        referencing_column = "employeeid"
        referenced_column  = "employeeid"
      }
    }
    foreign_keys {
      name = "fk_collectionrequests_activities"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_activity"].dataset_id
        project_id = var.project_id
        table_id   = "activities"
      }
      column_references {
        referencing_column = "activityid"
        referenced_column  = "activityid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_collectionrequests'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_datacollections" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "datacollections"

  description = "This table stores data collection events. It tracks the lifecycle of data as it is gathered from various sources. The table records details about the origin, status, and timing of each data collection. It also includes identifiers for related entities, such as employees, stores, and items."

  schema = jsonencode([
    {
      name        = "datacollectionid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the data collection event."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier of the data collection type."
    },
    {
      name        = "templateid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the template used for data collection."
    },
    {
      name        = "storeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the store associated with the data collection."
    },
    {
      name        = "itemid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier of the item associated with the data collection."
    },
    {
      name        = "employeeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the employee associated with the data collection."
    },
    {
      name        = "serialnumber"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Serial number associated with the data collection."
    },
    {
      name        = "receivedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the data was received."
    },
    {
      name        = "start"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating the start time of the data collection event."
    },
    {
      name        = "collectionrequestid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the data collection request."
    },
    {
      name        = "clientid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the client associated with the data collection."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the data collection status."
    },
    {
      name        = "sourceid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the data source."
    },
    {
      name        = "originid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the data origin."
    },
    {
      name        = "processedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the data was processed."
    },
    {
      name        = "itemcounter"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Counter for the item."
    },
    {
      name        = "contextvalue"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contextual value associated with the data collection."
    },
    {
      name        = "elementversion"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Version number of the data element."
    },
    {
      name        = "durationseconds"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Duration of the data collection event in seconds."
    },
    {
      name        = "sourcetemplateid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the source template used for data collection."
    },
    {
      name        = "sourceitemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the item at the source."
    },
    {
      name        = "sourceitemcounter"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Counter for the item at the source."
    },
    {
      name        = "sourcestoreid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of the store at the source."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the record was deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the data was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "collectionrequestid",
    "employeeid",
    "itemid",
    "datacollectionid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_item_items,
    google_bigquery_table.gcloud_mysql_performance_coreapp_stores,
    google_bigquery_table.gcloud_mysql_performance_employee_employees,
    google_bigquery_table.gcloud_mysql_performance_ninja_collectionrequests,
    google_bigquery_table.gcloud_mysql_performance_ninja_templates,
  ]

  table_constraints {
    primary_key {
      columns = [
        "datacollectionid",
      ]
    }
    foreign_keys {
      name = "fk_datacollections_items"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_item"].dataset_id
        project_id = var.project_id
        table_id   = "items"
      }
      column_references {
        referencing_column = "itemid"
        referenced_column  = "itemid"
      }
    }
    foreign_keys {
      name = "fk_datacollections_stores"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_coreapp"].dataset_id
        project_id = var.project_id
        table_id   = "stores"
      }
      column_references {
        referencing_column = "storeid"
        referenced_column  = "storeid"
      }
    }
    foreign_keys {
      name = "fk_datacollections_employees"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_employee"].dataset_id
        project_id = var.project_id
        table_id   = "employees"
      }
      column_references {
        referencing_column = "employeeid"
        referenced_column  = "employeeid"
      }
    }
    foreign_keys {
      name = "fk_datacollections_collectionrequests"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "collectionrequests"
      }
      column_references {
        referencing_column = "collectionrequestid"
        referenced_column  = "collectionrequestid"
      }
    }
    foreign_keys {
      name = "fk_datacollections_templates"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "templates"
      }
      column_references {
        referencing_column = "templateid"
        referenced_column  = "templateid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_datacollections'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_aimmscandetails" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "aimmscandetails"

  description = "This table stores details related to image scan data. It records specific responses collected during the scans. The table also tracks the association of these responses with planograms and fixtures. This information is useful for analyzing product placement and performance within a retail environment."

  schema = jsonencode([
    {
      name        = "aimmscandetailsid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for each image scan detail record."
    },
    {
      name        = "datapointid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier for a specific data point within the scan."
    },
    {
      name        = "modname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the module associated with the scan."
    },
    {
      name        = "segment"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Segment associated with the scanned item."
    },
    {
      name        = "position"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Position of the item within the scan."
    },
    {
      name        = "responsevalue"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The recorded response value for a given data point."
    },
    {
      name        = "qty"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Quantity of the item recorded in the scan."
    },
    {
      name        = "upc"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Universal Product Code associated with the scanned item."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the scan detail record was created."
    },
    {
      name        = "itemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the item associated with the scan."
    },
    {
      name        = "planogramid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the planogram associated with the scan."
    },
    {
      name        = "fixtureid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the fixture associated with the scan."
    },
    {
      name        = "positionid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the position associated with the scan."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the row was deleted in the source."
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
    "datapointid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "aimmscandetailsid",
      ]
    }
    foreign_keys {
      name = "fk_aimmscandetails_datapoints"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "datapoints"
      }
      column_references {
        referencing_column = "datapointid"
        referenced_column  = "datapointid"
      }
    }
    foreign_keys {
      name = "fk_aimmscandetails_items"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_item"].dataset_id
        project_id = var.project_id
        table_id   = "items"
      }
      column_references {
        referencing_column = "itemid"
        referenced_column  = "itemid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_aimmscandetails'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_tags" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "tags"

  description = "This table stores information about tags used for categorization or labeling. It tracks creation and modification details for each tag. The table also captures relationships between tags. It includes information on who is responsible for each tag."

  schema = jsonencode([
    {
      name        = "tagid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the tag."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the tag."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A detailed explanation or summary of the tag."
    },
    {
      name        = "combinedwithid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier of another tag that this tag is combined with."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the tag."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the tag was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the tag."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the tag was last modified."
    },
    {
      name        = "responsiblepartyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the party responsible for the tag."
    },
    {
      name        = "fixtypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the fix type associated with the tag."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the tag has been deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the data was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "tagid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "tagid",
      ]
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_tags'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_ninja_fieldtags" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
  table_id   = "fieldtags"

  description = "This table stores the relationships between fields and tags. It tracks when these relationships were created and modified. The table also records who created and modified these associations. This data can be used to understand how fields are categorized and organized through tags."

  schema = jsonencode([
    {
      name        = "fieldtagid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Integer representing the unique identifier of the field tag."
    },
    {
      name        = "fieldid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Integer representing the unique identifier of the field."
    },
    {
      name        = "tagid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Integer representing the unique identifier of the tag."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String representing the user who created the field tag."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Datetime representing when the field tag was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String representing the user who last modified the field tag."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Datetime representing when the field tag was last modified."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the row was deleted."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp representing when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "fieldid",
    "tagid",
    "fieldtagid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_ninja_fields,
    google_bigquery_table.gcloud_mysql_performance_ninja_tags,
  ]

  table_constraints {
    primary_key {
      columns = [
        "fieldtagid",
      ]
    }
    foreign_keys {
      name = "fk_fieldtags_fields"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "fields"
      }
      column_references {
        referencing_column = "fieldid"
        referenced_column  = "fieldid"
      }
    }
    foreign_keys {
      name = "fk_fieldtags_tags"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_ninja"].dataset_id
        project_id = var.project_id
        table_id   = "tags"
      }
      column_references {
        referencing_column = "tagid"
        referenced_column  = "tagid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_ninja")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_ninja' must exist before creating table 'gcloud_mysql_performance_ninja_fieldtags'. Ensure the dataset is defined in var.datasets."
    }
  }
}
