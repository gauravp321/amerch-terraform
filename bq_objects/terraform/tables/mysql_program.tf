# BigQuery Tables - Mysql Program
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_program_programs" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"].dataset_id
  table_id   = "programs"

  description = "This table stores information about various programs. It includes details on program costs, revenue, and labor hours. The table also tracks program status, dates, and associated personnel. This data facilitates analysis of program performance and resource allocation."

  schema = jsonencode([
    {
      name        = "programid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the program."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the program type."
    },
    {
      name        = "statusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the program's status."
    },
    {
      name        = "vpdirempid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the VP director employee."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the program."
    },
    {
      name        = "multiple"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "A multiple value associated with the program."
    },
    {
      name        = "contactnotes"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Notes related to program contacts."
    },
    {
      name        = "summary"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A summary of the program."
    },
    {
      name        = "startdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The start date of the program."
    },
    {
      name        = "enddate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The end date of the program."
    },
    {
      name        = "chain"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the chain associated with the program."
    },
    {
      name        = "storecount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of stores associated with the program."
    },
    {
      name        = "visitsperstore"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of visits per store for the program."
    },
    {
      name        = "frequencyid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the program's frequency."
    },
    {
      name        = "frequencyother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other frequency description."
    },
    {
      name        = "annualvisits"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of annual visits for the program."
    },
    {
      name        = "averageminutes"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The average minutes spent on the program."
    },
    {
      name        = "revenueunitid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the revenue unit."
    },
    {
      name        = "revenueunitother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other revenue unit description."
    },
    {
      name        = "rateperunit"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The rate per unit for the program."
    },
    {
      name        = "laborrate"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The labor rate for the program."
    },
    {
      name        = "laborrateadmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The administrative labor rate."
    },
    {
      name        = "forecastedrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The forecasted revenue for the program."
    },
    {
      name        = "forecastedrevenueadmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The forecasted revenue for administrative tasks."
    },
    {
      name        = "totallaborhours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The total labor hours associated with the program."
    },
    {
      name        = "totallaborhoursadmin"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The total administrative labor hours for the program."
    },
    {
      name        = "effectivehourlyrate"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The effective hourly rate for the program."
    },
    {
      name        = "effectivehourlyrateadmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The effective hourly rate for administrative labor."
    },
    {
      name        = "totalforecastedcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total forecasted cost of the program."
    },
    {
      name        = "totalforecastedcostadmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total forecasted administrative cost."
    },
    {
      name        = "forecastbasis"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The basis for the program's forecast."
    },
    {
      name        = "timeandmotion"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "A time and motion value associated with the program."
    },
    {
      name        = "laborforecasttotal"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total forecasted labor cost."
    },
    {
      name        = "laborforecasttotaladmin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total forecasted administrative labor cost."
    },
    {
      name        = "totalannualrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total annual revenue of the program."
    },
    {
      name        = "totalannualhours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The total annual hours associated with the program."
    },
    {
      name        = "totalannualcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total annual cost of the program."
    },
    {
      name        = "averageowmiles"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The average one-way miles for the program."
    },
    {
      name        = "tripcharge"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The charge per trip for the program."
    },
    {
      name        = "tripsperstore"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of trips per store for the program."
    },
    {
      name        = "tripstorecount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of stores visited per trip."
    },
    {
      name        = "numberofshipments"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of shipments for the program."
    },
    {
      name        = "ratepershipment"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The rate per shipment for the program."
    },
    {
      name        = "costpershipment"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The cost per shipment for the program."
    },
    {
      name        = "shipmenttypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the shipment type."
    },
    {
      name        = "shipmenttypeother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other shipment type description."
    },
    {
      name        = "combined"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicator if the program is combined with another."
    },
    {
      name        = "unitspershipment"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of units per shipment."
    },
    {
      name        = "shipmentdescription"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the shipment."
    },
    {
      name        = "ratecategoryid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the rate category."
    },
    {
      name        = "submittedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who submitted the program."
    },
    {
      name        = "issaved"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicator if the program is saved."
    },
    {
      name        = "approvedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who approved the program."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who created the program."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The timestamp when the program was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The user who last modified the program."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The timestamp when the program was last modified."
    },
    {
      name        = "istest"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicator if the program is a test program."
    },
    {
      name        = "workday_datetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "The Workday datetime for the program."
    },
    {
      name        = "billable"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicator if the program is billable."
    },
    {
      name        = "salesforceid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Salesforce identifier for the program."
    },
    {
      name        = "createsource"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The source from which the program was created."
    },
    {
      name        = "teamtype"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the program's team type."
    },
    {
      name        = "accountmanagerid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the account manager."
    },
    {
      name        = "sowattachmentid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the statement of work attachment."
    },
    {
      name        = "csmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the customer success manager."
    },
    {
      name        = "cmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the customer manager."
    },
    {
      name        = "directorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the director."
    },
    {
      name        = "vpid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the VP."
    },
    {
      name        = "cemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the customer engagement manager."
    },
    {
      name        = "pmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the project manager."
    },
    {
      name        = "pcid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the program coordinator."
    },
    {
      name        = "ooid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the opportunity owner."
    },
    {
      name        = "revenue_csmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the customer success manager related to revenue."
    },
    {
      name        = "revenue_cmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the customer manager related to revenue."
    },
    {
      name        = "revenue_directorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the director related to revenue."
    },
    {
      name        = "revenue_vpid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the VP related to revenue."
    },
    {
      name        = "analystid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the analyst."
    },
    {
      name        = "retailerid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the retailer."
    },
    {
      name        = "retailersfid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Salesforce identifier for the retailer."
    },
    {
      name        = "retailername"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the retailer."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicator if the row was deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "chain",
    "programid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "programid",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_program")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_program' must exist before creating table 'gcloud_mysql_performance_program_programs'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_program_projects" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"].dataset_id
  table_id   = "projects"

  description = "This table stores comprehensive details about projects. It includes information on project assignments, timelines, and financial aspects. The table facilitates tracking project status, revenue, and associated resources. It also captures key relationships between projects, clients, and internal teams."

  schema = jsonencode([
    {
      name        = "projectid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the project."
    },
    {
      name        = "programid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier for the program to which the project belongs."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual description of the project."
    },
    {
      name        = "feetypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the fee type associated with the project."
    },
    {
      name        = "hourlyrateorstorefee"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Hourly rate or store fee associated with the project."
    },
    {
      name        = "startdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Start date of the project."
    },
    {
      name        = "enddate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "End date of the project."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the project."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the project was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the project."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time when the project was last modified."
    },
    {
      name        = "billable"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicates if the project is billable."
    },
    {
      name        = "workday_datetime"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time related to Workday."
    },
    {
      name        = "revenuespreadingmethodid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the revenue spreading method used for the project."
    },
    {
      name        = "shopcomclientid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the shop.com client associated with the project."
    },
    {
      name        = "sowrevenueamount"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Revenue amount specified in the Statement of Work for the project."
    },
    {
      name        = "sowhours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of hours specified in the Statement of Work for the project."
    },
    {
      name        = "projectmanager"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the project manager."
    },
    {
      name        = "status"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Status code of the project."
    },
    {
      name        = "reasonforvariance"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason for any variance related to the project."
    },
    {
      name        = "salesforceid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the project in Salesforce."
    },
    {
      name        = "createsource"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Source from which the project was created."
    },
    {
      name        = "sfopportunityid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the related Salesforce opportunity."
    },
    {
      name        = "shopcomcount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of shop.com related items for the project."
    },
    {
      name        = "clientname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the client associated with the project."
    },
    {
      name        = "csmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a customer success manager associated with the project."
    },
    {
      name        = "cmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a community manager associated with the project."
    },
    {
      name        = "directorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a director associated with the project."
    },
    {
      name        = "vpid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a VP associated with the project."
    },
    {
      name        = "cemid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a client engagement manager associated with the project."
    },
    {
      name        = "pmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a project manager associated with the project."
    },
    {
      name        = "pcid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier related to project costing."
    },
    {
      name        = "ooid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier related to opportunity."
    },
    {
      name        = "revenue_csmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a customer success manager associated with the project's revenue."
    },
    {
      name        = "revenue_cmid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a community manager associated with the project's revenue."
    },
    {
      name        = "revenue_directorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a director associated with the project's revenue."
    },
    {
      name        = "revenue_vpid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for a VP associated with the project's revenue."
    },
    {
      name        = "analystid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for an analyst associated with the project."
    },
    {
      name        = "typeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the type of project."
    },
    {
      name        = "weekly_same_day_restriction"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if there is a weekly same-day restriction for the project."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the record was deleted by Fivetran."
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
    "programid",
    "projectid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_program_programs,
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"]
  ]

  table_constraints {
    primary_key {
      columns = [
        "projectid",
      ]
    }
    foreign_keys {
      name = "fk_projects_programs"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"].dataset_id
        project_id = var.project_id
        table_id   = "programs"
      }
      column_references {
        referencing_column = "programid"
        referenced_column  = "programid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_program")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_program' must exist before creating table 'gcloud_mysql_performance_program_projects'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "gcloud_mysql_performance_program_laborbyweek" {
  dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"].dataset_id
  table_id   = "laborbyweek"

  description = "This table stores labor data aggregated on a weekly basis. It includes financial metrics related to project activities. The table tracks information about elements created, released, and pending. It also captures details about revenue, costs, and hours associated with labor."

  schema = jsonencode([
    {
      name        = "laborbyweekid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the labor record by week."
    },
    {
      name        = "projectid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Identifier for the project."
    },
    {
      name        = "createsource"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Source of creation."
    },
    {
      name        = "activityprojectid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the activity project."
    },
    {
      name        = "weekending"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date for the end of the week."
    },
    {
      name        = "labortypeid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the labor type."
    },
    {
      name        = "labortypeother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other labor type."
    },
    {
      name        = "elementcount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of elements."
    },
    {
      name        = "groupcount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of groups."
    },
    {
      name        = "storecount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of stores."
    },
    {
      name        = "storelistid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the store list."
    },
    {
      name        = "forecastrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Forecasted revenue amount."
    },
    {
      name        = "scheduledrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Scheduled revenue amount."
    },
    {
      name        = "actualrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Actual revenue amount."
    },
    {
      name        = "forecasthours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Forecasted hours."
    },
    {
      name        = "scheduledhours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Scheduled hours."
    },
    {
      name        = "forecastperhour"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Forecasted amount per hour."
    },
    {
      name        = "scheduledperhour"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Scheduled amount per hour."
    },
    {
      name        = "executionperhour"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Execution amount per hour."
    },
    {
      name        = "laborcost"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Labor cost amount."
    },
    {
      name        = "contribmargin"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Contribution margin amount."
    },
    {
      name        = "contribpct"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Contribution percentage."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the record."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the record was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who modified the record."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the record was modified."
    },
    {
      name        = "isuseractualrevenue"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether it is user actual revenue."
    },
    {
      name        = "activitycount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of activities."
    },
    {
      name        = "activityincomplete"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicates whether the activity is incomplete."
    },
    {
      name        = "earnedrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Earned revenue amount."
    },
    {
      name        = "earnedperhour"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Earned amount per hour."
    },
    {
      name        = "differencereasonid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the difference reason."
    },
    {
      name        = "differencereasonother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other reason for the difference."
    },
    {
      name        = "differencereasonearnedinvoicedid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the difference reason between earned and invoiced amounts."
    },
    {
      name        = "differencereasonearnedinvoicedother"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Other reason for the difference between earned and invoiced amounts."
    },
    {
      name        = "earnedstatusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the earned status."
    },
    {
      name        = "estinvoicedate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Estimated invoice date."
    },
    {
      name        = "accrualdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Accrual date."
    },
    {
      name        = "shipunits"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of shipped units."
    },
    {
      name        = "earnedadjustment"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Earned adjustment amount."
    },
    {
      name        = "earnedadjustmentreason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason for the earned adjustment."
    },
    {
      name        = "processedrevenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Processed revenue amount."
    },
    {
      name        = "salesforceid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier in Salesforce."
    },
    {
      name        = "elements_created"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of elements created."
    },
    {
      name        = "elements_pending"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of elements pending."
    },
    {
      name        = "elements_released"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of elements released."
    },
    {
      name        = "actualhours"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Actual hours."
    },
    {
      name        = "actualrph"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Actual revenue per hour."
    },
    {
      name        = "invoiced"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the activity is invoiced."
    },
    {
      name        = "reportingstatusid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the reporting status."
    },
    {
      name        = "sowrph"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Statement of Work revenue per hour."
    },
    {
      name        = "distinctstorecount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of distinct stores."
    },
    {
      name        = "dashboardcount"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of dashboards."
    },
    {
      name        = "trackernotes"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Notes associated with the tracker."
    },
    {
      name        = "earnediscalc"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the earned amount is calculated."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record was deleted by Fivetran."
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
    "projectid",
    "laborbyweekid",
  ]

  depends_on = [
    google_bigquery_table.gcloud_mysql_performance_program_projects,
    google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"]
  ]

  table_constraints {
    primary_key {
      columns = [
        "laborbyweekid",
      ]
    }
    foreign_keys {
      name = "fk_laborbyweek_projects"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.gcloud_mysql_dataset_prefix + "_program"].dataset_id
        project_id = var.project_id
        table_id   = "projects"
      }
      column_references {
        referencing_column = "projectid"
        referenced_column  = "projectid"
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
      condition     = contains(keys(google_bigquery_dataset.datasets), var.gcloud_mysql_dataset_prefix + "_program")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_program' must exist before creating table 'gcloud_mysql_performance_program_laborbyweek'. Ensure the dataset is defined in var.datasets."
    }
  }
}
