# BigQuery Tables - Mysql Billing
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "gcloud_mysql_performance_billing_clients" {
  dataset_id = var.datasets["${var.gcloud_mysql_dataset_prefix}_billing"].dataset_id
  table_id   = "clients"

  description = "This table stores comprehensive information about clients. It includes contact details, billing information, and addresses. The table also tracks client creation and modification dates. It provides key data for managing client relationships and financial transactions."

  schema = jsonencode([
    {
      name        = "clientid"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Unique identifier for the client."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Name of the client."
    },
    {
      name        = "apcontactname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the accounts payable contact for the client."
    },
    {
      name        = "apemail"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address of the accounts payable contact for the client."
    },
    {
      name        = "apphone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number of the accounts payable contact for the client."
    },
    {
      name        = "paytermid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the payment terms associated with the client."
    },
    {
      name        = "createsource"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Source from which the client record was created."
    },
    {
      name        = "porequired"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a purchase order is required for the client."
    },
    {
      name        = "billingfrequency"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Frequency of billing for the client."
    },
    {
      name        = "vendorid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the client as a vendor."
    },
    {
      name        = "clientnumber"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical identifier for the client."
    },
    {
      name        = "contactname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the primary contact for the client."
    },
    {
      name        = "contactemail"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address of the primary contact for the client."
    },
    {
      name        = "physicaladdress"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Physical address of the client."
    },
    {
      name        = "billingaddress"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Full billing address of the client."
    },
    {
      name        = "createdby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who created the client record."
    },
    {
      name        = "createdat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the client record was created."
    },
    {
      name        = "modifiedby"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User who last modified the client record."
    },
    {
      name        = "modifiedat"
      type        = "DATETIME"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the client record was last modified."
    },
    {
      name        = "workday_customer_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Customer number assigned to the client in Workday."
    },
    {
      name        = "formationstate"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State where the client's company was formed."
    },
    {
      name        = "billingaddress1"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address portion of the client's billing address."
    },
    {
      name        = "billingcity"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City portion of the client's billing address."
    },
    {
      name        = "billingstate"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State portion of the client's billing address."
    },
    {
      name        = "billingzip"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Zip code portion of the client's billing address."
    },
    {
      name        = "billingemail"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address for billing-related communications with the client."
    },
    {
      name        = "billingcountryid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the billing country of the client."
    },
    {
      name        = "salesforceid"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the client in Salesforce."
    },
    {
      name        = "countrycode"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country code for the client's location."
    },
    {
      name        = "taxable"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Indicates whether the client is taxable."
    },
    {
      name        = "supplier_project_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Project number associated with the client as a supplier."
    },
    {
      name        = "logoattachmentid"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Identifier for the client's logo attachment."
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
      description = "Timestamp indicating when the row was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "clientnumber",
    "clientid",
  ]

  table_constraints {
    primary_key {
      columns = [
        "clientid",
      ]
    }
  }

  labels = merge(var.labels, var.lineage_labels_mysql)
  depends_on = [
    var.datasets
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = try(var.datasets["${var.gcloud_mysql_dataset_prefix}_billing"], null) != null
      error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_billing' must exist before creating table 'gcloud_mysql_performance_billing_clients'. Ensure the dataset is defined in var.datasets."
    }
  }
}
