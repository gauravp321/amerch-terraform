# Contributing Guide

## Infrastructure Testing

This repository uses automated testing to ensure Terraform configurations are valid and properly formatted.

### Pre-commit Hooks

Pre-commit hooks automatically validate code before commits. Install them once:

```bash
make install-pre-commit
```

Or manually:
```bash
# If using virtual environment
source venv/bin/activate
pip install pre-commit
pre-commit install

# Or with system Python
pip3 install pre-commit
pre-commit install
```

Hooks will run automatically on `git commit`. To run manually:
```bash
pre-commit run --all-files
```

### Local Validation

Validate Terraform configurations locally:

```bash
# Validate all Terraform directories
make validate

# Validate specific directory
make validate-bq    # BigQuery objects
make validate-pos   # POS ingestion

# Or use the script directly
./scripts/validate-terraform.sh bq_objects/terraform
```

### Formatting

Format Terraform files:

```bash
# Format all files
make fmt

# Check formatting without modifying files
make fmt-check
```

### Running All Tests

Run all validation checks:

```bash
make test
```

This runs:
- Format checking (`terraform fmt -check`)
- Configuration validation (`terraform validate`)

### CI/CD Validation

Cloud Build automatically runs validation on:
- Pull requests (plan-only mode)
- Branch merges (before apply)

Validation includes:
- Terraform formatting checks
- Terraform syntax validation
- Configuration validation

### Requirements

- Terraform >= 1.0
- Pre-commit (for local hooks)
- jq (for validation script)

### Troubleshooting

**Formatting issues:**
```bash
make fmt
```

**Validation failures:**
- Check error messages in output
- Ensure all required variables are set
- Verify Terraform version compatibility

**Pre-commit not running:**
```bash
pre-commit install --install-hooks
```

## Terraform Resource Naming Conventions

This repository follows consistent naming conventions for Terraform resources to improve readability and maintainability.

### General Principles

1. **Use descriptive names** that clearly indicate the resource's purpose
2. **Use snake_case** for all resource names (Terraform convention)
3. **Include context** when helpful (e.g., source system, dataset, purpose)
4. **Keep names concise** but informative
5. **Be consistent** within resource types

### BigQuery Resources

#### Datasets

- **Pattern**: Use generic name with `for_each` for multiple datasets
- **Example**: `google_bigquery_dataset.datasets`
- **Rationale**: Datasets are managed via a map, so a generic name with iteration is appropriate

#### Tables

- **Pattern**: `{source_system}_{dataset_suffix}_{table_name}`
- **Examples**:
  - `gcloud_mysql_performance_coreapp_chains`
  - `gcloud_mysql_performance_activity_campaignelements`
  - `salesforce_account`
  - `salesforce_contact`
  - `workday_hcm_worker`
  - `workday_hcm_location`
- **Components**:
  - `gcloud_mysql_performance`: Source system identifier (MySQL Performance via Fivetran)
  - `coreapp`, `activity`, etc.: Dataset suffix
  - `chains`, `campaignelements`, etc.: Table name
- **Rationale**: Long descriptive names help identify the source system, dataset, and table at a glance

### Cloud Storage Resources

#### Buckets

- **Pattern**: `{purpose}_{type}` or `{purpose}`
- **Examples**:
  - `pos_files`: POS file landing zone
  - `function_source`: Cloud Function source code storage
- **Rationale**: Short, purpose-based names are sufficient for buckets

#### Bucket Objects

- **Pattern**: `{parent_resource}_{purpose}`
- **Example**: `function_source`: Object in the function_source bucket
- **Rationale**: Inherits context from parent bucket name

### Cloud Functions

- **Pattern**: `{purpose}_{type}_processor` or `{purpose}_{function}`
- **Example**: `pos_file_processor`: Processes POS files
- **Rationale**: Descriptive name indicating purpose and type

### Eventarc Triggers

- **Pattern**: `{trigger_type}_{purpose}` or `{purpose}_trigger`
- **Example**: `gcs_trigger`: GCS event trigger
- **Rationale**: Short name with trigger type indicator

### Variables

- **Pattern**: `{resource_type}_{purpose}` or `{purpose}`
- **Examples**:
  - `project_id`: GCP project identifier
  - `bucket_name`: GCS bucket name
  - `function_name`: Cloud Function name
  - `gcloud_mysql_dataset_prefix`: Dataset prefix for MySQL sources
- **Rationale**: Descriptive names that indicate the variable's purpose

### Data Sources

- **Pattern**: `{resource_type}_{purpose}` or `{purpose}`
- **Examples**:
  - `google_storage_bucket.pos_files`: Reference to POS files bucket
  - `archive_file.function_source`: Function source archive
- **Rationale**: Match the resource name pattern for consistency

### Locals

- **Pattern**: Descriptive names indicating computed values
- **Examples**:
  - `labels`: Merged label set
  - `dataset_id_map`: Mapping of dataset keys to IDs
  - `dataset_ids`: Reverse mapping for for_each
- **Rationale**: Clear names that describe the computed value

### Best Practices

1. **When adding new resources**, follow the existing patterns for that resource type
2. **For BigQuery tables**, use the full pattern: `{source}_{dataset}_{table}`
3. **For infrastructure resources** (buckets, functions), use purpose-based names
4. **Avoid abbreviations** unless they're widely understood (e.g., `pos`, `gcs`)
5. **Use consistent prefixes** for related resources (e.g., `pos_*` for POS ingestion resources)

### Examples

**Good:**
```hcl
resource "google_bigquery_table" "gcloud_mysql_performance_coreapp_chains" { ... }
resource "google_storage_bucket" "pos_files" { ... }
resource "google_cloudfunctions2_function" "pos_file_processor" { ... }
```

**Avoid:**
```hcl
resource "google_bigquery_table" "t1" { ... }  # Too generic
resource "google_storage_bucket" "bucket" { ... }  # Too generic
resource "google_cloudfunctions2_function" "f" { ... }  # Too short
```

