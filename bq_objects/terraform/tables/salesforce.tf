# BigQuery Tables - Salesforce
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "salesforce_retailer_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "retailer_c"

  description = "This table stores information about retailers and references the owning user."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the retailer record."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who owns the retailer record."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the retailer record is deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the retailer."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the retailer record was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the retailer record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last modification to the retailer record."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the retailer record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification to the retailer record."
    },
    {
      name        = "enabled_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "String value indicating if the retailer is enabled."
    },
    {
      name        = "name_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom name of the retailer."
    },
    {
      name        = "retailer_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier for the retailer."
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
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
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
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_retailer_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_account" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "account"

  description = "This table stores comprehensive information about accounts, which represent customers or business partners. It includes details on location, contact information, financial data, and various business-related attributes. The table facilitates account management, sales analysis, and reporting. It also tracks key dates, integration statuses, and relevant identifiers for each account."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the account."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the account is deleted."
    },
    {
      name        = "master_record_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the master record for the account."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the account."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of account."
    },
    {
      name        = "record_type_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the record type for the account."
    },
    {
      name        = "parent_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the parent account."
    },
    {
      name        = "billing_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The street address of the billing address."
    },
    {
      name        = "billing_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The city of the billing address."
    },
    {
      name        = "billing_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The state of the billing address."
    },
    {
      name        = "billing_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The postal code of the billing address."
    },
    {
      name        = "billing_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The country of the billing address."
    },
    {
      name        = "billing_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The latitude of the billing address."
    },
    {
      name        = "billing_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The longitude of the billing address."
    },
    {
      name        = "billing_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The geocode accuracy of the billing address."
    },
    {
      name        = "shipping_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The street address of the shipping address."
    },
    {
      name        = "shipping_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The city of the shipping address."
    },
    {
      name        = "shipping_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The state of the shipping address."
    },
    {
      name        = "shipping_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The postal code of the shipping address."
    },
    {
      name        = "shipping_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The country of the shipping address."
    },
    {
      name        = "shipping_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The latitude of the shipping address."
    },
    {
      name        = "shipping_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The longitude of the shipping address."
    },
    {
      name        = "shipping_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The geocode accuracy of the shipping address."
    },
    {
      name        = "phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The phone number of the account."
    },
    {
      name        = "fax"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The fax number of the account."
    },
    {
      name        = "account_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The account number."
    },
    {
      name        = "website"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The website address of the account."
    },
    {
      name        = "photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The URL of the account's photo."
    },
    {
      name        = "sic"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Standard Industrial Classification code for the account."
    },
    {
      name        = "industry"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The industry of the account."
    },
    {
      name        = "annual_revenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The annual revenue of the account."
    },
    {
      name        = "number_of_employees"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The number of employees at the account."
    },
    {
      name        = "ownership"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ownership type of the account."
    },
    {
      name        = "ticker_symbol"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ticker symbol of the account's company."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the account."
    },
    {
      name        = "rating"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The rating of the account."
    },
    {
      name        = "site"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The site associated with the account."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the account owner."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the account was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the user who created the account."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the account was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the user who last modified the account."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp of the last system modification."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of the last activity for the account."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the account was last viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the account was last referenced."
    },
    {
      name        = "source_system_identifier"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The identifier of the source system for the account."
    },
    {
      name        = "jigsaw"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Jigsaw identifier for the account."
    },
    {
      name        = "jigsaw_company_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Jigsaw company identifier for the account."
    },
    {
      name        = "account_source"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The source of the account."
    },
    {
      name        = "sic_desc"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The description of the Standard Industrial Classification code for the account."
    },
    {
      name        = "is_priority_record"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the account is a priority record."
    },
    {
      name        = "account_on_hold_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the account is on hold."
    },
    {
      name        = "annual_walmart_budget_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The annual Walmart budget for the account."
    },
    {
      name        = "payment_terms_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The payment terms for the account."
    },
    {
      name        = "chain_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The chain associated with the account."
    },
    {
      name        = "ap_contact_name_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable contact name."
    },
    {
      name        = "ap_email_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable email address."
    },
    {
      name        = "ap_phone_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable phone number."
    },
    {
      name        = "annual_merchandising_budget_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The annual merchandising budget for the account."
    },
    {
      name        = "billing_email_address_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The billing email address for the account."
    },
    {
      name        = "billing_email_cc_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The billing email CC address for the account."
    },
    {
      name        = "client_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of client the account is."
    },
    {
      name        = "current_contract_expiration_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The expiration date of the current contract for the account."
    },
    {
      name        = "market_share_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The market share of the account."
    },
    {
      name        = "open_receivables_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The amount of open receivables for the account."
    },
    {
      name        = "state_of_incorporation_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The state where the account was incorporated."
    },
    {
      name        = "supplier_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The supplier identifier for the account."
    },
    {
      name        = "workday_account_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Workday account number."
    },
    {
      name        = "ap_billing_city_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable billing city."
    },
    {
      name        = "ap_billing_state_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable billing state."
    },
    {
      name        = "ap_billing_street_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable billing street address."
    },
    {
      name        = "ap_billing_zip_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounts payable billing zip code."
    },
    {
      name        = "current_walmart_psp_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The current Walmart PSP associated with the account."
    },
    {
      name        = "department_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The department associated with the account."
    },
    {
      name        = "store_number_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The store number for the account."
    },
    {
      name        = "fax_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The fax number for the account."
    },
    {
      name        = "division_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The division associated with the account."
    },
    {
      name        = "divisional_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The divisional manager assigned to the account."
    },
    {
      name        = "region_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The region associated with the account."
    },
    {
      name        = "regional_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The regional manager assigned to the account."
    },
    {
      name        = "district_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The district associated with the account."
    },
    {
      name        = "district_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The district manager assigned to the account."
    },
    {
      name        = "territory_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The territory assigned to the account."
    },
    {
      name        = "store_count_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of stores associated with the account."
    },
    {
      name        = "dash_chain_district_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The district manager of the chain associated with the account."
    },
    {
      name        = "dash_chain_district_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The district number of the chain associated with the account."
    },
    {
      name        = "dash_chain_division_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The division manager of the chain associated with the account."
    },
    {
      name        = "dash_chain_division_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The division number of the chain associated with the account."
    },
    {
      name        = "dash_chain_region_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The region manager of the chain associated with the account."
    },
    {
      name        = "dash_chain_region_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The region number of the chain associated with the account."
    },
    {
      name        = "dash_chain_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The chain associated with the account."
    },
    {
      name        = "dash_retailer_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The retailer identifier associated with the account."
    },
    {
      name        = "dash_store_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The store identifier associated with the account."
    },
    {
      name        = "dash_store_manager_name_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The store manager name associated with the account."
    },
    {
      name        = "dash_store_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The store number associated with the account."
    },
    {
      name        = "dash_store_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The store type associated with the account."
    },
    {
      name        = "underlying_rph_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The underlying RPH value for the account."
    },
    {
      name        = "country_code_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The country code for the account."
    },
    {
      name        = "billing_frequency_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The billing frequency for the account."
    },
    {
      name        = "integrated_with_dash_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the account is integrated with the DASH system."
    },
    {
      name        = "integration_result_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The result of the integration process for the account."
    },
    {
      name        = "po_required_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a purchase order is required for the account."
    },
    {
      name        = "dozisf_zoom_info_first_updated_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when ZoomInfo data was first updated for the account."
    },
    {
      name        = "dozisf_zoom_info_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ZoomInfo identifier for the account."
    },
    {
      name        = "dozisf_zoom_info_last_updated_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when ZoomInfo data was last updated for the account."
    },
    {
      name        = "taxable_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Indicates whether the account is taxable."
    },
    {
      name        = "retailer_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The retailer associated with the account."
    },
    {
      name        = "msa_expiration_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The expiration date of the Master Service Agreement for the account."
    },
    {
      name        = "msa_link_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The link to the Master Service Agreement for the account."
    },
    {
      name        = "msa_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a Master Service Agreement exists for the account."
    },
    {
      name        = "nda_expiration_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The expiration date of the Non-Disclosure Agreement for the account."
    },
    {
      name        = "nda_link_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The link to the Non-Disclosure Agreement for the account."
    },
    {
      name        = "nda_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a Non-Disclosure Agreement exists for the account."
    },
    {
      name        = "dash_integration_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The integration status with the DASH system for the account."
    },
    {
      name        = "invoice_granularity_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The invoice granularity for the account."
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
      description = "The timestamp when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_account_retailer_c"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "retailer_c"
      }
      column_references {
        referencing_column = "retailer_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
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
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_account'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_contact" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "contact"

  description = "This table stores comprehensive information about individual contacts. It includes personal details, contact information, and communication preferences, with links to accounts and owners."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the contact record."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact record is deleted."
    },
    {
      name        = "master_record_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the master record if the contact is a duplicate."
    },
    {
      name        = "account_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the account associated with the contact."
    },
    {
      name        = "last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Last name of the contact."
    },
    {
      name        = "first_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First name of the contact."
    },
    {
      name        = "salutation"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Salutation used for the contact (e.g., Mr., Ms.)."
    },
    {
      name        = "middle_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Middle name of the contact."
    },
    {
      name        = "suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Suffix used for the contact's name (e.g., Jr., Sr.)."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Full name of the contact."
    },
    {
      name        = "record_type_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the record type of the contact."
    },
    {
      name        = "other_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address in the contact's alternative address."
    },
    {
      name        = "other_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City in the contact's alternative address."
    },
    {
      name        = "other_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State in the contact's alternative address."
    },
    {
      name        = "other_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code for the contact's alternative address."
    },
    {
      name        = "other_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country in the contact's alternative address."
    },
    {
      name        = "other_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude coordinate of the contact's alternative address."
    },
    {
      name        = "other_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude coordinate of the contact's alternative address."
    },
    {
      name        = "other_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Geocoding accuracy level for the contact's alternative address."
    },
    {
      name        = "mailing_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address in the contact's mailing address."
    },
    {
      name        = "mailing_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City in the contact's mailing address."
    },
    {
      name        = "mailing_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State in the contact's mailing address."
    },
    {
      name        = "mailing_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code in the contact's mailing address."
    },
    {
      name        = "mailing_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country in the contact's mailing address."
    },
    {
      name        = "mailing_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude coordinate of the contact's mailing address."
    },
    {
      name        = "mailing_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude coordinate of the contact's mailing address."
    },
    {
      name        = "mailing_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Geocoding accuracy level for the contact's mailing address."
    },
    {
      name        = "phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Primary phone number of the contact."
    },
    {
      name        = "fax"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Fax number of the contact."
    },
    {
      name        = "mobile_phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contact's mobile phone number."
    },
    {
      name        = "home_phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contact's home phone number."
    },
    {
      name        = "other_phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alternative phone number for the contact."
    },
    {
      name        = "assistant_phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number of the contact's assistant."
    },
    {
      name        = "reports_to_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the contact's reporting manager."
    },
    {
      name        = "email"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address of the contact."
    },
    {
      name        = "title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Job title of the contact."
    },
    {
      name        = "department"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Department the contact belongs to."
    },
    {
      name        = "assistant_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the contact's assistant."
    },
    {
      name        = "lead_source"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Source of the contact's lead."
    },
    {
      name        = "birthdate"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of birth of the contact."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description or notes about the contact."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the contact's owner."
    },
    {
      name        = "has_opted_out_of_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact has opted out of receiving emails."
    },
    {
      name        = "has_opted_out_of_fax"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact has opted out of receiving faxes."
    },
    {
      name        = "do_not_call"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact has requested not to be called."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the contact record was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the contact record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last time the contact record was modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the contact record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification to the contact record."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of the contact's last activity."
    },
    {
      name        = "last_curequest_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last CU request."
    },
    {
      name        = "last_cuupdate_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last CU update."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last time the contact's record was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last time the contact record was referenced."
    },
    {
      name        = "email_bounced_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason for email bounce."
    },
    {
      name        = "email_bounced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the contact's email bounced."
    },
    {
      name        = "is_email_bounced"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether emails to the contact have bounced."
    },
    {
      name        = "photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the contact's photo."
    },
    {
      name        = "jigsaw"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Jigsaw identifier for the contact."
    },
    {
      name        = "jigsaw_contact_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the contact in Jigsaw."
    },
    {
      name        = "individual_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the individual associated with the contact."
    },
    {
      name        = "is_priority_record"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact record is a priority."
    },
    {
      name        = "contact_source"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Source from which the contact information was obtained."
    },
    {
      name        = "title_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of title held by the contact."
    },
    {
      name        = "department_group"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Group or category of the contact's department."
    },
    {
      name        = "buyer_attributes"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Attributes of the contact as a buyer."
    },
    {
      name        = "employee_number_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Numerical employee number associated with the contact."
    },
    {
      name        = "department_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Department associated with the contact."
    },
    {
      name        = "caller_role_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Role of the caller associated with the contact."
    },
    {
      name        = "company_cell_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Cell phone number associated with the contact's company."
    },
    {
      name        = "division_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Numerical value representing the division associated with the contact."
    },
    {
      name        = "divisional_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name or identifier of the divisional manager associated with the contact."
    },
    {
      name        = "region_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Numerical value representing the region associated with the contact."
    },
    {
      name        = "regional_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name or identifier of the regional manager associated with the contact."
    },
    {
      name        = "district_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Numerical value representing the district associated with the contact."
    },
    {
      name        = "district_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name or identifier of the district manager associated with the contact."
    },
    {
      name        = "territory_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Numerical value representing the territory associated with the contact."
    },
    {
      name        = "caller_s_title_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Title of the caller associated with the contact."
    },
    {
      name        = "alternate_contact_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "An alternate phone number for the contact."
    },
    {
      name        = "alignment_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alignment associated with the contact."
    },
    {
      name        = "dash_alignment_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the alignment associated with the contact."
    },
    {
      name        = "dash_company_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Company number associated with the contact."
    },
    {
      name        = "dash_employee_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employee identifier associated with the contact."
    },
    {
      name        = "dash_employee_number_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employee number associated with the contact."
    },
    {
      name        = "dash_job_code_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Job code associated with the contact."
    },
    {
      name        = "dozisf_zoom_info_company_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the contact's company in ZoomInfo."
    },
    {
      name        = "dozisf_zoom_info_first_updated_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the first update from ZoomInfo."
    },
    {
      name        = "dozisf_zoom_info_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the contact in ZoomInfo."
    },
    {
      name        = "dozisf_zoom_info_last_updated_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last update from ZoomInfo."
    },
    {
      name        = "pi_needs_score_synced_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact's score needs to be synced in Pardot."
    },
    {
      name        = "pi_pardot_last_scored_at_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the contact was scored in Pardot."
    },
    {
      name        = "pi_campaign_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Campaign associated with the contact in Pardot."
    },
    {
      name        = "pi_comments_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Comments related to the contact in Pardot."
    },
    {
      name        = "pi_conversion_date_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date of the contact's conversion in Pardot."
    },
    {
      name        = "pi_conversion_object_name_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the conversion object associated with the contact in Pardot."
    },
    {
      name        = "pi_conversion_object_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of conversion object associated with the contact in Pardot."
    },
    {
      name        = "pi_created_date_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of when the contact was created in Pardot."
    },
    {
      name        = "pi_first_activity_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the contact's first activity tracked by Pardot."
    },
    {
      name        = "pi_first_search_term_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First search term used by the contact, tracked by Pardot."
    },
    {
      name        = "pi_first_search_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of first search used by the contact, tracked by Pardot."
    },
    {
      name        = "pi_first_touch_url_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First touch URL associated with the contact in Pardot."
    },
    {
      name        = "pi_grade_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Grade assigned to the contact in Pardot."
    },
    {
      name        = "pi_last_activity_c"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the contact's last activity tracked by Pardot."
    },
    {
      name        = "pi_notes_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Notes related to the contact in Pardot."
    },
    {
      name        = "pi_pardot_hard_bounced_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact has hard bounced in Pardot."
    },
    {
      name        = "pi_score_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Score assigned to the contact in Pardot."
    },
    {
      name        = "pi_url_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL associated with the contact in Pardot."
    },
    {
      name        = "pi_utm_campaign_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "UTM campaign associated with the contact's interaction."
    },
    {
      name        = "pi_utm_content_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "UTM content associated with the contact's interaction."
    },
    {
      name        = "pi_utm_medium_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "UTM medium associated with the contact's interaction."
    },
    {
      name        = "pi_utm_source_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "UTM source associated with the contact's interaction."
    },
    {
      name        = "pi_utm_term_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "UTM term associated with the contact's interaction."
    },
    {
      name        = "inactive_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the contact is inactive."
    },
    {
      name        = "retailer_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Text identifier for the retailer associated with the contact."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating whether the record was deleted by Fivetran."
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
    "id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_contact_account"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "account"
      }
      column_references {
        referencing_column = "account_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
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
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_contact'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_program_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "program_c"

  description = "This table stores details about programs, including ownership and linked accounts."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the program."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the program owner."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the program is deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the program."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the program was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user who created the program."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the program was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user who last modified the program."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last system modification."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of the last activity associated with the program."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last time the program was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the last time the program was referenced."
    },
    {
      name        = "program_description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the program."
    },
    {
      name        = "team_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the type of team associated with the program."
    },
    {
      name        = "dash_program_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the program ID in the dashboard."
    },
    {
      name        = "budget_target_rph_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Represents the budget target for revenue per hour for the program."
    },
    {
      name        = "account_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the account associated with the program."
    },
    {
      name        = "coordinated_program_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the program is coordinated."
    },
    {
      name        = "inactive_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the program is inactive."
    },
    {
      name        = "retailer_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the retailer associated with the program."
    },
    {
      name        = "department_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the department associated with the program."
    },
    {
      name        = "retailer_account_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the retailer account associated with the program."
    },
    {
      name        = "analyst_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the analyst assigned to the program."
    },
    {
      name        = "csm_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the CSM (Customer Success Manager) assigned to the program."
    },
    {
      name        = "director_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the director responsible for the program."
    },
    {
      name        = "mqm_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the MQM (Marketing Qualified Metric) associated with the program."
    },
    {
      name        = "project_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the project manager assigned to the program."
    },
    {
      name        = "vp_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the VP responsible for the program."
    },
    {
      name        = "dash_integration_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the integration status of the program with the dashboard."
    },
    {
      name        = "dash_integration_last_error_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Represents the last error encountered during dashboard integration."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the program was deleted in the source system and synced by Fivetran."
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
    "owner_id",
    "account_c",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_account,
    google_bigquery_table.salesforce_program_c,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_program_account"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "account"
      }
      column_references {
        referencing_column = "account_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_program_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_project_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "project_c"

  description = "This table stores information about projects and links to programs."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the project."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the project has been deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the project."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the project was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the project."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last modification to the project."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the project."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification to the project record."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of the last activity related to the project."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the project was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the project was referenced."
    },
    {
      name        = "program_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The program associated with the project."
    },
    {
      name        = "project_description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the project."
    },
    {
      name        = "service_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The service date for the project."
    },
    {
      name        = "allow_new_commitments_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether new commitments are allowed for the project."
    },
    {
      name        = "billable_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the project is billable."
    },
    {
      name        = "dash_project_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the project in the dashboard system."
    },
    {
      name        = "end_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The project's end date."
    },
    {
      name        = "start_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The project's start date."
    },
    {
      name        = "csm_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Customer Success Manager associated with the project."
    },
    {
      name        = "director_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The director associated with the project."
    },
    {
      name        = "vp_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Vice President associated with the project."
    },
    {
      name        = "mqm_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Stores the Marketing Qualified Metric for the project."
    },
    {
      name        = "project_manager_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The project manager for the project."
    },
    {
      name        = "analyst_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The analyst associated with the project."
    },
    {
      name        = "dash_integration_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The current status of the dashboard integration."
    },
    {
      name        = "dash_integration_last_error_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Stores the last error message related to dashboard integration."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the record was deleted in the source system, as tracked by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last sync by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "program_c",
    "start_date_c",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_contact,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_project_program"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "program_c"
      }
      column_references {
        referencing_column = "program_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_project_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_user" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "user"

  description = "This table stores comprehensive details about users within a Salesforce environment. It includes personal information, contact details, and preferences. It also tracks permissions and references to related entities."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier of the user."
    },
    {
      name        = "username"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Username of the user."
    },
    {
      name        = "last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Last name of the user."
    },
    {
      name        = "first_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First name of the user."
    },
    {
      name        = "middle_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Middle name of the user."
    },
    {
      name        = "suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Suffix of the user's name."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Full name of the user."
    },
    {
      name        = "company_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Company name of the user."
    },
    {
      name        = "division"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Division the user belongs to."
    },
    {
      name        = "department"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Department of the user."
    },
    {
      name        = "title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Job title of the user."
    },
    {
      name        = "street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address of the user."
    },
    {
      name        = "city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City of the user's address."
    },
    {
      name        = "state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State of the user's address."
    },
    {
      name        = "postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code of the user's address."
    },
    {
      name        = "country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country of the user's address."
    },
    {
      name        = "latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude coordinate of the user's location."
    },
    {
      name        = "longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude coordinate of the user's location."
    },
    {
      name        = "geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Accuracy of the geocode for the user's address."
    },
    {
      name        = "email"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address of the user."
    },
    {
      name        = "email_preferences_auto_bcc"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether automatic BCC is enabled for the user's emails."
    },
    {
      name        = "email_preferences_auto_bcc_stay_in_touch"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether automatic BCC is enabled for stay in touch emails."
    },
    {
      name        = "email_preferences_stay_in_touch_reminder"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether stay in touch reminders are enabled for the user."
    },
    {
      name        = "sender_email"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address used for sending emails."
    },
    {
      name        = "sender_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name used for sending emails."
    },
    {
      name        = "signature"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email signature of the user."
    },
    {
      name        = "stay_in_touch_subject"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Subject of the stay in touch emails."
    },
    {
      name        = "stay_in_touch_signature"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Signature used for stay in touch emails."
    },
    {
      name        = "stay_in_touch_note"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Note related to the stay in touch feature."
    },
    {
      name        = "phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number of the user."
    },
    {
      name        = "fax"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Fax number of the user."
    },
    {
      name        = "mobile_phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Mobile phone number of the user."
    },
    {
      name        = "alias"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alias of the user."
    },
    {
      name        = "community_nickname"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Nickname of the user in the community."
    },
    {
      name        = "badge_text"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Text displayed on the user's badge."
    },
    {
      name        = "is_active"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user is active."
    },
    {
      name        = "time_zone_sid_key"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Time zone of the user."
    },
    {
      name        = "user_role_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's role."
    },
    {
      name        = "locale_sid_key"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Locale of the user."
    },
    {
      name        = "receives_info_emails"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user receives info emails."
    },
    {
      name        = "receives_admin_info_emails"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user receives admin info emails."
    },
    {
      name        = "email_encoding_key"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email encoding of the user."
    },
    {
      name        = "profile_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's profile."
    },
    {
      name        = "user_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of user, such as standard or guest."
    },
    {
      name        = "start_day"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Start day of the user's work schedule."
    },
    {
      name        = "end_day"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "End day of the user's work schedule."
    },
    {
      name        = "language_locale_key"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Language of the user."
    },
    {
      name        = "employee_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employee number of the user."
    },
    {
      name        = "delegated_approver_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's delegated approver."
    },
    {
      name        = "manager_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's manager."
    },
    {
      name        = "last_login_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the user's last login."
    },
    {
      name        = "last_password_change_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the user's last password change."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of when the user was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user who created the record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last modification."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user who last modified the record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification."
    },
    {
      name        = "password_expiration_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the user's password expiration date."
    },
    {
      name        = "number_of_failed_logins"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of failed login attempts for the user."
    },
    {
      name        = "su_access_expiration_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Expiration date for super user access."
    },
    {
      name        = "offline_trial_expiration_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Expiration date of the offline trial."
    },
    {
      name        = "offline_pda_trial_expiration_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Expiration date of the offline PDA trial."
    },
    {
      name        = "user_permissions_marketing_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has marketing user permissions."
    },
    {
      name        = "user_permissions_offline_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has offline user permissions."
    },
    {
      name        = "user_permissions_avantgo_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has AvantGo user permissions."
    },
    {
      name        = "user_permissions_call_center_auto_login"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has permission for automatic login to the call center."
    },
    {
      name        = "user_permissions_sfcontent_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has Salesforce Content user permissions."
    },
    {
      name        = "user_permissions_knowledge_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has knowledge user permissions."
    },
    {
      name        = "user_permissions_interaction_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has interaction user permissions."
    },
    {
      name        = "user_permissions_support_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has support user permissions."
    },
    {
      name        = "user_permissions_live_agent_user"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has live agent user permissions."
    },
    {
      name        = "forecast_enabled"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether forecasting is enabled for the user."
    },
    {
      name        = "user_preferences_activity_reminders_popup"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether activity reminders pop up for the user."
    },
    {
      name        = "user_preferences_event_reminders_checkbox_default"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates the default state of the event reminders checkbox for the user."
    },
    {
      name        = "user_preferences_task_reminders_checkbox_default"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates the default state of the task reminders checkbox for the user."
    },
    {
      name        = "user_preferences_reminder_sound_off"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether reminder sounds are turned off for the user."
    },
    {
      name        = "user_preferences_disable_all_feeds_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether all feed email notifications are disabled for the user."
    },
    {
      name        = "user_preferences_disable_followers_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for new followers are disabled for the user."
    },
    {
      name        = "user_preferences_disable_profile_post_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for profile posts are disabled for the user."
    },
    {
      name        = "user_preferences_disable_change_comment_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for comment changes are disabled for the user."
    },
    {
      name        = "user_preferences_disable_later_comment_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for later comments are disabled for the user."
    },
    {
      name        = "user_preferences_dis_prof_post_comment_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for comments on profile posts are disabled for the user."
    },
    {
      name        = "user_preferences_apex_pages_developer_mode"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether Apex Pages developer mode is enabled for the user."
    },
    {
      name        = "user_preferences_receive_no_notifications_as_approver"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user receives notifications as an approver."
    },
    {
      name        = "user_preferences_receive_notifications_as_delegated_approver"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user receives notifications as a delegated approver."
    },
    {
      name        = "user_preferences_hide_csnget_chatter_mobile_task"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the CSNGet Chatter mobile task is hidden for the user."
    },
    {
      name        = "user_preferences_disable_mentions_post_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for mentions in posts are disabled for the user."
    },
    {
      name        = "user_preferences_dis_mentions_comment_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for mentions in comments are disabled for the user."
    },
    {
      name        = "user_preferences_hide_csndesktop_task"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has hidden the CSNDesktop task."
    },
    {
      name        = "user_preferences_hide_chatter_onboarding_splash"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the Chatter onboarding splash screen is hidden for the user."
    },
    {
      name        = "user_preferences_hide_second_chatter_onboarding_splash"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the second Chatter onboarding splash screen is hidden for the user."
    },
    {
      name        = "user_preferences_dis_comment_after_like_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for comments after likes are disabled for the user."
    },
    {
      name        = "user_preferences_disable_like_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for likes are disabled for the user."
    },
    {
      name        = "user_preferences_sort_feed_by_comment"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's feed is sorted by comment."
    },
    {
      name        = "user_preferences_disable_message_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for messages are disabled for the user."
    },
    {
      name        = "user_preferences_disable_bookmark_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for bookmarks are disabled for the user."
    },
    {
      name        = "user_preferences_disable_share_post_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for shared posts are disabled for the user."
    },
    {
      name        = "user_preferences_action_launcher_einstein_gpt_consent"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has given consent for the action launcher Einstein GPT."
    },
    {
      name        = "user_preferences_assistive_actions_enabled_in_action_launcher"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether assistive actions are enabled in the action launcher for the user."
    },
    {
      name        = "user_preferences_enable_auto_sub_for_feeds"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether automatic subscription for feeds is enabled for the user."
    },
    {
      name        = "user_preferences_disable_file_share_notifications_for_api"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether file share notifications are disabled for the API user."
    },
    {
      name        = "user_preferences_show_title_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's title is visible to external users."
    },
    {
      name        = "user_preferences_show_manager_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's manager is visible to external users."
    },
    {
      name        = "user_preferences_show_email_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's email address is visible to external users."
    },
    {
      name        = "user_preferences_show_work_phone_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's work phone number is visible to external users."
    },
    {
      name        = "user_preferences_show_mobile_phone_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's mobile phone number is visible to external users."
    },
    {
      name        = "user_preferences_show_fax_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's fax number is visible to external users."
    },
    {
      name        = "user_preferences_show_street_address_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's street address is visible to external users."
    },
    {
      name        = "user_preferences_show_city_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's city is visible to external users."
    },
    {
      name        = "user_preferences_show_state_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's state is visible to external users."
    },
    {
      name        = "user_preferences_show_postal_code_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's postal code is visible to external users."
    },
    {
      name        = "user_preferences_show_country_to_external_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's country is visible to external users."
    },
    {
      name        = "user_preferences_show_profile_pic_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's profile picture is visible to guest users."
    },
    {
      name        = "user_preferences_show_title_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's title is visible to guest users."
    },
    {
      name        = "user_preferences_show_city_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's city is visible to guest users."
    },
    {
      name        = "user_preferences_show_state_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's state is visible to guest users."
    },
    {
      name        = "user_preferences_show_postal_code_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's postal code is visible to guest users."
    },
    {
      name        = "user_preferences_show_country_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's country is visible to guest users."
    },
    {
      name        = "user_preferences_show_forecasting_change_signals"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether forecasting change signals are shown for the user."
    },
    {
      name        = "user_preferences_live_agent_miaw_setup_deflection"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether Live Agent MIAW setup deflection is enabled for the user."
    },
    {
      name        = "user_preferences_hide_s_1_browser_ui"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the Salesforce 1 browser UI is hidden for the user."
    },
    {
      name        = "user_preferences_disable_endorsement_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether email notifications for endorsements are disabled for the user."
    },
    {
      name        = "user_preferences_path_assistant_collapsed"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the path assistant is collapsed for the user."
    },
    {
      name        = "user_preferences_cache_diagnostics"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether cache diagnostics are enabled for the user."
    },
    {
      name        = "user_preferences_show_email_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's email address is visible to guest users."
    },
    {
      name        = "user_preferences_show_manager_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's manager is visible to guest users."
    },
    {
      name        = "user_preferences_show_work_phone_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's work phone number is visible to guest users."
    },
    {
      name        = "user_preferences_show_mobile_phone_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's mobile phone number is visible to guest users."
    },
    {
      name        = "user_preferences_show_fax_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's fax number is visible to guest users."
    },
    {
      name        = "user_preferences_show_street_address_to_guest_users"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's street address is visible to guest users."
    },
    {
      name        = "user_preferences_lightning_experience_preferred"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether Lightning Experience is preferred for the user."
    },
    {
      name        = "user_preferences_preview_lightning"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user is previewing Lightning."
    },
    {
      name        = "user_preferences_hide_end_user_onboarding_assistant_modal"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the end user onboarding assistant modal is hidden for the user."
    },
    {
      name        = "user_preferences_hide_lightning_migration_modal"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the Lightning migration modal is hidden for the user."
    },
    {
      name        = "user_preferences_hide_sfx_welcome_mat"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the Salesforce welcome mat is hidden for the user."
    },
    {
      name        = "user_preferences_hide_bigger_photo_callout"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the bigger photo callout is hidden for the user."
    },
    {
      name        = "user_preferences_global_nav_bar_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the global navigation bar walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_global_nav_grid_menu_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the global navigation grid menu walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_create_lexapps_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the create LEX apps walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_favorites_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the favorites walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_record_home_section_collapse_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record home section collapse walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_record_home_reserved_wtshown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record home reserved walkthrough is shown for the user."
    },
    {
      name        = "user_preferences_favorites_show_top_favorites"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether top favorites are shown for the user."
    },
    {
      name        = "user_preferences_exclude_mail_app_attachments"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether attachments are excluded from the mail app for the user."
    },
    {
      name        = "user_preferences_suppress_task_sfxreminders"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether task sound reminders are suppressed for the user."
    },
    {
      name        = "user_preferences_suppress_event_sfxreminders"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether event sound reminders are suppressed for the user."
    },
    {
      name        = "user_preferences_preview_custom_theme"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user is previewing a custom theme."
    },
    {
      name        = "user_preferences_has_celebration_badge"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has a celebration badge."
    },
    {
      name        = "user_preferences_user_debug_mode_pref"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether user debug mode is enabled for the user."
    },
    {
      name        = "user_preferences_srhoverride_activities"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has overridden activities."
    },
    {
      name        = "user_preferences_new_lightning_report_run_page_enabled"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the new Lightning report run page is enabled for the user."
    },
    {
      name        = "user_preferences_reverse_open_activities_view"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the open activities view is reversed for the user."
    },
    {
      name        = "user_preferences_has_sent_warning_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a warning email has been sent to the user."
    },
    {
      name        = "user_preferences_has_sent_warning_email_238"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether warning email 238 has been sent to the user."
    },
    {
      name        = "user_preferences_has_sent_warning_email_240"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a warning email 240 has been sent to the user."
    },
    {
      name        = "user_preferences_dismiss_personal_space_legal_message"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the personal space legal message is dismissed for the user."
    },
    {
      name        = "user_preferences_brelookup_table_welcome_mat"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the BR ELookup table welcome mat is shown for the user."
    },
    {
      name        = "user_preferences_hide_browse_product_redirect_confirmation"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the browse product redirect confirmation is hidden for the user."
    },
    {
      name        = "user_preferences_hide_online_sales_app_tab_visibility_requirements_modal"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the online sales app tab visibility requirements modal is hidden for the user."
    },
    {
      name        = "user_preferences_hide_online_sales_app_welcome_mat"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the online sales app welcome mat is hidden for the user."
    },
    {
      name        = "user_preferences_hide_managed_eca_mobile_pub_modal"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the managed ECA mobile publisher modal is hidden for the user."
    },
    {
      name        = "user_preferences_show_forecasting_rounded_amounts"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether forecasting rounded amounts are shown for the user."
    },
    {
      name        = "has_user_verified_phone"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has verified their phone number."
    },
    {
      name        = "has_user_verified_email"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user has verified their email address."
    },
    {
      name        = "contact_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's contact record."
    },
    {
      name        = "account_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's associated account."
    },
    {
      name        = "call_center_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's call center."
    },
    {
      name        = "extension"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone extension of the user."
    },
    {
      name        = "federation_identifier"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier for federated users."
    },
    {
      name = "about_me"
      type = "STRING"
      mode = "NULLABLE"
    },
    {
      name        = "full_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's full photo."
    },
    {
      name        = "small_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's small photo."
    },
    {
      name        = "is_ext_indicator_visible"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the external indicator is visible."
    },
    {
      name        = "out_of_office_message"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Out of office message of the user."
    },
    {
      name        = "medium_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's medium photo."
    },
    {
      name        = "digest_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Frequency of the user's digest emails."
    },
    {
      name        = "default_group_notification_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Default notification frequency for groups."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the user was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the user was referenced."
    },
    {
      name        = "banner_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's banner photo."
    },
    {
      name        = "small_banner_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's small banner photo."
    },
    {
      name        = "medium_banner_photo_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL of the user's medium banner photo."
    },
    {
      name        = "is_profile_photo_active"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the user's profile photo is active."
    },
    {
      name        = "individual_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the user's individual record."
    },
    {
      name        = "dsfs_dspro_sfmembership_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Salesforce membership status."
    },
    {
      name        = "dsfs_dspro_sfpassword_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Salesforce password."
    },
    {
      name        = "dsfs_dspro_sfusername_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Salesforce username."
    },
    {
      name        = "spring_cmeos_portal_only_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Custom field indicating whether the user is a portal-only user."
    },
    {
      name        = "spring_cmeos_spring_cm_enabled_end_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field storing the Spring CM enabled end date."
    },
    {
      name        = "spring_cmeos_spring_cm_enabled_start_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field storing the Spring CM enabled start date."
    },
    {
      name        = "spring_cmeos_spring_cm_persona_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Spring CM persona."
    },
    {
      name        = "spring_cmeos_spring_cm_role_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Spring CM role."
    },
    {
      name        = "spring_cmeos_spring_cm_user_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Custom field indicating whether the user is a Spring CM user."
    },
    {
      name        = "pi_can_view_not_assigned_prospects_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Custom field indicating whether the user can view not assigned prospects."
    },
    {
      name        = "pi_pardot_api_key_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Pardot API key."
    },
    {
      name        = "pi_pardot_api_version_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Pardot API version."
    },
    {
      name        = "pi_pardot_user_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Pardot user ID."
    },
    {
      name        = "pi_pardot_user_key_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Pardot user key."
    },
    {
      name        = "pi_pardot_user_role_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field storing the Pardot user role."
    },
    {
      name        = "shop_com_user_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Custom field indicating whether the user is a Shop.com user."
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
      description = "Timestamp of the last Fivetran sync."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_contact,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_user_contact"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "contact"
      }
      column_references {
        referencing_column = "contact_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_user_account"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "account"
      }
      column_references {
        referencing_column = "account_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_user'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_product_2" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "product_2"

  description = "This table stores comprehensive details about products. It includes product identification, categorization, and status information. The table tracks key dates and supports linking to quote line items."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the product."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the product."
    },
    {
      name        = "product_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code identifying the product."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Textual explanation of the product."
    },
    {
      name        = "is_active"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the product is active."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the product was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the product."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the product was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the product."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification to the product."
    },
    {
      name        = "family"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Family or category the product belongs to."
    },
    {
      name        = "external_data_source_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the external data source for the product."
    },
    {
      name        = "external_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier from an external system for the product."
    },
    {
      name        = "display_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "URL for displaying the product."
    },
    {
      name        = "quantity_unit_of_measure"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unit of measure for the product's quantity."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the product is deleted."
    },
    {
      name        = "is_archived"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the product is archived."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the product was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the product was referenced."
    },
    {
      name        = "stock_keeping_unit"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier for inventory tracking of the product."
    },
    {
      name        = "hours_forecasting_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if hours forecasting is enabled for the product."
    },
    {
      name        = "markup_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Markup percentage for the product."
    },
    {
      name        = "price_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of pricing for the product."
    },
    {
      name        = "revenue_category_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Category of the product's revenue."
    },
    {
      name        = "revenue_forecasting_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if revenue forecasting is enabled for the product."
    },
    {
      name        = "revenue_grouping_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Grouping of the product's revenue."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the product was deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the product was synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_account,
    google_bigquery_table.salesforce_contact,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_product_2'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_opportunity" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "opportunity"

  description = "This table stores information about sales opportunities and references related accounts, owners, and contacts."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier of the opportunity."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is deleted."
    },
    {
      name        = "account_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the account associated with the opportunity."
    },
    {
      name        = "record_type_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the record type."
    },
    {
      name        = "is_private"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is private."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the opportunity."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the opportunity."
    },
    {
      name        = "stage_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the current stage of the opportunity."
    },
    {
      name        = "amount"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Amount of the opportunity."
    },
    {
      name        = "probability"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Probability of the opportunity closing successfully."
    },
    {
      name        = "expected_revenue"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Expected revenue from the opportunity."
    },
    {
      name        = "total_opportunity_quantity"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Total quantity of items in the opportunity."
    },
    {
      name        = "close_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the opportunity is expected to close."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of opportunity."
    },
    {
      name        = "next_step"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Next step in the opportunity."
    },
    {
      name        = "lead_source"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Source of the lead for the opportunity."
    },
    {
      name        = "is_closed"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is closed."
    },
    {
      name        = "is_won"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is won."
    },
    {
      name        = "forecast_category"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Forecast category of the opportunity."
    },
    {
      name        = "forecast_category_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the forecast category."
    },
    {
      name        = "campaign_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the campaign associated with the opportunity."
    },
    {
      name        = "has_opportunity_line_item"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity has line items."
    },
    {
      name        = "pricebook_2_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the price book associated with the opportunity."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who owns the opportunity."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the opportunity was created."
    },
    {
      name        = "age_in_days"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of days since the opportunity was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the opportunity."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the opportunity was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the opportunity."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of the last activity on the opportunity."
    },
    {
      name        = "last_activity_in_days"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of days since the last activity."
    },
    {
      name        = "push_count"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of times the opportunity's close date has been pushed out."
    },
    {
      name        = "last_stage_change_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the opportunity's stage was last changed."
    },
    {
      name        = "last_stage_change_in_days"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Number of days since the opportunity's stage was last changed."
    },
    {
      name        = "fiscal_quarter"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Fiscal quarter of the opportunity."
    },
    {
      name        = "fiscal_year"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Fiscal year of the opportunity."
    },
    {
      name        = "fiscal"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Fiscal period of the opportunity."
    },
    {
      name        = "contact_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the primary contact associated with the opportunity."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the opportunity was viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last time the opportunity was referenced."
    },
    {
      name        = "synced_quote_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the synced quote."
    },
    {
      name        = "contract_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the contract associated with the opportunity."
    },
    {
      name        = "has_open_activity"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity has any open activities."
    },
    {
      name        = "has_overdue_task"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity has any overdue tasks."
    },
    {
      name        = "last_amount_changed_history_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the history record of the last amount change."
    },
    {
      name        = "last_close_date_changed_history_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the history record of the last close date change."
    },
    {
      name        = "is_priority_record"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the record is a priority."
    },
    {
      name        = "budget_confirmed_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the budget is confirmed."
    },
    {
      name        = "discovery_completed_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the discovery phase is completed."
    },
    {
      name        = "roi_analysis_completed_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the ROI analysis is completed."
    },
    {
      name        = "service_start_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field for the service start date."
    },
    {
      name        = "loss_reason_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the loss reason."
    },
    {
      name        = "service_end_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field for the service end date."
    },
    {
      name        = "service_types_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the types of services."
    },
    {
      name        = "renewable_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is renewable."
    },
    {
      name        = "billable_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is billable."
    },
    {
      name        = "end_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field for the end date."
    },
    {
      name        = "probability_manual_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Custom field for manual probability."
    },
    {
      name        = "program_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the program."
    },
    {
      name        = "project_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the project identifier."
    },
    {
      name        = "project_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the associated project."
    },
    {
      name        = "start_date_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Custom field for the start date."
    },
    {
      name        = "store_count_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Custom field for the store count."
    },
    {
      name        = "integrated_with_dash_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity is integrated with a dashboard."
    },
    {
      name        = "integration_error_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for integration errors."
    },
    {
      name        = "team_type_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the team type."
    },
    {
      name        = "revenue_grouping_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the revenue grouping."
    },
    {
      name        = "close_date_past_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the close date is in the past."
    },
    {
      name        = "retailer_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the retailer."
    },
    {
      name        = "created_by_dash_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the opportunity was created by a dashboard."
    },
    {
      name        = "probability_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for probability."
    },
    {
      name        = "previous_project_approved_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the previous project was approved."
    },
    {
      name        = "previous_project_associated_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if a previous project is associated."
    },
    {
      name        = "loss_reason_description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the description of the loss reason."
    },
    {
      name        = "explanation_for_uncommitted_approval_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the explanation for uncommitted approval."
    },
    {
      name        = "uncommitted_project_po_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the project purchase order is uncommitted."
    },
    {
      name        = "uncommitted_project_sow_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the project statement of work is uncommitted."
    },
    {
      name        = "department_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the department."
    },
    {
      name        = "retailer_account_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the retailer account."
    },
    {
      name        = "origination_source_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the origination source."
    },
    {
      name        = "dash_integration_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Custom field for the dashboard integration status."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean indicating if the record was deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "account_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_account,
    google_bigquery_table.salesforce_opportunity,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_opportunity_account"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "account"
      }
      column_references {
        referencing_column = "account_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_opportunity_contact"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "contact"
      }
      column_references {
        referencing_column = "contact_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_opportunity'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_quote" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "quote"

  description = "This table stores details about sales quotes and references related opportunities, accounts, owners, and contacts."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the quote."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the quote owner."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the quote has been deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the quote."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date and time the quote was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the user who created the quote."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date and time the quote was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the user who last modified the quote."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date and time of the last system modification."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date and time the quote was last viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Date and time the quote was last referenced."
    },
    {
      name        = "opportunity_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the related opportunity."
    },
    {
      name        = "pricebook_2_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the price book used for the quote."
    },
    {
      name        = "contact_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the related contact."
    },
    {
      name        = "quote_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Number of the quote."
    },
    {
      name        = "is_syncing"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the quote is currently syncing."
    },
    {
      name        = "shipping_handling"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Shipping and handling costs for the quote."
    },
    {
      name        = "tax"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Tax amount for the quote."
    },
    {
      name        = "status"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Status of the quote."
    },
    {
      name        = "expiration_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date the quote expires."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the quote."
    },
    {
      name        = "billing_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address of the billing address."
    },
    {
      name        = "billing_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City of the billing address."
    },
    {
      name        = "billing_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State of the billing address."
    },
    {
      name        = "billing_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code of the billing address."
    },
    {
      name        = "billing_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country of the billing address."
    },
    {
      name        = "billing_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude of the billing address."
    },
    {
      name        = "billing_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude of the billing address."
    },
    {
      name        = "billing_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Accuracy of the billing address geocode."
    },
    {
      name        = "shipping_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address of the shipping address."
    },
    {
      name        = "shipping_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City of the shipping address."
    },
    {
      name        = "shipping_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State of the shipping address."
    },
    {
      name        = "shipping_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code of the shipping address."
    },
    {
      name        = "shipping_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country of the shipping address."
    },
    {
      name        = "shipping_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude of the shipping address."
    },
    {
      name        = "shipping_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude of the shipping address."
    },
    {
      name        = "shipping_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Accuracy of the shipping address geocode."
    },
    {
      name        = "quote_to_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Street address of the quote recipient."
    },
    {
      name        = "quote_to_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City of the quote recipient."
    },
    {
      name        = "quote_to_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "State of the quote recipient."
    },
    {
      name        = "quote_to_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code of the quote recipient."
    },
    {
      name        = "quote_to_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country of the quote recipient."
    },
    {
      name        = "quote_to_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude of the quote recipient's location."
    },
    {
      name        = "quote_to_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude of the quote recipient's location."
    },
    {
      name        = "quote_to_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Accuracy of the quote recipient's address geocode."
    },
    {
      name        = "additional_street"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional street address associated with the quote."
    },
    {
      name        = "additional_city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional city associated with the quote."
    },
    {
      name        = "additional_state"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional state associated with the quote."
    },
    {
      name        = "additional_postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional postal code associated with the quote."
    },
    {
      name        = "additional_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional country associated with the quote."
    },
    {
      name        = "additional_latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Latitude of the additional address."
    },
    {
      name        = "additional_longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Longitude of the additional address."
    },
    {
      name        = "additional_geocode_accuracy"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Accuracy of the additional address geocode."
    },
    {
      name        = "billing_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the billing contact."
    },
    {
      name        = "shipping_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the shipping contact."
    },
    {
      name        = "quote_to_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the quote recipient."
    },
    {
      name        = "additional_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional name associated with the quote."
    },
    {
      name        = "email"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Email address associated with the quote."
    },
    {
      name        = "phone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Phone number associated with the quote."
    },
    {
      name        = "fax"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Fax number associated with the quote."
    },
    {
      name        = "contract_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the related contract."
    },
    {
      name        = "account_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the related account."
    },
    {
      name        = "discount"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Discount applied to the quote."
    },
    {
      name        = "grand_total"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Grand total amount of the quote."
    },
    {
      name        = "can_create_quote_line_items"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if quote line items can be created."
    },
    {
      name        = "anderson_responsibilities_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Anderson responsibilities related to the quote."
    },
    {
      name        = "anderson_signer_1_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Anderson signer 1 associated with the quote."
    },
    {
      name        = "client_percent_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Client percentage for the quote."
    },
    {
      name        = "client_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Client associated with the quote."
    },
    {
      name        = "customer_responsibilities_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Customer responsibilities related to the quote."
    },
    {
      name        = "docu_sign_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Status of the DocuSign process."
    },
    {
      name        = "internal_comments_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Internal comments related to the quote."
    },
    {
      name        = "signer_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Signer associated with the quote."
    },
    {
      name        = "statement_of_work_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Statement of work associated with the quote."
    },
    {
      name        = "version_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Version number of the quote."
    },
    {
      name        = "customer_contact_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Customer contact associated with the quote."
    },
    {
      name        = "docu_sign_result_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Result of the DocuSign process."
    },
    {
      name        = "quote_about_to_expire_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the quote is about to expire."
    },
    {
      name        = "routing_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Routing information for the quote."
    },
    {
      name        = "billing_frequency_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Billing frequency for the quote."
    },
    {
      name        = "integrated_with_dash_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the quote is integrated with the dashboard."
    },
    {
      name        = "docu_sign_envelope_id_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "ID of the DocuSign envelope."
    },
    {
      name        = "integration_result_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Result of the integration process."
    },
    {
      name        = "language_flat_fee_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if a language flat fee applies."
    },
    {
      name        = "po_required_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if a purchase order is required."
    },
    {
      name        = "purchase_order_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Purchase order number associated with the quote."
    },
    {
      name        = "uncommitted_project_sow_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the project statement of work is uncommitted."
    },
    {
      name        = "a_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Amount for Sam's Club."
    },
    {
      name        = "expense_reimbursement_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Expense reimbursement amount for Sam's Club."
    },
    {
      name        = "in_store_service_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "In-store service amount for Sam's Club."
    },
    {
      name        = "in_store_service_ulta_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "In-store service amount for Ulta."
    },
    {
      name        = "production_other_retailer_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Production amount for other retailers."
    },
    {
      name        = "production_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Production amount for Sam's Club."
    },
    {
      name        = "production_walmart_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Production amount for Walmart."
    },
    {
      name        = "project_management_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Project management amount for Sam's Club."
    },
    {
      name        = "quality_assurance_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Quality assurance amount for Sam's Club."
    },
    {
      name        = "shop_comm_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Shop commission amount for Sam's Club."
    },
    {
      name        = "trip_charge_sam_s_club_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Trip charge amount for Sam's Club."
    },
    {
      name        = "california_surcharge_walmart_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "California surcharge amount for Walmart."
    },
    {
      name        = "california_surcharge_other_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Other California surcharge amount."
    },
    {
      name        = "in_store_service_ahold_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "In-store service amount for Ahold."
    },
    {
      name        = "in_store_service_publix_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "In-store service amount for Publix."
    },
    {
      name        = "in_store_service_wakefern_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "In-store service amount for Wakefern."
    },
    {
      name        = "california_surcharge_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if a California surcharge applies."
    },
    {
      name        = "dash_integration_status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Status of the integration with the dashboard."
    },
    {
      name        = "invoice_granularity_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Invoice granularity setting for the quote."
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
      description = "Date and time the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "opportunity_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_account,
    google_bigquery_table.salesforce_opportunity,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_quote_account"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "account"
      }
      column_references {
        referencing_column = "account_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_quote_contact"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "contact"
      }
      column_references {
        referencing_column = "contact_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_quote_opportunity"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "opportunity"
      }
      column_references {
        referencing_column = "opportunity_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_quote'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_quote_line_item" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "quote_line_item"

  description = "This table stores details about individual items within a sales quote. It links quotes and products for downstream joins."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier of the line item."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the line item is marked as deleted."
    },
    {
      name        = "line_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The number assigned to the line item within the quote."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time when the line item was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the user who created the line item."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time when the line item was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the user who last modified the line item."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time of the last system modification to the line item."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time when the line item was last viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time when the line item was last referenced."
    },
    {
      name        = "quote_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the quote to which the line item belongs."
    },
    {
      name        = "pricebook_entry_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the price book entry associated with the line item."
    },
    {
      name        = "opportunity_line_item_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the corresponding opportunity line item."
    },
    {
      name        = "quantity"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of units of the product included in the line item."
    },
    {
      name        = "unit_price"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The price of a single unit of the product."
    },
    {
      name        = "discount"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The discount applied to the line item."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A general description of the line item."
    },
    {
      name        = "service_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when the service associated with the line item is scheduled."
    },
    {
      name        = "product_2_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier of the product associated with the line item."
    },
    {
      name        = "sort_order"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "The order in which the line item should appear in the quote."
    },
    {
      name        = "list_price"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The standard price of the product before any discounts."
    },
    {
      name        = "subtotal"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The total price of the line item before discounts."
    },
    {
      name        = "total_price"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The final price of the line item after discounts."
    },
    {
      name        = "client_percent_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "A client-specific percentage value associated with the line item."
    },
    {
      name        = "line_unit_price_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "A custom unit price for the line item."
    },
    {
      name        = "service_family_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The family or category of the service provided in the line item."
    },
    {
      name        = "test_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "A test value associated with the line item."
    },
    {
      name        = "sort_order_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "A custom sort order value for the line item."
    },
    {
      name        = "planned_minutes_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The planned number of minutes for the service associated with the line item."
    },
    {
      name        = "description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A custom description field for the line item."
    },
    {
      name        = "invoicing_unit_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unit used for invoicing the line item."
    },
    {
      name        = "hours_per_service_week_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of hours of service provided per week for the line item."
    },
    {
      name        = "price_per_service_week_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The price of the service per week for the line item."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the line item was deleted in the source system."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The date and time when the line item was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "quote_id",
    "product_2_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_quote,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_qli_quote"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "quote"
      }
      column_references {
        referencing_column = "quote_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_qli_product"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "product_2"
      }
      column_references {
        referencing_column = "product_2_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_quote_line_item'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_quote_line_forecast_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "quote_line_forecast_c"

  description = "This table stores information related to quote line forecasts and links to quote line items."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the record."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record has been deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the record."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the record was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last modification to the record."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification to the record."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the record was last viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp when the record was last referenced."
    },
    {
      name        = "forecast_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Value of the forecast."
    },
    {
      name        = "quote_line_item_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the associated quote line item."
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
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "quote_line_item_c",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_opportunity,
    google_bigquery_table.salesforce_quote_line_item,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_qlf_qli"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "quote_line_item"
      }
      column_references {
        referencing_column = "quote_line_item_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_quote_line_forecast_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_forecast_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "forecast_c"

  description = "This table stores forecast data with links to opportunities."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the forecast record."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Boolean value indicating if the forecast record is deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the forecast record."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the forecast record was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who created the forecast record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the forecast record was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the user who last modified the forecast record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last system modification."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of the last activity related to the forecast."
    },
    {
      name        = "opportunity_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for a related opportunity."
    },
    {
      name        = "description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the forecast."
    },
    {
      name        = "forecasted_hours_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Number of hours forecasted."
    },
    {
      name        = "forecasted_revenue_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "Amount of revenue forecasted."
    },
    {
      name        = "forecasted_target_hours_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Number of target hours forecasted."
    },
    {
      name        = "related_line_item_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for a related line item."
    },
    {
      name        = "revenue_category_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Category of the revenue."
    },
    {
      name        = "service_category_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Category of the service."
    },
    {
      name        = "week_of_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date representing the week to which the forecast applies."
    },
    {
      name        = "revenue_grouping_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Grouping or category to which the revenue belongs."
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
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "opportunity_c",
    "week_of_c",
    "id",
  ]

  depends_on = [
    google_bigquery_table.salesforce_quote_line_item,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_forecast_opportunity"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "opportunity"
      }
      column_references {
        referencing_column = "opportunity_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_forecast_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "salesforce_forecast_line_item_c" {
  dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
  table_id   = "forecast_line_item_c"

  description = "This table stores granular forecast data related to sales opportunities, linked to programs, projects, products, and quote line items."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the forecast line item."
    },
    {
      name        = "owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ID of the record owner."
    },
    {
      name        = "is_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the record is deleted."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the forecast line item."
    },
    {
      name        = "created_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the record was created."
    },
    {
      name        = "created_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ID of the user who created the record."
    },
    {
      name        = "last_modified_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the record was last modified."
    },
    {
      name        = "last_modified_by_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The ID of the user who last modified the record."
    },
    {
      name        = "system_modstamp"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp of the last system modification."
    },
    {
      name        = "last_activity_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of the last activity."
    },
    {
      name        = "last_viewed_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the record was last viewed."
    },
    {
      name        = "last_referenced_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp when the record was last referenced."
    },
    {
      name        = "week_ending_c"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date the week ends for the forecast line item."
    },
    {
      name        = "description_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the forecast line item."
    },
    {
      name        = "of_elements_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of elements."
    },
    {
      name        = "forecasted_revenue_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The forecasted revenue amount."
    },
    {
      name        = "forecasted_hours_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The forecasted hours."
    },
    {
      name        = "invoice_line_item_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated invoice line item."
    },
    {
      name        = "scheduled_revenue_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The scheduled revenue amount."
    },
    {
      name        = "scheduled_hours_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of hours scheduled."
    },
    {
      name        = "of_activities_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of activities."
    },
    {
      name        = "of_incomplete_activities_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of incomplete activities."
    },
    {
      name        = "actual_hours_c"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The actual hours worked."
    },
    {
      name        = "earned_revenue_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The earned revenue amount."
    },
    {
      name        = "variance_reason_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The reason for any variance."
    },
    {
      name        = "product_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated product."
    },
    {
      name        = "project_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated project."
    },
    {
      name        = "quote_line_item_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated quote line item."
    },
    {
      name        = "quote_line_forecast_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated quote line forecast."
    },
    {
      name        = "billing_granularity_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The billing granularity."
    },
    {
      name        = "activity_complete_c"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the activity is complete or not."
    },
    {
      name        = "program_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The associated program."
    },
    {
      name        = "status_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The status of the forecast line item."
    },
    {
      name        = "accounting_period_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The accounting period associated with the forecast line item."
    },
    {
      name        = "reason_for_adjustment_to_earned_revenue_c"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The reason for any adjustments made to the earned revenue."
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
      description = "The timestamp when the data was last synced by Fivetran."
    },
    {
      name        = "invoiced_revenue_c"
      type        = "BIGNUMERIC"
      mode        = "NULLABLE"
      description = "The invoiced revenue amount."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "program_c",
    "project_c",
    "product_c",
    "quote_line_item_c",
    # Note: BigQuery allows max 4 clustering columns, removed "quote_line_forecast_c"
  ]

  depends_on = [
    google_bigquery_table.salesforce_quote_line_item,
    google_bigquery_table.salesforce_quote_line_forecast_c,
    var.datasets
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_fli_quote_line_item"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "quote_line_item"
      }
      column_references {
        referencing_column = "quote_line_item_c"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_fli_quote_line_forecast"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "quote_line_forecast_c"
      }
      column_references {
        referencing_column = "quote_line_forecast_c"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_fli_program"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "program_c"
      }
      column_references {
        referencing_column = "program_c"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_fli_project"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "project_c"
      }
      column_references {
        referencing_column = "project_c"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_fli_product"
      referenced_table {
        dataset_id = var.datasets[var.salesforce_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "product_2"
      }
      column_references {
        referencing_column = "product_c"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_salesforce)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(var.datasets), var.salesforce_dataset_prefix)
      error_message = "Dataset '${var.salesforce_dataset_prefix}' must exist before creating table 'salesforce_forecast_line_item_c'. Ensure the dataset is defined in var.datasets."
    }
  }
}
