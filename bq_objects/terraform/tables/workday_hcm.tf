# BigQuery Tables - Workday Hcm
# Auto-generated from Create Table Script.sql
# Split from tables.tf for better maintainability

resource "google_bigquery_table" "workday_hcm_worker" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "worker"

  description = "This table stores comprehensive information about workers in the Workday HCM system. It tracks employment status, dates, compensation, and other worker-related attributes."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the worker."
    },
    {
      name        = "universal_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Universal identifier for the worker."
    },
    {
      name        = "academic_tenure_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Academic tenure date for the worker."
    },
    {
      name        = "active"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the worker is currently active."
    },
    {
      name        = "active_status_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the active status was set."
    },
    {
      name        = "benefits_service_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when benefits service started."
    },
    {
      name        = "company_service_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when company service started."
    },
    {
      name        = "continuous_service_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when continuous service started."
    },
    {
      name        = "date_entered_workforce"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when worker entered the workforce."
    },
    {
      name        = "days_unemployed"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Number of days the worker was unemployed."
    },
    {
      name        = "eligible_for_hire"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Eligibility status for hire."
    },
    {
      name        = "eligible_for_rehire_on_latest_termination"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Eligibility for rehire status."
    },
    {
      name        = "end_employment_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when employment ended."
    },
    {
      name        = "expected_date_of_return"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Expected date of return for the worker."
    },
    {
      name        = "expected_retirement_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Expected retirement date."
    },
    {
      name        = "first_day_of_work"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "First day of work for the worker."
    },
    {
      name        = "hire_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the worker was hired."
    },
    {
      name        = "hire_rescinded"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the hire was rescinded."
    },
    {
      name        = "hire_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason for the hire."
    },
    {
      name        = "last_datefor_which_paid"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Last date for which the worker was paid."
    },
    {
      name        = "local_termination_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Local termination reason."
    },
    {
      name        = "months_continuous_prior_employment"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Months of continuous prior employment."
    },
    {
      name        = "not_returning"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the worker is not returning."
    },
    {
      name        = "original_hire_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Original hire date."
    },
    {
      name        = "pay_through_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date through which pay is authorized."
    },
    {
      name        = "primary_termination_category"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Primary termination category."
    },
    {
      name        = "primary_termination_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Primary termination reason."
    },
    {
      name        = "probation_start_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Start date of probation period."
    },
    {
      name        = "probation_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "End date of probation period."
    },
    {
      name        = "regrettable_termination"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if termination was regrettable."
    },
    {
      name        = "rehire"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if this is a rehire."
    },
    {
      name        = "resignation_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date of resignation."
    },
    {
      name        = "retirement_eligibility_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Retirement eligibility date."
    },
    {
      name        = "retired"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the worker is retired."
    },
    {
      name        = "retirement_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Retirement date."
    },
    {
      name        = "return_unknown"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if return date is unknown."
    },
    {
      name        = "seniority_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Seniority date."
    },
    {
      name        = "severance_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Severance date."
    },
    {
      name        = "terminated"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the worker is terminated."
    },
    {
      name        = "termination_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Termination date."
    },
    {
      name        = "termination_last_day_of_work"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Last day of work before termination."
    },
    {
      name        = "termination_involuntary"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if termination was involuntary."
    },
    {
      name        = "time_off_service_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Time off service date."
    },
    {
      name        = "vesting_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Vesting date."
    },
    {
      name        = "contract_pay_rate"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Contract pay rate."
    },
    {
      name        = "contract_assignment_details"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contract assignment details."
    },
    {
      name        = "contract_currency_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contract currency code."
    },
    {
      name        = "contract_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Contract end date."
    },
    {
      name        = "contract_frequency_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contract frequency name."
    },
    {
      name        = "contract_vendor_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Contract vendor name."
    },
    {
      name        = "has_international_assignment"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if worker has international assignment."
    },
    {
      name        = "home_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Home country of the worker."
    },
    {
      name        = "compensation_effective_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Compensation effective date."
    },
    {
      name        = "reason_reference_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Reason reference identifier."
    },
    {
      name        = "employee_compensation_total_base_pay"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Employee compensation total base pay."
    },
    {
      name        = "employee_compensation_total_salary_and_allowances"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Employee compensation total salary and allowances."
    },
    {
      name        = "employee_compensation_primary_compensation_basis"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Employee compensation primary compensation basis."
    },
    {
      name        = "employee_compensation_currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employee compensation currency."
    },
    {
      name        = "employee_compensation_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Employee compensation frequency."
    },
    {
      name        = "annual_summary_total_base_pay"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual summary total base pay."
    },
    {
      name        = "annual_summary_total_salary_and_allowances"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual summary total salary and allowances."
    },
    {
      name        = "annual_summary_primary_compensation_basis"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual summary primary compensation basis."
    },
    {
      name        = "annual_summary_currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Annual summary currency."
    },
    {
      name        = "annual_summary_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Annual summary frequency."
    },
    {
      name        = "pay_group_frequency_total_base_pay"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Pay group frequency total base pay."
    },
    {
      name        = "pay_group_frequency_total_salary_and_allowances"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Pay group frequency total salary and allowances."
    },
    {
      name        = "pay_group_frequency_primary_compensation_basis"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Pay group frequency primary compensation basis."
    },
    {
      name        = "pay_group_frequency_currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Pay group frequency currency."
    },
    {
      name        = "pay_group_frequency_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Pay group frequency frequency."
    },
    {
      name        = "annual_currency_summary_total_base_pay"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual currency summary total base pay."
    },
    {
      name        = "annual_currency_summary_total_salary_and_allowances"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual currency summary total salary and allowances."
    },
    {
      name        = "annual_currency_summary_primary_compensation_basis"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Annual currency summary primary compensation basis."
    },
    {
      name        = "annual_currency_summary_currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Annual currency summary currency."
    },
    {
      name        = "annual_currency_summary_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Annual currency summary frequency."
    },
    {
      name        = "hourly_frequency_total_base_pay"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Hourly frequency total base pay."
    },
    {
      name        = "hourly_frequency_total_salary_and_allowances"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Hourly frequency total salary and allowances."
    },
    {
      name        = "hourly_frequency_primary_compensation_basis"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Hourly frequency primary compensation basis."
    },
    {
      name        = "hourly_frequency_currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Hourly frequency currency."
    },
    {
      name        = "hourly_frequency_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Hourly frequency frequency."
    },
    {
      name        = "compensation_grade_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Compensation grade identifier."
    },
    {
      name        = "compensation_grade_profile_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Compensation grade profile identifier."
    },
    {
      name        = "user_language_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User language code."
    },
    {
      name        = "preferred_language_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Preferred language code."
    },
    {
      name        = "locale_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Locale code."
    },
    {
      name        = "hour_clock_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Hour clock code."
    },
    {
      name        = "currency_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Currency code."
    },
    {
      name        = "currency_numeric_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Currency numeric code."
    },
    {
      name        = "time_zone_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Time zone code."
    },
    {
      name        = "display_language_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Display language code."
    },
    {
      name        = "user_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User name."
    },
    {
      name        = "simplified_view"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Simplified view indicator."
    },
    {
      name        = "worker_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Worker code."
    },
    {
      name        = "user_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "User identifier."
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
      description = "Timestamp when the record was last synced by Fivetran."
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

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_worker'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_organization" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "organization"

  description = "This table stores information about the structure of the company. It defines the different units within the organization and includes details about the hierarchy and characteristics of each unit."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the organization."
    },
    {
      name        = "organization_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code that identifies the organization."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the organization."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the organization."
    },
    {
      name        = "include_manager_in_name"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the manager's name is included in the organization name."
    },
    {
      name        = "include_organization_code_in_name"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the organization code is included in the organization name."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of organization."
    },
    {
      name        = "sub_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Sub-type of the organization."
    },
    {
      name        = "availability_date"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating the availability date."
    },
    {
      name        = "last_updated_date_time"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp of the last update to the record."
    },
    {
      name        = "inactive"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the organization is inactive."
    },
    {
      name        = "inactive_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the organization became inactive."
    },
    {
      name        = "manager_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the manager."
    },
    {
      name        = "organization_owner_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the organization owner."
    },
    {
      name        = "visibility"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Visibility setting of the organization."
    },
    {
      name        = "external_url"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "External URL associated with the organization."
    },
    {
      name        = "top_level_organization_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the top-level organization."
    },
    {
      name        = "superior_organization_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier of the superior organization."
    },
    {
      name        = "staffing_model"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Staffing model used by the organization."
    },
    {
      name        = "location"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Location of the organization."
    },
    {
      name        = "available_for_hire"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the organization is available for hire."
    },
    {
      name        = "hiring_freeze"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether there is a hiring freeze for the organization."
    },
    {
      name        = "supervisory_position_availability_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Availability date for the supervisory position."
    },
    {
      name        = "supervisory_position_earliest_hire_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Earliest hire date for the supervisory position."
    },
    {
      name        = "supervisory_position_worker_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Worker type associated with the supervisory position."
    },
    {
      name        = "supervisory_position_time_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Time type associated with the supervisory position."
    },
    {
      name        = "code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code associated with the organization."
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
      description = "Timestamp of the last sync by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "id",
  ]

  # Note: Self-referencing foreign keys are temporarily removed
  # BigQuery cannot validate self-referencing foreign keys during table creation
  # These foreign keys can be added manually via GCP Console or a separate Terraform apply
  # after the table is created, or via a null_resource with gcloud commands
  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    # Self-referencing foreign keys removed - see note above
    # foreign_keys {
    #   name = "fk_organization_superior_organization"
    #   referenced_table {
    #     dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
    #     project_id = var.project_id
    #     table_id   = "organization"
    #   }
    #   column_references {
    #     referencing_column = "superior_organization_id"
    #     referenced_column  = "id"
    #   }
    # }
    # foreign_keys {
    #   name = "fk_organization_top_level_organization"
    #   referenced_table {
    #     dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
    #     project_id = var.project_id
    #     table_id   = "organization"
    #   }
    #   column_references {
    #     referencing_column = "top_level_organization_id"
    #     referenced_column  = "id"
    #   }
    # }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_organization'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_location" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "location"

  description = "This table stores information about physical locations. It includes details such as geographic coordinates and associated attributes."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the location."
    },
    {
      name        = "inactive"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the location is inactive."
    },
    {
      name        = "latitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The latitude coordinate of the location."
    },
    {
      name        = "longitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The longitude coordinate of the location."
    },
    {
      name        = "altitude"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The altitude of the location."
    },
    {
      name        = "name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the location."
    },
    {
      name        = "time_profile"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The time profile associated with the location."
    },
    {
      name        = "locale"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The locale or regional settings of the location."
    },
    {
      name        = "time_zone"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The time zone of the location."
    },
    {
      name        = "currency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The currency used at the location."
    },
    {
      name        = "currency_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The code associated with the currency used at the location."
    },
    {
      name        = "code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique code or identifier for the location."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the record was marked as deleted by Fivetran."
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
    "id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_location'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_job_profile" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "job_profile"

  description = "This table stores information about job profiles within the organization. It includes details on job requirements, characteristics, and classifications."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the job profile."
    },
    {
      name        = "job_profile_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the job profile."
    },
    {
      name        = "effective_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the job profile became effective."
    },
    {
      name        = "union_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the union associated with the job profile."
    },
    {
      name        = "union_membership_requirement"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Specifies the union membership requirements for the job profile."
    },
    {
      name        = "work_study_award_source_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the source of the work study award for the job profile."
    },
    {
      name        = "work_study_requirement_option_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the work study requirement option for the job profile."
    },
    {
      name        = "compensation_grade_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the compensation grade associated with the job profile."
    },
    {
      name        = "title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Title of the job profile."
    },
    {
      name        = "private_title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Private title of the job profile."
    },
    {
      name        = "summary"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Summary description of the job profile."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Detailed description of the job profile."
    },
    {
      name        = "additional_job_description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Additional description for the job profile."
    },
    {
      name        = "inactive"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the job profile is inactive."
    },
    {
      name        = "include_job_code_in_name"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the job code should be included in the job profile name."
    },
    {
      name        = "work_shift_required"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether a specific work shift is required for the job profile."
    },
    {
      name        = "public_job"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the job profile is public."
    },
    {
      name        = "critical_job"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the job is considered critical."
    },
    {
      name        = "difficulty_to_fill"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Indicates the difficulty level in filling the job profile."
    },
    {
      name        = "management_level"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Management level associated with the job profile."
    },
    {
      name        = "job_category_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the job category associated with the job profile."
    },
    {
      name        = "level"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Level of the job profile."
    },
    {
      name        = "referral_payment_plan"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the referral payment plan associated with the job profile."
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
    "id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_job_profile'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_person_name" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "person_name"

  description = "This table stores various name components associated with individuals. It captures different representations of a person's name, including local variations and titles."

  schema = jsonencode([
    {
      name        = "personal_info_system_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Identifier from the personal information system."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Type of name being recorded."
    },
    {
      name        = "index"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Numerical index for the name record."
    },
    {
      name        = "country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country associated with the name."
    },
    {
      name        = "first_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "First name component of a person's name."
    },
    {
      name        = "middle_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Middle name component of a person's name."
    },
    {
      name        = "last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Last name component of a person's name."
    },
    {
      name        = "secondary_last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Secondary last name component of a person's name."
    },
    {
      name        = "tertiary_last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Tertiary last name component of a person's name."
    },
    {
      name        = "full_name_singapore_malaysia"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Full name formatted for Singapore and Malaysia."
    },
    {
      name        = "local_first_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Local representation of a person's first name."
    },
    {
      name        = "local_middle_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Local representation of a person's middle name."
    },
    {
      name        = "local_last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Local representation of a person's last name."
    },
    {
      name        = "local_secondary_last_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Local representation of a person's secondary last name."
    },
    {
      name        = "local_first_name_2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alternate local representation of a person's first name."
    },
    {
      name        = "local_middle_name_2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alternate local representation of a person's middle name."
    },
    {
      name        = "local_last_name_2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alternate local representation of a person's last name."
    },
    {
      name        = "local_secondary_last_name_2"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Alternate local representation of a person's secondary last name."
    },
    {
      name        = "prefix_title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Prefix or title preceding a person's name."
    },
    {
      name        = "prefix_title_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the prefix or title."
    },
    {
      name        = "prefix_salutation"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Salutation associated with the prefix."
    },
    {
      name        = "social_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Social suffix associated with a person's name."
    },
    {
      name        = "social_suffix_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the social suffix."
    },
    {
      name        = "academic_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Academic suffix associated with a person's name."
    },
    {
      name        = "hereditary_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Hereditary suffix associated with a person's name."
    },
    {
      name        = "honorary_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Honorary suffix associated with a person's name."
    },
    {
      name        = "professional_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Professional suffix associated with a person's name."
    },
    {
      name        = "religious_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Religious suffix associated with a person's name."
    },
    {
      name        = "royal_suffix"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Royal suffix associated with a person's name."
    },
    {
      name        = "additional_name_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of additional name being recorded."
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
    "personal_info_system_id",
    "type",
    "index",
  ]

  table_constraints {
    primary_key {
      columns = [
        "personal_info_system_id",
        "type",
        "index",
      ]
    }
    foreign_keys {
      name = "fk_person_name_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "personal_info_system_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_person_name'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address"

  description = "This table stores address information. It includes details about the location, such as city, municipality, and country."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the address record."
    },
    {
      name        = "personal_info_system_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the personal information system associated with the address."
    },
    {
      name        = "position_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the position associated with the address."
    },
    {
      name        = "address_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code associated with the address."
    },
    {
      name        = "last_modified"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "Timestamp indicating when the address record was last modified."
    },
    {
      name        = "municipality"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Municipality portion of the address."
    },
    {
      name        = "country_region"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Region within the country where the address is located."
    },
    {
      name        = "postal_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Postal code of the address."
    },
    {
      name        = "number_of_days"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "Number of days associated with the address record."
    },
    {
      name        = "municipality_local"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Localized municipality name for the address."
    },
    {
      name        = "effective_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the address became or becomes effective."
    },
    {
      name        = "country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Country where the address is located."
    },
    {
      name        = "city"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "City portion of the address."
    },
    {
      name        = "country_region_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code for the region within the country."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of address."
    },
    {
      name        = "country_alpha_2_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Two-letter country code for the address."
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
    "personal_info_system_id",
    "position_id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
        "personal_info_system_id",
        "position_id",
      ]
    }
    foreign_keys {
      name = "fk_address_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "personal_info_system_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_worker_position" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "worker_position"

  description = "This table stores data about worker positions within the organization. It tracks details related to employment terms, work schedules, and compensation."

  schema = jsonencode([
    {
      name        = "worker_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the worker."
    },
    {
      name        = "position_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the position."
    },
    {
      name        = "position_title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The title of the position."
    },
    {
      name        = "is_primary_job"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the position is the worker's primary job."
    },
    {
      name        = "headcount_restriction_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A code indicating any restrictions on the headcount for the position."
    },
    {
      name        = "job_profile_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier for the job profile."
    },
    {
      name        = "job_exempt"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the job is exempt from overtime pay."
    },
    {
      name        = "work_shift_required"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether a work shift is required for the position."
    },
    {
      name        = "critical_job"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the position is considered critical."
    },
    {
      name        = "difficulty_to_fill"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "An indicator of how difficult the position is to fill."
    },
    {
      name        = "management_level_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The code representing the management level of the position."
    },
    {
      name        = "job_family_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unique identifier for the job family."
    },
    {
      name        = "business_title"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The official title of the position."
    },
    {
      name        = "default_weekly_hours"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The default number of hours per week for the position."
    },
    {
      name        = "effective_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when the position details became effective."
    },
    {
      name        = "end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when the worker's position ended."
    },
    {
      name        = "pay_through_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date through which the worker's compensation is paid."
    },
    {
      name        = "end_employment_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when the worker's employment ended."
    },
    {
      name        = "exclude_from_head_count"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the position is excluded from the headcount."
    },
    {
      name        = "federal_withholding_fein"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The Federal Employer Identification Number (FEIN) for federal withholding."
    },
    {
      name        = "full_time_equivalent_percentage"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The percentage representing the full-time equivalent."
    },
    {
      name        = "pay_rate_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of pay rate associated with the position."
    },
    {
      name        = "position_time_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The time type of the position."
    },
    {
      name        = "employee_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of employee."
    },
    {
      name        = "regular_paid_equivalent_hours"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of regular hours for which the worker is paid, expressed as an equivalent."
    },
    {
      name        = "scheduled_weekly_hours"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of hours scheduled per week for the position."
    },
    {
      name        = "specify_paid_fte"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the paid full-time equivalent (FTE) is specifically defined."
    },
    {
      name        = "paid_fte"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The paid full-time equivalent (FTE) for the position."
    },
    {
      name        = "work_space"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The physical or virtual work environment for the position."
    },
    {
      name        = "specify_working_fte"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the working full-time equivalent (FTE) is specifically defined."
    },
    {
      name        = "start_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when the worker's position started."
    },
    {
      name        = "worker_hours_profile_classification"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The classification of the worker's hours profile."
    },
    {
      name        = "working_fte"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The working full-time equivalent (FTE) for the position."
    },
    {
      name        = "working_time_frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The frequency of working time."
    },
    {
      name        = "working_time_unit"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The unit of time used for working time calculations."
    },
    {
      name        = "working_time_value"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The value of working time."
    },
    {
      name        = "work_hours_profile"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The work hours profile assigned to the position."
    },
    {
      name        = "academic_pay_setup_data_annual_work_period_work_percent_of_year"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The percentage of the year worked during the annual work period for academic pay setup data."
    },
    {
      name        = "academic_pay_setup_data_annual_work_period_start_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The start date of the annual work period for academic pay setup data."
    },
    {
      name        = "academic_pay_setup_data_annual_work_period_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The end date of the annual work period for academic pay setup data."
    },
    {
      name        = "academic_pay_setup_data_disbursement_plan_period_start_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The start date of the disbursement plan period for academic pay setup data."
    },
    {
      name        = "academic_pay_setup_data_disbursement_plan_period_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The end date of the disbursement plan period for academic pay setup data."
    },
    {
      name        = "business_site_summary_location"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The location associated with the business site summary."
    },
    {
      name        = "business_site_summary_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The name of the business site summary."
    },
    {
      name        = "business_site_summary_location_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of location associated with the business site summary."
    },
    {
      name        = "business_site_summary_display_language"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The display language for the business site summary."
    },
    {
      name        = "business_site_summary_local"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The local business site summary."
    },
    {
      name        = "business_site_summary_time_profile"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The time profile associated with the business site summary."
    },
    {
      name        = "business_site_summary_scheduled_weekly_hours"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of hours scheduled per week for the business site summary."
    },
    {
      name        = "expected_assignment_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The anticipated date when the worker's assignment is expected to end."
    },
    {
      name        = "international_assignment_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of international assignment."
    },
    {
      name        = "host_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The country hosting the international assignment."
    },
    {
      name        = "home_country"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The worker's country of origin."
    },
    {
      name        = "start_international_assignment_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The reason for starting an international assignment."
    },
    {
      name        = "payroll_file_number"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The payroll file number associated with the worker's position."
    },
    {
      name        = "frequency"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The frequency of payment or work schedule."
    },
    {
      name        = "pay_rate"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The rate of pay for the position."
    },
    {
      name        = "pay_group"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The pay group associated with the position."
    },
    {
      name        = "payroll_entity"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The payroll entity associated with the position."
    },
    {
      name        = "external_employee"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "An indicator of whether the employee is external."
    },
    {
      name        = "work_shift"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The work shift assigned to the position."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "A boolean value indicating whether the record was deleted by Fivetran."
    },
    {
      name        = "_fivetran_synced"
      type        = "TIMESTAMP"
      mode        = "NULLABLE"
      description = "The timestamp indicating when the data was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "worker_id",
    "position_id",
    "start_date",
  ]

  table_constraints {
    primary_key {
      columns = [
        "worker_id",
        "position_id",
        "start_date",
      ]
    }
    foreign_keys {
      name = "fk_wp_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "worker_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_wp_job_profile"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "job_profile"
      }
      column_references {
        referencing_column = "job_profile_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_worker_position'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_worker_leave_status" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "worker_leave_status"

  description = "This table stores information on worker leave statuses. It tracks various types of leave, including dates, reasons, and related events."

  schema = jsonencode([
    {
      name        = "worker_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the worker."
    },
    {
      name        = "leave_request_event_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The unique identifier for the leave request event."
    },
    {
      name        = "leave_status_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The status code of the leave."
    },
    {
      name        = "description"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "A description of the leave."
    },
    {
      name        = "benefits_effect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave has an effect on benefits."
    },
    {
      name        = "stock_vesting_effect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave has an effect on stock vesting."
    },
    {
      name        = "continuous_service_accrual_effect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave affects continuous service accrual."
    },
    {
      name        = "estimated_leave_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The estimated end date of the leave."
    },
    {
      name        = "first_day_of_work"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The worker's first day of work."
    },
    {
      name        = "leave_end_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The end date of the leave."
    },
    {
      name        = "leave_last_day_of_work"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The last day of work before the leave started."
    },
    {
      name        = "leave_return_event"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The specific event associated with the return from leave."
    },
    {
      name        = "leave_of_absence_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The type of leave of absence taken by the worker."
    },
    {
      name        = "leave_start_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The start date of the leave."
    },
    {
      name        = "leave_type_reason"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The reason for the leave type."
    },
    {
      name        = "on_leave"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the worker is currently on leave."
    },
    {
      name        = "paid_time_off_accrual_effect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave affects paid time off accrual."
    },
    {
      name        = "payroll_effect"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave has an effect on payroll."
    },
    {
      name        = "last_date_for_which_paid"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The last date for which the worker was paid during the leave."
    },
    {
      name        = "expected_due_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The expected due date related to the leave, if applicable."
    },
    {
      name        = "child_birth_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The birth date of the child related to the leave."
    },
    {
      name        = "stillbirth_baby_deceased"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the leave is related to a stillbirth or deceased baby."
    },
    {
      name        = "date_baby_arrived_home_from_hospital"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date the baby arrived home from the hospital."
    },
    {
      name        = "adoption_placement_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of adoption placement, if applicable."
    },
    {
      name        = "adoption_notification_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of adoption notification, if applicable."
    },
    {
      name        = "date_child_entered_country"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date the child entered the country."
    },
    {
      name        = "multiple_child_indicator"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the leave is related to multiple children."
    },
    {
      name        = "number_of_babies_adopted_children"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of babies or adopted children related to the leave."
    },
    {
      name        = "number_of_previous_births"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of previous births for the worker."
    },
    {
      name        = "number_of_previous_maternity_leaves"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of previous maternity leaves taken by the worker."
    },
    {
      name        = "number_of_child_dependents"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The number of child dependents related to the leave."
    },
    {
      name        = "single_parent_indicator"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the worker is a single parent."
    },
    {
      name        = "age_of_dependent"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The age of the dependent related to the leave."
    },
    {
      name        = "work_related"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates whether the leave is work-related."
    },
    {
      name        = "stop_payment_date"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date when payments stopped for the worker."
    },
    {
      name        = "social_security_disability_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The social security disability code associated with the leave."
    },
    {
      name        = "location_during_leave"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The location of the worker during the leave."
    },
    {
      name        = "caesarean_section_birth"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the birth was a caesarean section."
    },
    {
      name        = "leave_percentage"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The percentage of leave taken by the worker."
    },
    {
      name        = "week_of_confinement"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The week of confinement related to the leave."
    },
    {
      name        = "leave_entitlement_override"
      type        = "FLOAT"
      mode        = "NULLABLE"
      description = "The leave entitlement override amount."
    },
    {
      name        = "date_of_recall"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of recall for the worker."
    },
    {
      name        = "child_sdate_of_death"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "The date of death of the child."
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
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "worker_id",
    "leave_request_event_id",
  ]

  table_constraints {
    primary_key {
      columns = [
        "worker_id",
        "leave_request_event_id",
      ]
    }
    foreign_keys {
      name = "fk_wls_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "worker_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  depends_on = [
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_worker_leave_status'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_worker_position_manager" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "worker_position_manager"

  description = "This table stores the hierarchical management structure within the organization. It defines the relationships between workers and their managers."

  schema = jsonencode([
    {
      name        = "worker_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for a worker."
    },
    {
      name        = "manager_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for a manager."
    },
    {
      name        = "position_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for a position."
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
    "worker_id",
    "manager_id",
    "position_id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_worker,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "worker_id",
        "manager_id",
        "position_id",
      ]
    }
    foreign_keys {
      name = "fk_wpm_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "worker_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_wpm_manager"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "manager_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_worker_position_manager'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_worker_position_organization" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "worker_position_organization"

  description = "This table stores information about worker assignments to organizations within a company. It tracks the organizational affiliations of each worker."

  schema = jsonencode([
    {
      name        = "worker_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the worker."
    },
    {
      name        = "position_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the position."
    },
    {
      name        = "organization_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the organization."
    },
    {
      name        = "index"
      type        = "INTEGER"
      mode        = "NULLABLE"
      description = "Numerical index of the record."
    },
    {
      name        = "organization_type_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code representing the type of organization."
    },
    {
      name        = "organization_type_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier for the organization type."
    },
    {
      name        = "date_of_pay_group_assignment"
      type        = "DATE"
      mode        = "NULLABLE"
      description = "Date when the worker was assigned to a pay group."
    },
    {
      name        = "used_in_change_organization_assignments"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the organization is used in change organization assignments."
    },
    {
      name        = "primary_business_site"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The worker's primary business location."
    },
    {
      name        = "organization_name"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Name of the organization."
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
      description = "Timestamp indicating when the record was last synced by Fivetran."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "worker_id",
    "organization_id",
    "position_id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_worker,
    google_bigquery_table.workday_hcm_organization,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "worker_id",
        "position_id",
        "organization_id",
      ]
    }
    foreign_keys {
      name = "fk_wpo_worker"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "worker"
      }
      column_references {
        referencing_column = "worker_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_wpo_organization"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "organization"
      }
      column_references {
        referencing_column = "organization_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_worker_position_organization'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_organization_hierarchy_detail" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "organization_hierarchy_detail"

  description = "This table stores the hierarchical relationships between organizations within a company. It defines the structure of the organization."

  schema = jsonencode([
    {
      name        = "organization_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for an organization."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "The classification of the organization."
    },
    {
      name        = "linked_organization_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier of the organization that the current organization is linked to."
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
      description = "Timestamp of the last time Fivetran successfully synced the data."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "organization_id",
    "linked_organization_id",
    "type",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_organization,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "organization_id",
        "type",
      ]
    }
    foreign_keys {
      name = "fk_ohd_organization"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "organization"
      }
      column_references {
        referencing_column = "organization_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_ohd_linked_organization"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "organization"
      }
      column_references {
        referencing_column = "linked_organization_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_organization_hierarchy_detail'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_supervisory_organization_location" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "supervisory_organization_location"

  description = "This table stores the association between supervisory organizations and their physical locations. It tracks which locations are assigned to specific organizations."

  schema = jsonencode([
    {
      name        = "organization_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the supervisory organization."
    },
    {
      name        = "location_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the location."
    },
    {
      name        = "location_code"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Code identifying the location."
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
      description = "Timestamp of the last time Fivetran synced this row."
    },
  ])

  time_partitioning {
    type  = "DAY"
    field = "_fivetran_synced"
  }

  clustering = [
    "organization_id",
    "location_id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_organization,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "organization_id",
        "location_id",
      ]
    }
    foreign_keys {
      name = "fk_sol_organization"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "organization"
      }
      column_references {
        referencing_column = "organization_id"
        referenced_column  = "id"
      }
    }
    foreign_keys {
      name = "fk_sol_location"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "location"
      }
      column_references {
        referencing_column = "location_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_supervisory_organization_location'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address_line" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address_line"

  description = "This table stores address details. It organizes address information into multiple lines."

  schema = jsonencode([
    {
      name        = "address_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for an address."
    },
    {
      name        = "index"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Numerical index representing the order of the address line within the address."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of address line."
    },
    {
      name        = "line_data"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "The actual text of the address line."
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
    "address_id",
    "index",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_address,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "address_id",
        "index",
      ]
    }
    foreign_keys {
      name = "fk_address_line_address"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "address"
      }
      column_references {
        referencing_column = "address_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address_line'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address_subregion" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address_subregion"

  description = "This table stores information about address subregions. It tracks the association between addresses and their corresponding subregion details."

  schema = jsonencode([
    {
      name        = "address_id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the address."
    },
    {
      name        = "index"
      type        = "INTEGER"
      mode        = "REQUIRED"
      description = "Numerical index of the subregion entry."
    },
    {
      name        = "type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of subregion associated with the address."
    },
    {
      name        = "subregion_data"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Data related to the subregion."
    },
    {
      name        = "_fivetran_deleted"
      type        = "BOOLEAN"
      mode        = "NULLABLE"
      description = "Indicates if the record was marked as deleted by Fivetran."
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
    "address_id",
    "index",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_address,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "address_id",
        "index",
      ]
    }
    foreign_keys {
      name = "fk_address_subregion_address"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "address"
      }
      column_references {
        referencing_column = "address_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address_subregion'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address_use_for_tenanted_reference" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address_use_for_tenanted_reference"

  description = "This table stores information about the association between addresses and their usage within a tenanted system."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the address use record."
    },
    {
      name        = "address_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the address."
    },
    {
      name        = "communication_usage_behaviour_tenanted"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Specifies the tenanted communication usage behavior associated with the address."
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
    "address_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_address,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_auftr_address"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "address"
      }
      column_references {
        referencing_column = "address_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address_use_for_tenanted_reference'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address_usage_type" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address_usage_type"

  description = "This table stores information about the usage of addresses. It tracks the association between addresses and their corresponding usage types."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the address usage type record."
    },
    {
      name        = "address_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Unique identifier for an address."
    },
    {
      name        = "communication_usage_type"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Type of usage for the communication address."
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
    "address_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_address,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_aut_address"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "address"
      }
      column_references {
        referencing_column = "address_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address_usage_type'. Ensure the dataset is defined in var.datasets."
    }
  }
}

resource "google_bigquery_table" "workday_hcm_address_use_for_reference" {
  dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
  table_id   = "address_use_for_reference"

  description = "This table tracks the association between addresses and their intended uses within the Workday HCM system."

  schema = jsonencode([
    {
      name        = "id"
      type        = "STRING"
      mode        = "REQUIRED"
      description = "Unique identifier for the address use record."
    },
    {
      name        = "address_id"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Identifier for the associated address."
    },
    {
      name        = "communication_usage_behaviour"
      type        = "STRING"
      mode        = "NULLABLE"
      description = "Description of the communication usage behavior for the address."
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
    "address_id",
    "id",
  ]

  depends_on = [
    google_bigquery_table.workday_hcm_address,
    google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix]
  ]

  table_constraints {
    primary_key {
      columns = [
        "id",
      ]
    }
    foreign_keys {
      name = "fk_aufr_address"
      referenced_table {
        dataset_id = google_bigquery_dataset.datasets[var.workday_hcm_dataset_prefix].dataset_id
        project_id = var.project_id
        table_id   = "address"
      }
      column_references {
        referencing_column = "address_id"
        referenced_column  = "id"
      }
    }
  }

  labels = merge(local.labels, local.lineage_labels_workday_hcm)
  lifecycle {
    ignore_changes = [
      schema,
      time_partitioning,
      clustering,
    ]

    precondition {
      condition     = contains(keys(google_bigquery_dataset.datasets), var.workday_hcm_dataset_prefix)
      error_message = "Dataset '${var.workday_hcm_dataset_prefix}' must exist before creating table 'workday_hcm_address_use_for_reference'. Ensure the dataset is defined in var.datasets."
    }
  }
}
