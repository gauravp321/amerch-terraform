# BigQuery Tables - Mysql Employee
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_employee_employees" {
  dataset_id = google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_employee"].dataset_id
  table_id   = "employees"

  description = "This table stores comprehensive employee information. It includes personal details, contact information, employment status, and job-related attributes. The data facilitates human resources management, organizational reporting, and employee directory maintenance. It also supports analysis of workforce demographics and employee engagement."

  schema = jsonencode([
    {
      name        = "employeeid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the employee."
    },
    {
      name        = "companynum"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Company number of the employee."
    },
    {
      name        = "employeenum"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Employee number of the employee."
    },
    {
      name        = "firstname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First name of the employee."
    },
    {
      name        = "middleinitial"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Middle initial of the employee."
    },
    {
      name        = "lastname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Last name of the employee."
    },
    {
      name        = "department"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Department of the employee."
    },
    {
      name        = "nickname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Nickname of the employee."
    },
    {
      name        = "alignment"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alignment of the employee."
    },
    {
      name        = "divisionnum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Division number of the employee."
    },
    {
      name        = "regionnum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Region number of the employee."
    },
    {
      name        = "districtnum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "District number of the employee."
    },
    {
      name        = "territorynum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Territory number of the employee."
    },
    {
      name        = "voicemail"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Voicemail of the employee."
    },
    {
      name        = "empstatus"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employment status of the employee."
    },
    {
      name        = "hiredate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Hire date of the employee."
    },
    {
      name        = "officephonenum"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Office phone number of the employee."
    },
    {
      name        = "manager"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Manager of the employee."
    },
    {
      name        = "location"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Location of the employee."
    },
    {
      name        = "jobtitle"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Job title of the employee."
    },
    {
      name        = "jobcode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Job code of the employee."
    },
    {
      name        = "streetaddress"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address of the employee."
    },
    {
      name        = "streetaddress2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Secondary street address of the employee."
    },
    {
      name        = "city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City of the employee."
    },
    {
      name        = "state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State of the employee."
    },
    {
      name        = "zipcode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Zip code of the employee."
    },
    {
      name        = "country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country of the employee."
    },
    {
      name        = "email"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address of the employee."
    },
    {
      name        = "phonenum"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number of the employee."
    },
    {
      name        = "phonenumareacode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number area code of the employee."
    },
    {
      name        = "cellphone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Cell phone number of the employee."
    },
    {
      name        = "shipaddress"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Shipping address of the employee."
    },
    {
      name        = "shipaddress2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Secondary shipping address of the employee."
    },
    {
      name        = "shipcity"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Shipping city of the employee."
    },
    {
      name        = "shipstate"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Shipping state of the employee."
    },
    {
      name        = "shipzip"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Shipping zip code of the employee."
    },
    {
      name        = "shipcountry"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Shipping country of the employee."
    },
    {
      name        = "fullname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Full name of the employee."
    },
    {
      name        = "sortname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Sort name of the employee."
    },
    {
      name        = "termdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Termination date of the employee."
    },
    {
      name        = "managernum"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Manager number of the employee."
    },
    {
      name        = "chainnumbers"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Chain numbers associated with the employee."
    },
    {
      name        = "chainnames"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Chain names associated with the employee."
    },
    {
      name        = "paystatus"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Pay status of the employee."
    },
    {
      name        = "username"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Username of the employee."
    },
    {
      name        = "lastvoicemail"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Last voicemail of the employee."
    },
    {
      name        = "wd_region"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Workday region of the employee."
    },
    {
      name        = "wd_organization"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Workday organization of the employee."
    },
    {
      name        = "payratetype"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Pay rate type of the employee."
    },
    {
      name        = "devicetype"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Device type of the employee."
    },
    {
      name        = "costcentercode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Cost center code of the employee."
    },
    {
      name        = "locationreferenceid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Location reference identifier of the employee."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time the record was created."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the record."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Date and time the record was last modified."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who modified the record."
    },
    {
      name        = "i9_authorized"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Integer value indicating I-9 authorization status."
    },
    {
      name        = "contingent"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Integer value indicating contingent status."
    },
    {
      name        = "issyndicated"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Integer value indicating if the employee is syndicated."
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
      description = "Timestamp indicating when the record was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "employeeid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "employeeid",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_mysql)
  depends_on = [
    google_bigquery_dataset.datasets["${var.gcloud_mysql_dataset_prefix}_employee"]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_employee")
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_employee' must exist before creating table 'gcloud_mysql_performance_employee_employees'. Ensure the dataset is defined in var.datasets."
    }
  }
}
