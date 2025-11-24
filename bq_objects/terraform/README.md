# BigQuery Terraform Configuration

This Terraform configuration manages BigQuery datasets and tables for the AMerch project.

## Overview

This configuration creates:
- **10 BigQuery Datasets** (with configurable names)
- **54 BigQuery Tables** with schemas, partitioning, and clustering

## CI/CD Deployment (Cloud Build)

Infrastructure is deployed via Cloud Build triggered by Bitbucket branch merges:

- **Repository:** `dashmanagement/bq_dataflow` (Bitbucket)
- **CI/CD Project:** `quantiphi-test-470710`
- **State Bucket:** `amerch-terraform-state` (in CI/CD project)
- **State Prefix:** `bq_dataflow/{environment}/bq_objects` (e.g., `bq_dataflow/dev/bq_objects`, `bq_dataflow/prod/bq_objects`)
- **Configuration:** `cloudbuild-plan.yaml` (repository root - deploys all infrastructure)
- **Service Account:** Project-specific Terraform service accounts (created by project owner)

**Workflow:**
1. Developer creates feature branch and makes Terraform changes
2. Opens Pull Request → Cloud Build runs `terraform plan` for all infrastructure (no apply)
3. Plan output visible in PR for review
4. Merge to `dev` or `main` branch → Cloud Build runs `terraform plan` + `terraform apply` for all infrastructure
5. **Manual approval required** before apply steps execute
6. All infrastructure deployed after approval (POS ingestion first, then BigQuery objects)

**Environment Mapping:**
- `dev` branch → deploys to `quantiphi-test-470710` project
- `main` branch → deploys to `amerchgcp-amerch-prod` project

**Note:** Cloud Build triggers and service accounts are configured by the project owner. See `CLOUD_BUILD_SETUP.md` in the repository root for details.

## Prerequisites

1. **Terraform** >= 1.0 installed
2. **Google Cloud SDK** installed and configured
3. **GCP Project** with BigQuery API enabled
4. **Appropriate IAM permissions** to create datasets and tables

## Setup

1. **Configure variables:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your project ID and settings
   # NOTE: All variables must be explicitly set - no defaults are provided to prevent environment coupling
   ```

2. **Required Variables:**
   All variables must be explicitly set in `terraform.tfvars`:
   - `project_id` - GCP project ID (no default)
   - `region` - GCP region (no default)
   - `gcloud_mysql_dataset_prefix` - MySQL dataset prefix (no default)
   - `salesforce_dataset_prefix` - Salesforce dataset prefix (no default)
   - `workday_hcm_dataset_prefix` - Workday HCM dataset prefix (no default)
   - `datasets` - Dataset configuration map (no default - see terraform.tfvars.example)
   - `labels` - Resource labels map (no default)

   **Variable Validation:**
   All variables include validation to ensure values conform to GCP requirements:
   - **Dataset Prefixes**: Must be 1-100 characters, start with lowercase letter or underscore, contain only lowercase letters, numbers, and underscores
   - **Labels**: Keys must be 1-63 characters starting with lowercase letter; values must be 0-63 characters with lowercase alphanumeric, hyphens, and underscores only (no dots)
   - **Dataset Keys**: Must be 1-1024 characters, start with letter or underscore, contain only letters, numbers, and underscores
   - **Project ID**: Must be valid GCP project ID format (6-30 characters, lowercase letters, numbers, hyphens)
   - **Region**: Must be a valid GCP region from the whitelist
   
   Invalid values will be caught during `terraform validate` with clear error messages.

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Review the plan:**
   ```bash
   terraform plan -var-file=terraform.tfvars
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply -var-file=terraform.tfvars
   ```

## Provider Version Management

### Current Provider Versions

The Terraform Google provider is pinned to an exact version for reproducibility and stability:

- **Google Provider**: `5.0.0` (pinned)

Provider versions are specified in `main.tf` and locked in `.terraform.lock.hcl`.

### Upgrading Provider Versions

**Important**: Provider upgrades should be tested thoroughly before deploying to production.

**Upgrade Process**:

1. **Review Release Notes**: Check the [Google Provider changelog](https://github.com/hashicorp/terraform-provider-google/blob/main/CHANGELOG.md) for breaking changes and new features.

2. **Update Version in Code**:
   ```hcl
   # In main.tf
   required_providers {
     google = {
       source  = "hashicorp/google"
       version = "5.X.X"  # Update to target version
     }
   }
   ```

3. **Test Locally**:
   ```bash
   # Update lock file
   terraform init -upgrade
   
   # Validate configuration
   terraform validate
   
   # Review plan for unexpected changes
   terraform plan -var-file=terraform.tfvars.dev  # or terraform.tfvars.prod for production
   ```

4. **Test in Development**:
   - Create a feature branch with the provider upgrade
   - Open a Pull Request
   - Review Cloud Build plan output for any unexpected changes
   - Merge to `dev` branch and monitor deployment

5. **Deploy to Production**:
   - After successful dev deployment, merge to `main` branch
   - Monitor production deployment closely
   - Verify all resources are functioning correctly

**Best Practices**:
- Upgrade one provider at a time
- Test in development environment first
- Review all plan outputs carefully
- Keep lock files in version control
- Document any breaking changes or workarounds

## Configuration

### Variables

- `project_id`: GCP project ID (required - no default)
- `region`: GCP region (required - no default)
- `gcloud_mysql_dataset_prefix`: Prefix for Fivetran dataset names (required - no default)
- `salesforce_dataset_prefix`: Prefix for Salesforce dataset names (required - no default)
- `workday_hcm_dataset_prefix`: Prefix for Workday HCM dataset names (required - no default)
- `datasets`: Dataset configuration map (required - no default, see terraform.tfvars.example)
- `labels`: Resource labels map (required - no default)
- `datasets`: Map of dataset configurations (datasets use suffixes which are prefixed automatically based on type)
- `labels`: Common labels applied to all resources

### Datasets

The following datasets are created (with default naming):
- Fivetran MySQL Performance datasets (prefix configurable via `gcloud_mysql_dataset_prefix`, default: `raw_fivetran_gcloud_performance`):
  - `raw_fivetran_gcloud_performance_coreapp`
  - `raw_fivetran_gcloud_performance_activity`
  - `raw_fivetran_gcloud_performance_alignment`
  - `raw_fivetran_gcloud_performance_billing`
  - `raw_fivetran_gcloud_performance_employee`
  - `raw_fivetran_gcloud_performance_item`
  - `raw_fivetran_gcloud_performance_ninja`
  - `raw_fivetran_gcloud_performance_program`
- Salesforce dataset (prefix configurable via `salesforce_dataset_prefix`, default: `raw_fivetran_salesforce`):
  - `raw_fivetran_salesforce`
- Workday HCM dataset (prefix configurable via `workday_hcm_dataset_prefix`, default: `raw_fivetran_workday_hcm`):
  - `raw_fivetran_workday_hcm`

Note: Dataset names are constructed as follows:
- Fivetran: `{gcloud_mysql_dataset_prefix}_{suffix}` where suffix is defined in the `datasets` variable (e.g., "coreapp", "activity")
- Salesforce: `{salesforce_dataset_prefix}` (no suffix, uses prefix directly)
- Workday HCM: `{workday_hcm_dataset_prefix}` (no suffix, uses prefix directly)

### Tables

All 54 tables from `Create Table Script.sql` are defined with:
- Full schema definitions
- Time partitioning (where applicable)
- Clustering (where applicable)
- Field descriptions
- Table descriptions


## Regenerating Tables

If you need to regenerate the table files from the SQL script:

```bash
# Generate single tables.tf file
python3 scripts/convert_sql_to_tf.py

# Then split into multiple files by dataset
python3 scripts/split-tables.py
```

This will:
1. Parse `../BQ Scripts/Create Table Script.sql` and generate a single `tables.tf` file
2. Split `tables.tf` into multiple files in the `tables/` directory, organized by dataset

**Note:** The tables are split into separate files for better maintainability. Terraform automatically loads all `.tf` files in the directory, so the split is purely organizational and doesn't affect functionality.

## Customization

### Changing Project Name

Edit `terraform.tfvars`:
```hcl
project_id = "your-project-id"
```

### Changing Fivetran Dataset Prefix

The Fivetran dataset prefix is configurable. For example, to change from `fivetran_gcloud_mysql_performance_dev` to `fivetran_gcloud_mysql_prod`:

Edit `terraform.tfvars`:
```hcl
gcloud_mysql_dataset_prefix = "fivetran_gcloud_mysql_prod"
```

This will automatically update all Fivetran dataset names:
- `fivetran_gcloud_mysql_prod_coreapp`
- `fivetran_gcloud_mysql_prod_activity`
- etc.

### Changing Salesforce Dataset Prefix

The Salesforce dataset prefix is configurable. For example, to change from `salesforce` to `salesforce_prod`:

Edit `terraform.tfvars`:
```hcl
salesforce_dataset_prefix = "salesforce_prod"
```

This will automatically update the Salesforce dataset name:
- `salesforce_prod_sandbox`

### Changing Workday HCM Dataset Prefix

The Workday HCM dataset prefix is configurable. For example, to change from `workday_hcm` to `workday_hcm_prod`:

Edit `terraform.tfvars`:
```hcl
workday_hcm_dataset_prefix = "workday_hcm_prod"
```

This will automatically update the Workday HCM dataset name to:
- `workday_hcm_prod`

### Changing Dataset Names

Modify the `datasets` variable in `variables.tf` or override in `terraform.tfvars`. 
- For Fivetran datasets, change the suffix (e.g., "coreapp", "activity") and the prefix will be applied automatically.
- For Salesforce, the suffix is "sandbox" (fixed).
- For Workday HCM, no suffix is used (prefix is the full dataset name).

### Adding/Removing Tables

1. Update `Create Table Script.sql`
2. Regenerate `tables.tf` using the conversion script
3. Run `terraform plan` to review changes
4. Run `terraform apply` to apply changes

## File Structure

```
Terraform Scripts/
├── main.tf                 # Provider configuration
├── variables.tf            # Variable definitions
├── datasets.tf             # Dataset resources
├── tables/                 # Table resources (split by dataset for maintainability)
│   ├── mysql_coreapp.tf    # MySQL Performance coreapp tables
│   ├── mysql_activity.tf   # MySQL Performance activity tables
│   ├── mysql_alignment.tf  # MySQL Performance alignment tables
│   ├── mysql_billing.tf    # MySQL Performance billing tables
│   ├── mysql_employee.tf   # MySQL Performance employee tables
│   ├── mysql_item.tf       # MySQL Performance item tables
│   ├── mysql_ninja.tf      # MySQL Performance ninja tables
│   ├── mysql_program.tf    # MySQL Performance program tables
│   ├── salesforce.tf       # Salesforce tables
│   └── workday_hcm.tf      # Workday HCM tables
├── outputs.tf              # Output definitions
├── terraform.tfvars.example # Example variables file
├── terraform.tfvars.dev     # Development environment variables
├── terraform.tfvars.prod    # Production environment variables
├── scripts/
│   ├── convert_sql_to_tf.py    # SQL to Terraform converter script
│   └── split-tables.py         # Script to split tables.tf by dataset
└── README.md               # This file
```

## Important Notes

- Datasets are created with `delete_contents_on_destroy = false` for safety
- Tables include partitioning and clustering as defined in the SQL script
- Foreign key constraints are not enforced (as per BigQuery best practices)
- Labels are automatically applied from variables with enhanced labels for cost tracking
- Fivetran-managed tables may have schema drift - use `lifecycle { ignore_changes = [schema, time_partitioning] }` to prevent Terraform from attempting to replace them
- Some tables have `deletion_protection = false` to allow Terraform to manage them (Fivetran-managed tables)

### Resource Labels

All BigQuery resources (datasets and tables) include comprehensive labels for cost tracking, resource organization, and data lineage:

- **Standard Labels**: Applied from `var.labels` (environment, managed_by, project, cost_center)
- **Enhanced Labels** (automatically added):
  - `data_classification = "internal"` - For security/compliance classification
  - `backup_required = "false"` - BigQuery has built-in replication, no additional backup needed
  - `owner = "data-engineering"` - For ownership tracking and resource management
- **Schema Labels**: `schema_version` and `schema_version_date` for schema versioning
- **Dataplex Labels**: `dataplex-data-documentation-published-project` for Data Catalog integration
- **Data Lineage Labels** (automatically added to all tables):
  - `data_source` - Source of data ingestion: "fivetran" or "gcs"
  - `source_system` - Specific source system: "gcloud_mysql_performance", "salesforce", "workday_hcm", or "pos_files"
  - `ingestion_type` - Method of ingestion: "replication" (Fivetran) or "file_upload" (POS files)
  - `last_updated_by` - Always "terraform" to indicate infrastructure-managed

These labels enable better cost allocation, compliance tracking, resource management, and automated data lineage tracking for governance and audit purposes.

## Resource Validation and Preconditions

All BigQuery table resources include preconditions to validate dependencies before creation. This improves error messages and prevents common deployment errors.

### Preconditions on Tables

Each table resource includes a precondition that verifies the dataset exists before attempting to create the table:

```hcl
lifecycle {
  ignore_changes = [schema, time_partitioning, clustering]
  precondition {
    condition     = contains(keys(google_bigquery_dataset.datasets), "${var.gcloud_mysql_dataset_prefix}_coreapp")
    error_message = "Dataset '${var.gcloud_mysql_dataset_prefix}_coreapp' must exist before creating table 'chains'. Ensure the dataset is defined in var.datasets."
  }
}
```

**Benefits:**
- **Early Error Detection**: Catches missing datasets during `terraform plan` instead of during `terraform apply`
- **Clear Error Messages**: Provides specific information about which dataset is missing and which table requires it
- **Prevents Partial Deployments**: Ensures all dependencies are in place before creating resources

**Common Errors:**
If you see a precondition failure, it typically means:
- The dataset is not defined in `var.datasets`
- The dataset key doesn't match the expected pattern (e.g., `${var.gcloud_mysql_dataset_prefix}_coreapp`)
- The dataset resource hasn't been created yet (check resource dependencies)

**Troubleshooting:**
1. Verify the dataset is defined in `variables.tf` or `terraform.tfvars`
2. Check that the dataset key matches the pattern used in the table's `dataset_id` reference
3. Ensure datasets are created before tables (Terraform handles this automatically via dependencies)

## Architecture

### Infrastructure Components

This Terraform configuration manages BigQuery infrastructure that serves as the data warehouse for multiple source systems:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    Source Systems & Data Ingestion                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
│  │ Cloud SQL     │  │ Salesforce   │  │ Workday HCM  │            │
│  │ MySQL         │  │              │  │              │            │
│  │ Performance   │  │              │  │              │            │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘            │
│         │                  │                  │                     │
│         │ Fivetran         │ Fivetran        │ Fivetran            │
│         │ Connectors       │ Connector       │ Connector           │
└─────────┼──────────────────┼──────────────────┼────────────────────┘
          │                  │                  │
          │                  │                  │
          ▼                  ▼                  ▼
┌─────────────────────────────────────────────────────────────────────┐
│              BigQuery Infrastructure (Managed by Terraform)          │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  10 Datasets (google_bigquery_dataset.datasets)              │  │
│  │  ┌────────────────────────────────────────────────────────┐  │  │
│  │  │ • 8 MySQL Performance datasets                          │  │  │
│  │  │   (coreapp, activity, alignment, billing, etc.)         │  │  │
│  │  │ • 1 Salesforce dataset                                  │  │  │
│  │  │ • 1 Workday HCM dataset                                 │  │  │
│  │  │ • 1 POS Files dataset                                   │  │  │
│  │  └────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  54 Tables (google_bigquery_table.*)                          │  │
│  │  ┌────────────────────────────────────────────────────────┐  │  │
│  │  │ • Partitioned by _fivetran_synced (where applicable)   │  │  │
│  │  │ • Clustered for query optimization                      │  │  │
│  │  │ • Schema versioning labels (schema_version, etc.)      │  │  │
│  │  │ • Lifecycle blocks (ignore schema drift)                │  │  │
│  │  │ • Preconditions (validate dataset existence)            │  │  │
│  │  └────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
          │
          │ Analytics & Reporting
          ▼
┌─────────────────────────────────────────────────────────────────────┐
│         Downstream Consumers                                         │
│  - Data Studio dashboards                                            │
│  - Custom analytics tools                                            │
│  - ETL pipelines                                                     │
│  - POS file ingestion pipeline (loads to pos_files dataset)         │
└─────────────────────────────────────────────────────────────────────┘
```

### Infrastructure Management Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                    Terraform Configuration                           │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  bq_objects/terraform/                                        │  │
│  │  ├── main.tf (provider, locals, labels)                       │  │
│  │  ├── datasets.tf (10 dataset resources)                      │  │
│  │  ├── tables.tf (54 table resources)                          │  │
│  │  ├── variables.tf (input variables with validation)          │  │
│  │  └── outputs.tf (output values)                              │  │
│  └──────────────────────────────────────────────────────────────┘  │
└───────────────────────┬──────────────────────────────────────────────┘
                        │
                        │ terraform plan/apply
                        ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    CI/CD Pipeline (Cloud Build)                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  1. init-bq: Initialize Terraform                             │  │
│  │  2. validate-bq: Validate configuration                       │  │
│  │  3. import-bq: Import existing resources (if needed)          │  │
│  │  4. plan-bq: Generate execution plan                          │  │
│  │  5. detect-drift-bq: Detect schema drift (logs only)         │  │
│  │  6. [Manual Approval Gate]                                    │  │
│  │  7. apply-bq: Apply infrastructure changes                   │  │
│  └──────────────────────────────────────────────────────────────┘  │
└───────────────────────┬──────────────────────────────────────────────┘
                        │
                        │ State Management
                        ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    Terraform State (GCS Backend)                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  Bucket: amerch-terraform-state                                    │  │
│  │  Prefix: bq_dataflow/{env}/bq_objects                         │  │
│  │  - Tracks resource state                                      │  │
│  │  - Enables state locking                                      │  │
│  │  - Version controlled                                         │  │
│  └──────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

### Key Features

- **Infrastructure as Code**: All BigQuery resources defined in Terraform
- **Schema Drift Detection**: Automated detection and logging of Fivetran schema changes
- **Lifecycle Management**: Prevents Terraform from reverting Fivetran-managed schema changes
- **Resource Validation**: Preconditions ensure dependencies exist before resource creation
- **CI/CD Integration**: Automated deployment via Cloud Build with approval gates
- **State Management**: Centralized state storage in GCS with environment isolation

## Data Lineage

Data lineage is automatically tracked through BigQuery table labels (see [Resource Labels](#resource-labels) section above). All tables include lineage metadata:
- **Data Source**: Identifies the ingestion mechanism (Fivetran or GCS)
- **Source System**: Identifies the specific source system (MySQL Performance, Salesforce, Workday HCM, POS Files)
- **Ingestion Type**: Identifies how data is ingested (replication or file upload)

This automated lineage tracking enables compliance, audit trails, and data governance without manual documentation that can become stale.

### Source Systems

Data flows into BigQuery from three primary source systems via Fivetran connectors:

1. **Cloud SQL MySQL Performance Database**
   - **Fivetran Connector**: MySQL replication connector
   - **Datasets**: 8 datasets (coreapp, activity, alignment, billing, employee, item, ninja, program)
   - **Update Frequency**: Real-time replication (varies by connector configuration)
   - **Data Types**: Transactional data, performance metrics, employee data, program data

2. **Salesforce**
   - **Fivetran Connector**: Salesforce API connector
   - **Dataset**: `raw_fivetran_salesforce`
   - **Update Frequency**: Scheduled syncs (typically hourly or daily)
   - **Data Types**: Opportunities, contacts, users, quotes, forecasts, projects, programs

3. **Workday HCM**
   - **Fivetran Connector**: Workday HCM connector
   - **Dataset**: `raw_fivetran_workday_hcm`
   - **Update Frequency**: Scheduled syncs (typically daily)
   - **Data Types**: Worker data, organization hierarchy, positions, locations, addresses

### Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    Source Systems                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Cloud SQL    │  │ Salesforce   │  │ Workday HCM  │     │
│  │ MySQL        │  │              │  │              │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
└─────────┼─────────────────┼──────────────────┼──────────────┘
          │                 │                  │
          │ Fivetran       │ Fivetran        │ Fivetran
          │ Connectors     │ Connector       │ Connector
          ▼                 ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│              BigQuery Raw Datasets                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ raw_fivetran_gcloud_performance_* (8 datasets)      │   │
│  │ raw_fivetran_salesforce                              │   │
│  │ raw_fivetran_workday_hcm                             │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ 54 Tables with:                                      │   │
│  │ - Partitioning (time-based where applicable)         │   │
│  │ - Clustering (up to 4 columns)                        │   │
│  │ - Schema definitions                                  │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
          │
          │ Analytics & Reporting
          ▼
┌─────────────────────────────────────────────────────────────┐
│         Downstream Consumers                                │
│  - Data Studio dashboards                                   │
│  - Custom analytics tools                                    │
│  - ETL pipelines                                            │
└─────────────────────────────────────────────────────────────┘
```

## Schema Management

### Fivetran-Managed vs Terraform-Managed Tables

**Fivetran-Managed Tables**:
- Schema and data are managed by Fivetran connectors
- Schema changes in source systems are automatically synced
- Terraform provisions the table structure initially
- Schema drift is expected and handled via `ignore_changes` lifecycle blocks
- Examples: Most tables in Fivetran datasets

**Terraform-Managed Tables**:
- Schema is defined and managed entirely by Terraform
- Changes to schema require Terraform updates
- No automatic schema evolution from source systems
- Examples: Custom tables, staging tables (if any)

### Schema Evolution Strategy

#### Fivetran-Managed Table Schema Changes

**Automatic Schema Evolution:**
- Fivetran automatically syncs schema changes from source systems
- Schema modifications happen outside of Terraform control
- Terraform lifecycle blocks prevent conflicts by ignoring schema changes

**Process:**
1. Source system schema changes (e.g., new column added in MySQL)
2. Fivetran detects the change and syncs to BigQuery
3. BigQuery table schema is updated automatically
4. Terraform detects drift but ignores it (via lifecycle blocks)
5. Schema drift detection script logs the change to Cloud Logging
6. No Terraform action required

**Monitoring:**
- Schema drift is detected automatically in Cloud Build (`detect-drift-bq` step)
- Changes are logged to Cloud Logging with structured JSON format
- Log entries include: table name, change count, build ID
- Can create Cloud Monitoring alerts based on log entries

**Example Workflow:**
```
Day 1: Source system adds column "new_field" to MySQL table
Day 2: Fivetran syncs and adds "new_field" to BigQuery table
Day 3: Cloud Build runs → detect-drift-bq step logs the schema change
       → Terraform plan shows no changes (lifecycle blocks ignore it)
       → Build completes successfully
```

#### Terraform-Managed Table Schema Changes

**Manual Schema Updates:**
- Schema is defined entirely in Terraform (`tables.tf`)
- Changes require updating Terraform code and applying

**Process:**
1. Update schema definition in `bq_objects/terraform/tables.tf`
2. Run `terraform plan` to review changes
3. Review impact on downstream consumers
4. Apply changes via Cloud Build or `terraform apply`
5. Verify changes in BigQuery console

**Breaking Schema Changes:**
Breaking changes (column removal, type changes, required field changes) require careful planning:

1. **Impact Assessment:**
   - Identify all downstream consumers (dashboards, reports, ETL pipelines)
   - Review query dependencies
   - Check data transformation logic

2. **Change Strategy:**
   - **Option A:** Create new table with new schema, migrate data, deprecate old table
   - **Option B:** Add new column, migrate data, remove old column in separate change
   - **Option C:** Use schema versioning labels to track changes

3. **Coordination:**
   - Notify downstream consumers before changes
   - Provide migration timeline
   - Document breaking changes in changelog

4. **Testing:**
   - Test changes in development environment first
   - Validate queries still work after schema change
   - Verify data integrity

5. **Deployment:**
   - Use Cloud Build plan step to preview changes
   - Review plan output carefully
   - Apply changes during maintenance window if needed

**Schema Versioning:**
- ✅ All tables have `schema_version` and `schema_version_date` labels for tracking
- Current version: 1.0.0 (initialized 2025-11-19)
- When making schema changes, increment the version in `main.tf` local.labels
- Document schema changes in table descriptions
- Maintain changelog for significant schema changes

### Schema Change Detection and Monitoring

**Automated Detection:**
- Schema drift detection runs automatically in Cloud Build after each Terraform plan
- Script: `bq_objects/terraform/scripts/detect-schema-drift.sh`
- Detects changes on Fivetran-managed tables
- Logs findings to Cloud Logging for monitoring

**Accessing Schema Drift Logs:**
```bash
# View recent schema drift logs
gcloud logging read "resource.type=build AND jsonPayload.message=~'Fivetran table changes detected'" \
  --limit=50 \
  --format=json

# Filter by specific table
gcloud logging read "resource.type=build AND jsonPayload.tables=~'gcloud_mysql_performance_coreapp_chains'" \
  --limit=20
```

**Creating Alerts:**
Create Cloud Monitoring alerts based on schema drift log entries:
- Alert when schema changes are detected
- Alert on specific tables
- Alert on high change frequency

### Table Dependencies

Tables may have foreign key relationships defined (for documentation purposes). BigQuery does not enforce foreign keys, but they are useful for:
- Understanding data relationships
- Query optimization hints
- Data lineage tracking

Key dependency patterns:
- Salesforce tables reference `contact`, `user`, `opportunity`
- Workday HCM tables reference `organization`, `worker`, `location`
- MySQL Performance tables have internal relationships within modules

## Data Quality

### Validation

BigQuery performs automatic validation during data loads:

- **Schema Validation**: Data types must match table schema
- **Required Fields**: NOT NULL columns must have values
- **Data Type Conversion**: Automatic conversion where possible (with warnings)

### Quality Checks

Recommended data quality monitoring:

1. **Row Count Validation**: Monitor row counts for unexpected changes
   ```sql
   SELECT COUNT(*) as row_count, 
          DATE(_PARTITIONTIME) as partition_date
   FROM `project.dataset.table`
   GROUP BY partition_date
   ORDER BY partition_date DESC
   ```

2. **Bad Records**: Monitor BigQuery load job statistics for bad records
   - Check `statistics.load.badRecords` in job metadata
   - Investigate records that fail validation

3. **Data Freshness**: Monitor last update timestamps (if available in source data)
   ```sql
   SELECT MAX(last_updated_timestamp) as last_update
   FROM `project.dataset.table`
   ```

### Handling Bad Records

- **Max Bad Records**: Tables are configured with `max_bad_records = 10` (configurable in load jobs)
- **Error Logging**: Bad records are logged in BigQuery job errors
- **Investigation**: Review job error details to identify problematic records
- **Resolution**: Fix source data or adjust schema to accommodate data variations

## Backup & Disaster Recovery

### State Backup

Terraform state is stored in GCS bucket `amerch-terraform-state`:
- **Location**: `bq_dataflow/{environment}/bq_objects/terraform.tfstate`
- **Versioning**: Enabled on state bucket (if configured)
- **Backup Strategy**: State is automatically backed up by GCS versioning

### Data Retention

- **BigQuery Data**: No automatic expiration policies configured (per architect decision)
- **Partitioned Tables**: Partitions are retained indefinitely (no expiration rules)
- **Manual Management**: Data retention is managed manually or via external processes

### Recovery Procedures

**State Recovery**:
1. If state is corrupted, restore from GCS version history
2. If state is lost, re-import resources using `terraform import`

**Data Recovery**:
1. BigQuery provides point-in-time recovery for 7 days (if enabled)
2. For longer retention, use BigQuery snapshots or export to GCS
3. Fivetran can re-sync historical data if needed

**Disaster Recovery**:
1. Infrastructure: Re-deploy via Terraform from state backup
2. Data: Restore from BigQuery snapshots or Fivetran re-sync
3. State: Restore from GCS version history

## Security

For comprehensive security documentation, including service account permissions, least privilege principles, and permission matrices, see [docs/SECURITY.md](../../../docs/SECURITY.md).

### IAM Roles

**Terraform Service Account** (`sa-bq-tf-admin@amerchgcp-amerch-{env}.iam.gserviceaccount.com`):
- Infrastructure provisioning permissions for BigQuery datasets and tables
- Service account impersonation capabilities
- State bucket access

**See [docs/SECURITY.md](../../../docs/SECURITY.md) for detailed permission justifications, permission matrix, and least privilege documentation.**

### Encryption

- **BigQuery**: Default encryption at rest (Google-managed keys)
- **State Files**: Encrypted at rest in GCS state bucket
- **In Transit**: All communications use TLS

**Note:** CMEK (Customer-Managed Encryption Keys) is optional and not required for sales data. The infrastructure supports CMEK via `kms_key_name` variable if needed in the future, but Google-managed encryption is sufficient for business sales data.

### Access Control

- **BigQuery Datasets**: Access controlled via IAM policies
- **State Bucket**: Access restricted to Cloud Build and Terraform service accounts
- **No Public Access**: All resources are private and require authentication

## Performance

### Partitioning Strategy

Tables are partitioned by time where applicable:

- **Partition Type**: Time-based partitioning on date/timestamp columns
- **Partition Expiration**: Not configured (manual management)
- **Benefits**: Reduces query costs and improves performance for time-range queries

**Partitioned Tables**:
- All 54 tables are partitioned by `_fivetran_synced` timestamp field
- Partition column is `_fivetran_synced` (Fivetran sync timestamp)
- **Partition Expiration**: Not configured (per architect decision - no expiration rules)

### Clustering

Tables are clustered on frequently queried columns:

- **Max Clustering Columns**: 4 columns (BigQuery limit)
- **Clustering Strategy**: Based on common query patterns
- **Benefits**: Improves query performance and reduces costs for filtered queries

**Common Clustering Patterns**:
- Salesforce: `opportunity_id`, `contact_id`, `user_id`
- Workday HCM: `worker_id`, `organization_id`
- MySQL Performance: Module-specific (e.g., `store_id`, `program_id`)

### Query Optimization

1. **Use Partition Filters**: Always include partition filters in WHERE clauses
   ```sql
   SELECT * FROM `project.dataset.table`
   WHERE _PARTITIONTIME >= TIMESTAMP('2024-01-01')
   ```

2. **Use Clustering Filters**: Filter on clustering columns when possible
   ```sql
   SELECT * FROM `project.dataset.table`
   WHERE opportunity_id = '12345'
   ```

3. **Limit Columns**: Select only needed columns to reduce data scanned
   ```sql
   SELECT column1, column2 FROM `project.dataset.table`
   ```

4. **Use Approximate Aggregations**: For large datasets, consider `APPROX_COUNT_DISTINCT()`

## Data Retention

### Retention Policies

- **No Automatic Deletion**: Tables do not have automatic deletion policies configured
- **Manual Management**: Data retention is managed manually or via scheduled queries
- **Partition Expiration**: Can be configured per-table for automatic partition cleanup

### Archival Strategy

For long-term data retention:

1. **BigQuery Storage**: Keep data in BigQuery for active querying (cost-effective for frequently accessed data)
2. **GCS Export**: Export old partitions to GCS for archival (lower cost for infrequently accessed data)
3. **BigQuery Snapshots**: Use snapshots for point-in-time recovery

### Deletion Policies

- **Manual Deletion**: Use `DELETE` statements or `DROP TABLE` for data removal
- **Partition Deletion**: Delete specific partitions to remove old data:
  ```sql
  DELETE FROM `project.dataset.table`
  WHERE _PARTITIONTIME < TIMESTAMP('2020-01-01')
  ```

## Operations

### Monitoring Queries

**Dataset Size Monitoring**:
```sql
SELECT 
  dataset_id,
  SUM(size_bytes) / POW(10, 12) as size_tb
FROM `region-us.INFORMATION_SCHEMA.TABLE_STORAGE_BY_ORGANIZATION`
WHERE project_id = 'quantiphi-test-470710'
GROUP BY dataset_id
ORDER BY size_tb DESC
```

**Table Row Count Monitoring**:
```sql
SELECT 
  table_schema,
  table_name,
  row_count,
  size_bytes / POW(10, 9) as size_gb
FROM `region-us.INFORMATION_SCHEMA.TABLES`
WHERE project_id = 'quantiphi-test-470710'
ORDER BY row_count DESC
LIMIT 20
```

**Job History Monitoring**:
```sql
SELECT 
  job_id,
  creation_time,
  total_bytes_processed / POW(10, 12) as tb_processed,
  state
FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
WHERE project_id = 'quantiphi-test-470710'
  AND creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
ORDER BY creation_time DESC
```

### Maintenance Procedures

**Regular Maintenance Tasks**:

1. **Monitor Dataset Growth**: Weekly review of dataset sizes
2. **Review Job Costs**: Monthly review of BigQuery job costs
3. **Schema Drift Review**: Quarterly review of Fivetran schema changes
4. **Partition Cleanup**: As needed, delete old partitions

**Terraform State Maintenance**:

1. **State Refresh**: Periodically run `terraform refresh` to sync state with GCP
2. **State Validation**: Run `terraform plan` to detect drift
3. **Import New Resources**: Import any manually created resources

### Troubleshooting

This section provides comprehensive troubleshooting guidance for common issues, diagnostic procedures, and escalation paths.

#### Error Code Reference

| Error Code | Description | Severity | Section |
|------------|-------------|----------|---------|
| **PRE-001** | Precondition failure - Dataset missing | High | [Precondition Failures](#precondition-failures) |
| **SCHEMA-001** | Schema drift detected | Medium | [Schema Drift](#schema-drift) |
| **IMPORT-001** | Resource exists but not in state | Medium | [Import Failures](#import-failures) |
| **PERM-001** | Permission denied | High | [Permission Errors](#permission-errors) |
| **DEP-001** | Circular dependency detected | Medium | [Circular Dependencies](#circular-dependencies) |
| **VALID-001** | Variable validation failed | Medium | [Validation Errors](#validation-errors) |
| **STATE-001** | State file access error | High | [State File Issues](#state-file-issues) |

#### Common Issues and Solutions

##### Precondition Failures

**Error**: `Error: Resource precondition failed: Dataset 'X' must exist before creating table 'Y'`

**Cause**: Table resource has a precondition that validates dataset existence, but the dataset is not defined in `var.datasets` or hasn't been created yet.

**Diagnostic Steps**:
1. Check if dataset is defined in `variables.tf` or `terraform.tfvars.dev`/`terraform.tfvars.prod`:
   ```bash
   grep -A 5 "dataset_key" terraform.tfvars.dev  # or terraform.tfvars.prod
   ```
2. Verify dataset key matches expected pattern:
   ```bash
   # For MySQL datasets: {prefix}_{key}
   # Example: raw_fivetran_gcloud_performance_coreapp
   ```
3. Check Terraform state for dataset:
   ```bash
   terraform state list | grep dataset
   ```

**Solution**:
1. Add missing dataset to `var.datasets` in `terraform.tfvars.dev` or `terraform.tfvars.prod`
2. Ensure dataset key matches the pattern used in table's `dataset_id`
3. Run `terraform plan` to verify dataset will be created before table
4. If dataset exists in GCP but not in Terraform, import it first:
   ```bash
   terraform import google_bigquery_dataset.datasets["coreapp"] \
     projects/quantiphi-test-470710/datasets/raw_fivetran_gcloud_performance_coreapp
   ```

**When to Escalate**: If dataset exists in GCP and Terraform state but precondition still fails, escalate to infrastructure team.

---

##### Schema Drift

**Error**: `Plan would replace table 'X' due to schema changes`

**Cause**: Fivetran has modified table schema, but lifecycle block is missing or incorrect.

**Diagnostic Steps**:
1. Check if table has lifecycle block:
   ```bash
   grep -A 10 "google_bigquery_table.*table_name" tables.tf | grep lifecycle
   ```
2. Review schema drift detection logs:
   ```bash
   # Check Cloud Build logs for detect-drift-bq step
   # Or query Cloud Logging:
   gcloud logging read "resource.type=build AND jsonPayload.message=~'schema.*drift'" \
     --limit=10 --format=json
   ```
3. Compare current schema with Terraform:
   ```bash
   # In BigQuery console, check table schema
   # Compare with schema defined in tables.tf
   ```

**Solution**:
1. Verify lifecycle block exists and includes `schema`, `time_partitioning`, and `clustering`:
   ```hcl
   lifecycle {
     ignore_changes = [schema, time_partitioning, clustering]
   }
   ```
2. If lifecycle block is missing, add it to the table resource
3. Run `terraform plan` - schema changes should no longer appear
4. Schema drift is logged but won't cause replacement

**When to Escalate**: If schema drift persists after adding lifecycle block, or if non-schema changes are being ignored incorrectly.

---

##### Import Failures

**Error**: `Error importing resource: Resource already exists`

**Cause**: Resource exists in GCP but not in Terraform state, or import command format is incorrect.

**Diagnostic Steps**:
1. Verify resource exists in GCP:
   ```bash
   # For datasets
   bq show --format=prettyjson raw_fivetran_gcloud_performance_coreapp
   
   # For tables
   bq show --format=prettyjson raw_fivetran_gcloud_performance_coreapp.chains
   ```
2. Check if resource is in Terraform state:
   ```bash
   terraform state list | grep "resource_name"
   ```
3. Verify import command format:
   ```bash
   # Correct format for datasets
   projects/{project_id}/datasets/{dataset_id}
   
   # Correct format for tables
   projects/{project_id}/datasets/{dataset_id}/tables/{table_id}
   ```

**Solution**:
1. Use correct import command format:
   ```bash
   # Import dataset
   terraform import \
     'google_bigquery_dataset.datasets["coreapp"]' \
     projects/quantiphi-test-470710/datasets/raw_fivetran_gcloud_performance_coreapp
   
   # Import table
   terraform import \
     'google_bigquery_table.gcloud_mysql_performance_coreapp_chains' \
     projects/quantiphi-test-470710/datasets/raw_fivetran_gcloud_performance_coreapp/tables/chains
   ```
2. Cloud Build automatically imports during `import-bq` step - check Cloud Build logs if import fails
3. After import, run `terraform plan` to verify state matches GCP

**When to Escalate**: If import consistently fails or resource appears corrupted in state.

---

##### Permission Errors

**Error**: `Error 403: Permission 'bigquery.tables.create' denied`

**Cause**: Service account lacks required BigQuery permissions or impersonation is not configured correctly.

**Diagnostic Steps**:
1. Verify service account has required roles:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:terraform-sa@quantiphi-test-470710.iam.gserviceaccount.com" \
     --format="table(bindings.role)"
   ```
2. Check if impersonation is configured:
   ```bash
   # In cloudbuild-plan.yaml, verify -impersonate-service-account flag
   grep -A 2 "terraform.*init" cloudbuild-plan.yaml
   ```
3. Verify Cloud Build service account can impersonate:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:cloud-build-sa@quantiphi-test-470710.iam.gserviceaccount.com" \
     --filter="bindings.role:roles/iam.serviceAccountTokenCreator"
   ```

**Solution**:
1. Grant required roles to Terraform service account:
   ```bash
   gcloud projects add-iam-policy-binding quantiphi-test-470710 \
     --member="serviceAccount:terraform-sa@quantiphi-test-470710.iam.gserviceaccount.com" \
     --role="roles/bigquery.dataEditor"
   
   gcloud projects add-iam-policy-binding quantiphi-test-470710 \
     --member="serviceAccount:terraform-sa@quantiphi-test-470710.iam.gserviceaccount.com" \
     --role="roles/bigquery.admin"
   ```
2. Grant impersonation permission to Cloud Build service account:
   ```bash
   gcloud iam service-accounts add-iam-policy-binding \
     terraform-sa@quantiphi-test-470710.iam.gserviceaccount.com \
     --member="serviceAccount:cloud-build-sa@quantiphi-test-470710.iam.gserviceaccount.com" \
     --role="roles/iam.serviceAccountTokenCreator"
   ```

**When to Escalate**: If permissions are correct but errors persist, or if new permissions are needed.

---

##### Circular Dependencies

**Error**: `Error: Cycle: table_a -> table_b -> table_a`

**Cause**: Tables have circular foreign key references that create dependency cycles.

**Diagnostic Steps**:
1. Identify circular dependencies:
   ```bash
   terraform graph | grep -A 5 "table_a"
   ```
2. Review foreign key definitions in `tables.tf`:
   ```bash
   grep -B 5 -A 10 "foreign_keys" tables.tf | grep -A 10 "table_name"
   ```

**Solution**:
1. Remove self-referencing foreign keys if not needed
2. Use `depends_on` to control creation order:
   ```hcl
   resource "google_bigquery_table" "table_b" {
     depends_on = [google_bigquery_table.table_a]
     # ...
   }
   ```
3. Consider removing foreign key constraints (BigQuery doesn't enforce them anyway)

**When to Escalate**: If circular dependencies are required by business logic and cannot be resolved.

---

##### Validation Errors

**Error**: `Error: Invalid value for variable: project_id must be a valid GCP project ID`

**Cause**: Variable validation failed - value doesn't match expected format or constraints.

**Diagnostic Steps**:
1. Check variable value in `terraform.tfvars.dev` or `terraform.tfvars.prod`:
   ```bash
   grep "^project_id" terraform.tfvars.dev  # or terraform.tfvars.prod
   ```
2. Review validation rules in `variables.tf`:
   ```bash
   grep -A 5 "validation" variables.tf | grep -A 3 "project_id"
   ```

**Solution**:
1. Fix variable value to match validation rules:
   - Project ID: 6-30 characters, lowercase, alphanumeric, hyphens
   - Region: Must be in whitelist of valid GCP regions
   - Dataset prefix: 1-100 chars, lowercase/underscore start
2. Run `terraform validate` to check all variables
3. Review error message for specific validation failure

**When to Escalate**: If validation rules are too restrictive or incorrect.

---

##### State File Issues

**Error**: `Error loading state: error impersonating service account`

**Cause**: Backend state access failed - Cloud Build service account cannot access state bucket or impersonation failed.

**Diagnostic Steps**:
1. Verify state bucket exists and is accessible:
   ```bash
   gsutil ls gs://terraform-state-bucket/
   ```
2. Check Cloud Build service account has state bucket access:
   ```bash
   gsutil iam get gs://terraform-state-bucket/ | \
     grep cloud-build-sa@quantiphi-test-470710.iam.gserviceaccount.com
   ```
3. Verify backend configuration in `cloudbuild-plan.yaml`:
   ```bash
   grep -A 10 "terraform.*init" cloudbuild-plan.yaml | grep backend
   ```

**Solution**:
1. Grant Cloud Build service account access to state bucket:
   ```bash
   gsutil iam ch \
     serviceAccount:cloud-build-sa@quantiphi-test-470710.iam.gserviceaccount.com:roles/storage.objectAdmin \
     gs://terraform-state-bucket/
   ```
2. Verify backend configuration uses correct bucket and prefix
3. Backend operations should NOT use impersonation (only apply operations do)

**When to Escalate**: If state bucket is corrupted or access cannot be restored.

---

#### Step-by-Step Diagnostic Procedures

##### Procedure 1: Diagnose Failed Terraform Apply

1. **Check Cloud Build Logs**:
   ```bash
   gcloud builds list --limit=5
   gcloud builds log <BUILD_ID> --stream
   ```

2. **Identify Failed Step**:
   - Look for step name (e.g., `apply-bq`, `plan-bq`)
   - Note error message and exit code

3. **Review Terraform Plan Output**:
   - Check if plan file was created: `gs://terraform-state-bucket/build-artifacts/<BUILD_ID>/tfplan-bq`
   - Review plan for unexpected changes

4. **Check Resource State**:
   ```bash
   terraform state list
   terraform state show <resource_address>
   ```

5. **Verify GCP Resources**:
   - Check BigQuery console for resource existence
   - Compare with Terraform state

6. **Review Schema Drift Logs** (if applicable):
   ```bash
   gcloud logging read \
     "resource.type=build AND jsonPayload.message=~'schema.*drift'" \
     --limit=10 --format=json
   ```

##### Procedure 2: Diagnose Precondition Failures

1. **Identify Failed Precondition**:
   - Error message indicates which precondition failed
   - Note dataset and table names

2. **Check Dataset Definition**:
   ```bash
   grep -A 10 "coreapp" terraform.tfvars.dev  # or terraform.tfvars.prod
   ```

3. **Verify Dataset Key Pattern**:
   - MySQL: `{prefix}_{key}` (e.g., `raw_fivetran_gcloud_performance_coreapp`)
   - Salesforce: `{prefix}` only (e.g., `raw_fivetran_salesforce`)
   - Workday HCM: `{prefix}` or `{prefix}_{suffix}`

4. **Check Terraform State**:
   ```bash
   terraform state list | grep dataset
   terraform state show 'google_bigquery_dataset.datasets["coreapp"]'
   ```

5. **Verify in GCP**:
   ```bash
   bq show --format=prettyjson raw_fivetran_gcloud_performance_coreapp
   ```

##### Procedure 3: Diagnose Import Issues

1. **Verify Resource Exists in GCP**:
   ```bash
   # For datasets
   bq ls -d --format=prettyjson | jq '.[] | select(.datasetReference.datasetId == "dataset_name")'
   
   # For tables
   bq show --format=prettyjson project:dataset.table
   ```

2. **Check Terraform State**:
   ```bash
   terraform state list | grep resource_name
   ```

3. **Verify Import Command Format**:
   - Datasets: `projects/{project_id}/datasets/{dataset_id}`
   - Tables: `projects/{project_id}/datasets/{dataset_id}/tables/{table_id}`

4. **Test Import Locally**:
   ```bash
   terraform import 'resource.address' 'projects/.../datasets/...'
   ```

5. **Review Import Logs in Cloud Build**:
   - Check `import-bq` step output
   - Look for import errors or warnings

---

#### Runbooks

##### Runbook 1: Recover from Failed Apply

**Scenario**: Terraform apply failed partway through, leaving some resources created and others not.

**Steps**:
1. **Assess Current State**:
   ```bash
   terraform state list
   terraform plan -out=tfplan-recovery
   ```

2. **Review Plan for Partial Changes**:
   - Identify resources that were created
   - Identify resources that failed to create

3. **Import Created Resources** (if not in state):
   ```bash
   terraform import 'resource.address' 'projects/.../datasets/...'
   ```

4. **Fix Root Cause**:
   - Address the error that caused failure (permissions, validation, etc.)
   - See relevant troubleshooting section above

5. **Re-run Apply**:
   ```bash
   terraform apply tfplan-recovery
   ```

6. **Verify All Resources**:
   ```bash
   terraform state list
   terraform plan  # Should show no changes
   ```

##### Runbook 2: Handle Schema Drift from Fivetran

**Scenario**: Fivetran modified table schema, causing Terraform to want to replace table.

**Steps**:
1. **Verify Lifecycle Block Exists**:
   ```bash
   grep -A 5 "lifecycle" tables.tf | grep -A 3 "ignore_changes"
   ```

2. **Check Schema Drift Detection Logs**:
   ```bash
   gcloud logging read \
     "resource.type=build AND jsonPayload.message=~'schema.*drift'" \
     --limit=10 --format=json
   ```

3. **Add Lifecycle Block** (if missing):
   ```hcl
   lifecycle {
     ignore_changes = [schema, time_partitioning, clustering]
   }
   ```

4. **Verify Plan Shows No Replacement**:
   ```bash
   terraform plan | grep -i "replace"
   # Should show no replacements for schema changes
   ```

5. **Update Schema Version Label** (if significant change):
   - Update `schema_version` in `main.tf` local.labels
   - Update `schema_version_date` to current date

##### Runbook 3: Fix Circular Dependencies

**Scenario**: Terraform detects circular dependency between tables.

**Steps**:
1. **Identify Dependency Cycle**:
   ```bash
   terraform graph | grep -B 5 -A 5 "table_a"
   ```

2. **Review Foreign Key Definitions**:
   ```bash
   grep -B 5 -A 10 "foreign_keys" tables.tf
   ```

3. **Remove Self-Referencing Foreign Keys** (if not needed):
   - BigQuery doesn't enforce foreign keys
   - Remove from Terraform definition

4. **Add Explicit Dependencies** (if needed):
   ```hcl
   resource "google_bigquery_table" "table_b" {
     depends_on = [google_bigquery_table.table_a]
   }
   ```

5. **Verify No Cycles**:
   ```bash
   terraform validate
   terraform plan
   ```

##### Runbook 4: Restore from State Backup

**Scenario**: Terraform state file is corrupted or lost.

**Steps**:
1. **Check for State Backups**:
   ```bash
   gsutil ls gs://terraform-state-bucket/backups/
   ```

2. **Restore Latest Backup**:
   ```bash
   gsutil cp gs://terraform-state-bucket/backups/terraform.tfstate.backup \
     terraform.tfstate
   ```

3. **Verify State Integrity**:
   ```bash
   terraform state list
   terraform validate
   ```

4. **Refresh State from GCP**:
   ```bash
   terraform refresh
   ```

5. **Compare with GCP Resources**:
   ```bash
   terraform plan  # Should show minimal or no changes
   ```

---

#### When to Escalate

Escalate to the infrastructure team or project owner when:

1. **State File Corruption**: State file is corrupted and cannot be restored from backup
2. **Persistent Permission Errors**: Permissions are correct but errors persist after verification
3. **Resource Corruption**: Resources exist in GCP but appear corrupted or inaccessible
4. **Backend Access Issues**: Cannot access Terraform state backend despite correct permissions
5. **Provider Bugs**: Suspected Terraform provider bugs (check GitHub issues first)
6. **Business Logic Conflicts**: Circular dependencies or constraints required by business logic
7. **Data Loss Risk**: Any operation that might cause data loss requires approval
8. **Production Outage**: Issues affecting production data pipelines or critical infrastructure

**Escalation Contacts**:
- Infrastructure Team: [Contact Information]
- Project Owner: [Contact Information]
- On-Call Engineer: [Contact Information]

**Information to Provide When Escalating**:
- Error message and error code
- Terraform version and provider versions
- Cloud Build build ID (if applicable)
- Steps already attempted
- Relevant log excerpts
- Terraform plan output (if available)

## Authentication

Terraform uses Application Default Credentials. Set up authentication using one of:

```bash
# Option 1: Service Account Key
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/key.json"

# Option 2: User Credentials
gcloud auth application-default login
```

## Destroying Resources

To destroy all resources (use with caution):

```bash
terraform destroy
```

Note: This will delete datasets and all their contents.


