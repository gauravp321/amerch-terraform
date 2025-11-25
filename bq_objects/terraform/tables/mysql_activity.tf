# BigQuery Tables - Mysql Activity
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_activity_campaignelements" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_activity"].dataset_id
  table_id   = "campaignelements"

  description = "This table stores information about campaign elements, which are individual components or activities within a larger marketing campaign. It tracks various attributes of these elements, including scheduling details, participant information, and billing status. The table also captures relationships between campaign elements, such as dependencies or follow-ups. This data allows for detailed analysis of campaign structure and execution."

  schema = jsonencode([
    {
      name        = "campaignelementid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the campaign element."
    },
    {
      name        = "campaignid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier for the campaign to which the element belongs."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the campaign element."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the type of the campaign element."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the status of the campaign element."
    },
    {
      name        = "notes"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Notes related to the campaign element."
    },
    {
      name        = "reviewerid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the reviewer of the campaign element."
    },
    {
      name        = "activity_day_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the day on which the activity takes place."
    },
    {
      name        = "startdatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the campaign element starts."
    },
    {
      name        = "enddatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the campaign element ends."
    },
    {
      name        = "defaultduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Default duration of the campaign element."
    },
    {
      name        = "importance"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Importance level of the campaign element."
    },
    {
      name        = "chain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Chain number associated with the campaign element."
    },
    {
      name        = "subchain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Subchain number associated with the campaign element."
    },
    {
      name        = "departmentid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the department associated with the campaign element."
    },
    {
      name        = "participantlist"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "List of participants for the campaign element."
    },
    {
      name        = "participantlistid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the participant list of the campaign element."
    },
    {
      name        = "tasktypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the task type of the campaign element."
    },
    {
      name        = "modeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the mode of the campaign element."
    },
    {
      name        = "dispatchmode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Mode of dispatch for the campaign element."
    },
    {
      name        = "surveyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the survey associated with the campaign element."
    },
    {
      name        = "participantcount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of participants involved in the campaign element."
    },
    {
      name        = "scheduledduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Scheduled duration of the campaign element."
    },
    {
      name        = "executionduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Duration of the campaign element's execution."
    },
    {
      name        = "priority_start"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element has a priority start."
    },
    {
      name        = "start_after_time"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Time after which the campaign element can start."
    },
    {
      name        = "start_before_time"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Time before which the campaign element must start."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the campaign element."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the campaign element was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the campaign element."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the campaign element was last modified."
    },
    {
      name        = "schedulinggroupid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the scheduling group of the campaign element."
    },
    {
      name        = "nonstandard"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element is non-standard."
    },
    {
      name        = "testactivity"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element is a test activity."
    },
    {
      name        = "retakeforeelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the retake element of the campaign element."
    },
    {
      name        = "defaultretaketypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the default retake type of the campaign element."
    },
    {
      name        = "excludedfromreporting"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element is excluded from reporting."
    },
    {
      name        = "releaseddate"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date when the campaign element was released."
    },
    {
      name        = "multipleinvoices"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether multiple invoices are allowed for the campaign element."
    },
    {
      name        = "billable"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element is billable."
    },
    {
      name        = "billableduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Duration for which the campaign element is billable."
    },
    {
      name        = "followupforelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the follow-up element of the campaign element."
    },
    {
      name        = "cancelreasonid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the reason for canceling the campaign element."
    },
    {
      name        = "cancelreasonother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other reason for canceling the campaign element."
    },
    {
      name        = "pickupforelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the pickup element of the campaign element."
    },
    {
      name        = "childforelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the child element of the campaign element."
    },
    {
      name        = "servicemodelcode"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Code representing the service model for the campaign element."
    },
    {
      name        = "siblingofelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the sibling element of the campaign element."
    },
    {
      name        = "expires"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element expires."
    },
    {
      name        = "submittedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the campaign element was submitted."
    },
    {
      name        = "submittedby"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the user who submitted the campaign element."
    },
    {
      name        = "releasedby"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the user who released the campaign element."
    },
    {
      name        = "releasingby"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the user who released the campaign element."
    },
    {
      name        = "scheduled"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the campaign element is scheduled."
    },
    {
      name        = "version"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Version number of the campaign element."
    },
    {
      name        = "escalationofelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the escalation element of the campaign element."
    },
    {
      name        = "groupforelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the group of the campaign element."
    },
    {
      name        = "alignment_hierarchy_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the alignment hierarchy of the campaign element."
    },
    {
      name        = "invoicegroupforelementid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the invoice group of the campaign element."
    },
    {
      name        = "generatedfromid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the element from which this element was generated."
    },
    {
      name        = "owner_employee_id"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the employee who owns the campaign element."
    },
    {
      name        = "allowanyupdate"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicates whether any update is allowed for the campaign element."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record was deleted in the source system."
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
    "campaignid",
    "campaignelementid",
    "chain",
  ]

  table_constraints {
    primary_key {
      columns = [
        "campaignelementid",
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
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_activity")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_activity' must exist before creating table 'gcloud_mysql_performance_activity_campaignelements'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_activity_activities" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_activity"].dataset_id
  table_id   = "activities"

  description = "This table stores information about scheduled activities. It tracks key details such as scheduling, completion status, and associated revenue. The table also captures information about employees involved in the activity, as well as relevant dates and times. This data supports analysis of activity performance and resource allocation."

  schema = jsonencode([
    {
      name        = "activityid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the activity."
    },
    {
      name        = "campaignelementid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The ID of the campaign element associated with the activity."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The ID representing the current status of the activity."
    },
    {
      name        = "notes"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Any notes or comments related to the activity."
    },
    {
      name        = "participant"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The number of participants involved in the activity."
    },
    {
      name        = "startdatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity is scheduled to start."
    },
    {
      name        = "enddatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity is scheduled to end."
    },
    {
      name        = "plannedduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The planned duration of the activity."
    },
    {
      name        = "preferredresource"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The preferred resource assigned to the activity."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user or system that created the activity."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user or system that last modified the activity."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity was last modified."
    },
    {
      name        = "divisionnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The division number associated with the activity."
    },
    {
      name        = "regionnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The region number associated with the activity."
    },
    {
      name        = "districtnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The district number associated with the activity."
    },
    {
      name        = "territorynumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The territory number associated with the activity."
    },
    {
      name        = "incompletereasonid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The ID of the reason why the activity was incomplete."
    },
    {
      name        = "incompletecomment"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A comment explaining why the activity was incomplete."
    },
    {
      name        = "dispatchedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The person or system that dispatched the activity."
    },
    {
      name        = "plannedcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The planned cost associated with the activity."
    },
    {
      name        = "scheduledrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The scheduled revenue amount for the activity."
    },
    {
      name        = "actualrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The actual revenue generated by the activity."
    },
    {
      name        = "earnedallocated"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The amount of revenue earned and allocated to the activity."
    },
    {
      name        = "shippingcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The shipping cost associated with the activity."
    },
    {
      name        = "shippingrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The shipping revenue associated with the activity."
    },
    {
      name        = "lastschedemployeeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The ID of the employee who last scheduled the activity."
    },
    {
      name        = "lastscheddate"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date the activity was last scheduled."
    },
    {
      name        = "completiondate"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity was completed."
    },
    {
      name        = "syscompletiondate"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The system completion date of the activity."
    },
    {
      name        = "completionemployeeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The ID of the employee who completed the activity."
    },
    {
      name        = "weekly_same_day_restriction"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if there is a weekly restriction to schedule the activity on the same day."
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
      description = "The timestamp when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "campaignelementid",
    "participant",
    "activityid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "activityid",
      ]
    }
    foreign_keys {
      name = "fk_activities_campaignelements"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_activity"].dataset_id
        project_id = var.project_id
        table_id   = "campaignelements"
      }
      column_references {
        referencing_column = "campaignelementid"
        referenced_column  = "campaignelementid"
      }
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
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_activity")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_activity' must exist before creating table 'gcloud_mysql_performance_activity_activities'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_activity_activityexecutions" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_activity"].dataset_id
  table_id   = "activityexecutions"

  description = "This table stores data about the execution of activities. It tracks the status, timing, and costs associated with each activity execution. The table also records information about the employees involved and any interruptions during the activity. This data can be used to analyze activity performance and resource allocation."

  schema = jsonencode([
    {
      name        = "activityexecutionid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the activity execution."
    },
    {
      name        = "activityid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier for the activity."
    },
    {
      name        = "employeeid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "The unique identifier of the employee who performed the activity."
    },
    {
      name        = "startdatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity execution started."
    },
    {
      name        = "enddatetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity execution ended."
    },
    {
      name        = "duration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The duration of the activity execution."
    },
    {
      name        = "interruptions"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of interruptions during the activity execution."
    },
    {
      name        = "userduration"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The duration entered by the user for the activity execution."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who created the activity execution."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity execution was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who last modified the activity execution."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The date and time the activity execution was last modified."
    },
    {
      name        = "userdurationreason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The reason provided by the user for the duration."
    },
    {
      name        = "basecost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The base cost associated with the activity execution."
    },
    {
      name        = "traveltime"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The travel time associated with the activity execution."
    },
    {
      name        = "travelcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The travel cost associated with the activity execution."
    },
    {
      name        = "overtimecost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The overtime cost associated with the activity execution."
    },
    {
      name        = "officecost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The office cost associated with the activity execution."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The identifier for the status of the activity execution."
    },
    {
      name        = "clockchain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The chain associated with the clock."
    },
    {
      name        = "clockstorenumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The store number associated with the clock."
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
      description = "The timestamp when the data was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "activityid",
    "employeeid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "activityexecutionid",
      ]
    }
    foreign_keys {
      name = "fk_activityexecutions_activities"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_activity"].dataset_id
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
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_activity")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_activity' must exist before creating table 'gcloud_mysql_performance_activity_activityexecutions'. Ensure the dataset is defined in var.datasets."
    }
  }
}
