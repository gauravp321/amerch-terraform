# POS Ingestion

This directory contains the infrastructure and code for the Point of Sale (POS) file ingestion pipeline.

## Infrastructure as Code (Terraform)

The Terraform configuration in `terraform/` provisions the GCP infrastructure required for the POS file ingestion pipeline in the non-production environment.

### CI/CD Deployment (Cloud Build)

Infrastructure is deployed via Cloud Build triggered by Bitbucket branch merges:

- **Repository:** `dashmanagement/bq_dataflow` (Bitbucket)
- **CI/CD Project:** `cicd-shared-414116`
- **State Bucket:** `amerch-terraform-state` (in CI/CD project)
- **State Prefix:** `bq_dataflow/{environment}/pos_ingestion` (e.g., `bq_dataflow/dev/pos_ingestion`, `bq_dataflow/prod/pos_ingestion`)
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

**Manual Deployment:** See [Manual Deployment](#manual-deployment) section below for local deployment instructions.

**Note:** Cloud Build triggers and service accounts are configured by the project owner.

### Prerequisites

#### For CI/CD Deployment (Cloud Build)

1. **Terraform Service Account**: Project-specific service accounts are created by the project owner in the CI/CD project (`cicd-shared-414116`)
   - Service accounts have infrastructure permissions for their respective projects
   - Configured at the Cloud Build trigger level

2. **Cloud Build Trigger**: Triggers are configured by the project owner in Cloud Build
   - Triggers require manual approval before apply step
   - State is stored in `amerch-terraform-state` bucket with prefix `bq_dataflow/{environment}`

3. **Runtime Service Account**: The service account `cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com` must have:
   - `roles/storage.objectUser` - Read/write objects in bucket
   - `roles/run.invoker` - Trigger Cloud Functions
   - `roles/secretmanager.secretAccessor` - Access secrets (if using Secret Manager)

4. **Terraform Service Account Permissions**: The Terraform service account (`terraform-demo@quantiphi-test-470710.iam.gserviceaccount.com`) must have:
   - `roles/iam.serviceAccountUser` on the Cloud Function runtime service account (`cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com`)
   - `roles/iam.serviceAccountUser` on the Compute Engine default service account (`{PROJECT_NUMBER}-compute@developer.gserviceaccount.com`)
     - **Note**: Cloud Functions 2nd gen may temporarily use the default Compute Engine service account during creation
     - Grant this permission to allow Terraform to create the Cloud Function

#### For Manual Deployment (Local)

1. **GCP Authentication**: Ensure you have authenticated with GCP:
   ```bash
   gcloud auth application-default login
   ```

2. **Terraform**: Install Terraform (>= 1.0)
   
   **macOS (using Homebrew)**:
   ```bash
   brew install terraform
   ```
   
   **Verify installation**:
   ```bash
   terraform version
   ```
   
   For other platforms, see: https://developer.hashicorp.com/terraform/downloads

3. **Required Permissions** (for manual deployment):
   - `roles/storage.admin` - For bucket operations
   - `roles/cloudfunctions.admin` - For Cloud Function deployment
   - `roles/iam.serviceAccountUser` - On runtime service account

4. **Terraform Backend**: Ensure the GCS bucket exists for storing Terraform state (configured in `terraform/backend.tf`)

### Local Validation

Before deploying, validate the Terraform configuration:

```bash
cd pos_ingestion/terraform

# Format check
terraform fmt -check

# Initialize (without backend for quick validation)
terraform init -backend=false

# Validate syntax
terraform validate

# Generate plan (requires GCP auth)
terraform plan -var-file=terraform.tfvars.example
```

**What to verify in the plan output**:
- ✅ GCS bucket `eventarc-gp74` will be created in `us-central1`
- ✅ Bucket has Autoclass enabled (automatically optimizes storage costs)
- ✅ Lifecycle rule: delete after 2555 days (7 years)
- ✅ Cloud Function `gcf_pos_file` will be created
- ✅ Function trigger matches `*_config.json` pattern
- ✅ Service account is correctly configured

### Manual Deployment

For local/manual deployment (alternative to CI/CD):

1. **Navigate to Terraform directory**:
   ```bash
   cd pos_ingestion/terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review the execution plan**:
   ```bash
   terraform plan -var-file=terraform.tfvars.dev
   ```

4. **Apply the configuration** (after reviewing the plan):
   ```bash
   terraform apply -var-file=terraform.tfvars.dev
   ```

5. **Verify deployment**: After successful deployment, verify:
   - GCS bucket exists in `us-central1`
   - Cloud Function is deployed and active
   - Function trigger is configured for `*_config.json` files

**Note:** For automated deployment, use Cloud Build CI/CD (see CI/CD Deployment section above).

### Provider Version Management

#### Current Provider Versions

The Terraform providers are pinned to exact versions for reproducibility and stability:

- **Google Provider**: `5.0.0` (pinned)
- **Random Provider**: `~> 3.5.0`
- **Archive Provider**: `~> 2.4.0`

Provider versions are specified in `terraform/main.tf` and locked in `terraform/.terraform.lock.hcl`.

#### Upgrading Provider Versions

**Important**: Provider upgrades should be tested thoroughly before deploying to production.

**Upgrade Process**:

1. **Review Release Notes**: Check provider changelogs for breaking changes:
   - [Google Provider](https://github.com/hashicorp/terraform-provider-google/blob/main/CHANGELOG.md)
   - [Random Provider](https://github.com/hashicorp/terraform-provider-random/blob/main/CHANGELOG.md)
   - [Archive Provider](https://github.com/hashicorp/terraform-provider-archive/blob/main/CHANGELOG.md)

2. **Update Version in Code**:
   ```hcl
   # In terraform/main.tf
   required_providers {
     google = {
       source  = "hashicorp/google"
       version = "5.X.X"  # Update to target version
     }
   }
   ```

3. **Test Locally**:
   ```bash
   cd pos_ingestion/terraform
   
   # Update lock file
   terraform init -upgrade
   
   # Validate configuration
   terraform validate
   
   # Review plan for unexpected changes
   terraform plan -var-file=terraform.tfvars.dev
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

### Configuration

- **Project ID**: `quantiphi-test-470710`
- **Region**: `us-central1`
- **GCS Bucket**: `eventarc-gp74` (Autoclass enabled for cost optimization)
- **Lifecycle Policy**: Objects deleted after 7 years (2555 days)
- **Cloud Function**: `gcf_pos_file`
- **Trigger**: `storage.objects.create` event for files matching `*_config.json` pattern

### Resource Validation and Preconditions

All infrastructure resources include preconditions to validate dependencies before creation. This improves error messages and prevents common deployment errors.

**Cloud Function Preconditions:**
- Verifies service account email is set (required for execution)
- Verifies function source bucket exists before function creation

**Eventarc Trigger Preconditions:**
- Verifies POS files bucket exists
- Verifies Cloud Function exists
- Verifies service account email is set

**Function Source Bucket Object Preconditions:**
- Verifies function source bucket exists
- Verifies function source archive exists

**Benefits:**
- **Early Error Detection**: Catches missing dependencies during `terraform plan` instead of during `terraform apply`
- **Clear Error Messages**: Provides specific information about which dependency is missing
- **Prevents Partial Deployments**: Ensures all dependencies are in place before creating resources

**Common Errors:**
If you see a precondition failure, it typically means:
- A required resource hasn't been created yet (check resource dependencies)
- A required variable is not set (e.g., `service_account_email`)
- A data source or resource reference is incorrect

**Troubleshooting:**
1. Verify all required variables are set in `terraform.tfvars`
2. Check that resources are created in the correct order (Terraform handles this automatically via dependencies)
3. Review error messages for specific missing dependencies

### Customization

**For CI/CD (Cloud Build):**
- Environment-specific variables are in `terraform/terraform.tfvars.dev` (development) or `terraform/terraform.tfvars.prod` (production)
- Variables are version-controlled (non-sensitive values only)
- Cloud Build uses the appropriate file based on trigger configuration

**For Manual Deployment:**
- Copy `terraform.tfvars.example` to `terraform.tfvars` and modify as needed:
  ```bash
  cp terraform/terraform.tfvars.example terraform/terraform.tfvars
  # Edit terraform.tfvars with your values
  ```
- **NOTE:** All variables must be explicitly set in `terraform.tfvars` - no defaults are provided to prevent environment coupling
- Required variables (no defaults):
  - `project_id`, `region`, `bucket_name`, `function_name`, `service_account_email`
  - `environment`, `cost_center`, `cloud_function_trigger`, `email_enabled`
  - `enable_bucket_versioning`, `retention_policy_locked`
- Optional variables (can be null):
  - `kms_key_name`, `function_source_bucket_name`
- Note: `terraform.tfvars` is git-ignored (use for local overrides)

**Variable Validation:**
All variables include validation to ensure values conform to GCP requirements:
- **Project ID**: Must be valid GCP project ID format (6-30 characters, lowercase letters, numbers, hyphens)
- **Region**: Must be a valid GCP region from the whitelist
- **Bucket Name**: Must be 3-63 characters, start and end with lowercase letter or number, contain only lowercase letters, numbers, dots, dashes, and underscores
- **Function Name**: Must be 1-63 characters, start with lowercase letter, contain only lowercase letters, numbers, hyphens, and underscores
- **Service Account Email**: Must be valid GCP service account email format
- **Environment**: Must be one of: dev, staging, prod, test
- **Cost Center**: Must be 1-63 characters, contain only lowercase letters, numbers, hyphens, and underscores
- **Email Enabled**: Must be empty string or one of: true, false, yes, no, 1, 0 (case-insensitive)
- **Trigger Name**: Must be 1-63 characters, start with lowercase letter, contain only lowercase letters, numbers, and hyphens

Invalid values will be caught during `terraform validate` with clear error messages.

### Cloud Function Source

The Cloud Function source code is located in `terraform/src/`. The function processes configuration files uploaded to GCS and loads CSV data into BigQuery tables.

### Outputs

After deployment, Terraform outputs include:
- Bucket name and URL
- Cloud Function name and URL
- Trigger resource path pattern

View outputs with:
```bash
terraform output
```

## Architecture

The POS ingestion pipeline follows an event-driven architecture:

```
┌─────────────────────────────────────────────────────────────┐
│                    GCS Bucket                               │
│              (amerch-pos-files-{env})                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  *_config.json files uploaded                        │   │
│  │  → Triggers storage.objects.create event             │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ Eventarc Trigger
                     │ (Eventarc matches bucket location)
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              Cloud Function (2nd Gen)                        │
│                  (gcf_pos_file)                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  1. Read and validate config file                    │   │
│  │  2. Validate referenced CSV file                     │   │
│  │  3. Initiate BigQuery load job                       │   │
│  │  4. Monitor job completion                           │   │
│  │  5. Move files to processed/ folder                  │   │
│  │  6. Send email notifications                         │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ BigQuery Load Job
                     │ (from GCS to BigQuery)
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                    BigQuery                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Target Dataset & Table                              │   │
│  │  (specified in config file)                          │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Components

- **GCS Bucket**: Landing zone for configuration and data files with Autoclass storage optimization
- **Eventarc Trigger**: Routes GCS events to Cloud Function (location-aware)
- **Cloud Function**: Serverless Python function that processes files and loads data
- **BigQuery**: Data warehouse destination for processed CSV files
- **Secret Manager**: Stores SendGrid API keys and email configuration

## Data Flow

### Step-by-Step Processing Flow

1. **File Upload**
   - User uploads `{filename}_config.json` to GCS bucket
   - Config file contains: dataset, table, file_location, email, override flag, is_header flag

2. **Event Trigger**
   - GCS `storage.objects.create` event fires
   - Eventarc routes event to Cloud Function in matching region
   - Function receives cloud event with bucket and object name

3. **Config File Processing**
   - Function downloads and parses JSON config file
   - Validates config structure (dataset, file_location, email format)
   - Extracts data file name from config filename

4. **Data File Validation**
   - Validates GCS URI format
   - Checks file exists and is accessible
   - Validates file size (max 1000 MB)
   - Performs basic CSV format validation

5. **BigQuery Load**
   - Creates BigQuery load job configuration
   - Sets write disposition (WRITE_TRUNCATE if override=True, WRITE_APPEND otherwise)
   - Configures CSV parsing (skip header if is_header=True)
   - Submits load job with timeout (540 seconds)
   - Monitors job completion

6. **File Cleanup**
   - Moves data CSV file to `processed/` folder in source bucket
   - Moves config file to `processed/` folder in landing bucket
   - Handles cleanup failures gracefully (logs warning, continues)

7. **Notification**
   - Sends success email with job details (rows loaded, job ID)
   - Sends failure email with error details on any error
   - Uses SendGrid API (configured via Secret Manager)

### Error Handling Points

- **Config Validation**: Invalid JSON, missing fields, invalid email format
- **File Access**: File not found, permission denied, bucket not accessible
- **BigQuery Errors**: Schema mismatch, quota exceeded, timeout, invalid table
- **Network Errors**: Connection failures, timeouts (retried automatically)
- **Secret Access**: Secret not found, permission denied (non-retryable)

## Error Handling

### Retry Logic

The Cloud Function implements automatic retry for transient errors:

- **Retryable Errors**: Network errors, quota errors, internal server errors (500, 503)
- **Retry Strategy**: Exponential backoff with configurable max retries and delay
- **Quota Errors**: Extended backoff (2x multiplier) to avoid rate limit issues
- **Max Retries**: Configurable via `MAX_RETRIES` environment variable (default: 1)
- **Retry Delay**: Configurable via `RETRY_DELAY` environment variable (default: 5 seconds)

### Error Types

**ConfigValidationError**: Invalid config file structure or values
- **Recovery**: Fix config file and re-upload
- **Non-retryable**: Yes

**DataLoadError**: BigQuery load job failed
- **Recovery**: Check CSV format, schema, and retry upload
- **Retryable**: Yes (for transient errors)

**FileProcessingError**: File access or processing failed
- **Recovery**: Verify file exists, check permissions, retry
- **Retryable**: Yes (for network errors)

**PermissionError**: Insufficient permissions
- **Recovery**: Grant required IAM roles to service account
- **Non-retryable**: Yes

**QuotaExceededError**: BigQuery quota limits exceeded
- **Recovery**: Wait and retry (automatic with extended backoff)
- **Retryable**: Yes

**InvalidCSVFormatError**: CSV format validation failed
- **Recovery**: Fix CSV format and re-upload
- **Non-retryable**: Yes

### Failure Modes

1. **Partial Success**: Data loaded but file cleanup failed
   - Function sends warning email
   - Data is available in BigQuery
   - Manual cleanup may be required

2. **Complete Failure**: Load job failed
   - Function sends error email with details
   - Files remain in original location
   - Can be retried after fixing issues

3. **Timeout**: BigQuery job exceeded timeout (540 seconds)
   - Job is cancelled automatically
   - Function sends error email
   - Consider splitting large files or increasing timeout

## Monitoring & Alerting

### Cloud Monitoring Metrics

The Cloud Function automatically emits metrics to Cloud Monitoring:

- **Function Invocations**: Count of function executions
- **Function Execution Time**: Duration of function execution
- **Function Errors**: Count of failed executions
- **BigQuery Job Duration**: Time taken for BigQuery load jobs
- **File Processing Time**: Time to process and validate files

### Key Metrics to Monitor

1. **Error Rate**: `cloudfunctions.googleapis.com/function/execution_count` with `status="error"`
2. **Latency**: `cloudfunctions.googleapis.com/function/execution_times`
3. **BigQuery Job Failures**: Custom metric for failed load jobs
4. **File Processing Failures**: Custom metric for file validation failures

### Alerting Recommendations

Create alerting policies for:

- **High Error Rate**: > 5% error rate over 5 minutes
- **Function Timeout**: Execution time > 500 seconds
- **BigQuery Job Failures**: Any job failure (immediate alert)
- **Quota Exceeded**: QuotaExceededError exceptions

### Logging

Function logs are available in Cloud Logging:

- **Log Level**: INFO (default), ERROR for failures
- **Log Filter**: `resource.type="cloud_function" AND resource.labels.function_name="gcf_pos_file"`
- **Key Log Events**:
  - Config file processing start/completion
  - File validation results
  - BigQuery job submission and completion
  - Error details with stack traces
  - Email notification status

## Troubleshooting

This section provides comprehensive troubleshooting guidance for common issues, diagnostic procedures, and escalation paths.

### Error Code Reference

| Error Code | Description | Severity | Section |
|------------|-------------|----------|---------|
| **CFG-001** | Config file not found | High | [Config File Errors](#config-file-errors) |
| **DATASET-001** | Dataset does not exist | High | [Dataset Errors](#dataset-errors) |
| **PERM-001** | Permission denied | High | [Permission Errors](#permission-errors) |
| **TIMEOUT-001** | BigQuery job timeout | Medium | [Timeout Errors](#timeout-errors) |
| **SCHEMA-001** | Schema mismatch | Medium | [Schema Errors](#schema-errors) |
| **QUOTA-001** | Quota exceeded | Medium | [Quota Errors](#quota-errors) |
| **GCS-001** | GCS file access error | Medium | [GCS Errors](#gcs-errors) |
| **EMAIL-001** | Email notification failed | Low | [Email Errors](#email-errors) |

### Common Errors and Solutions

#### Config File Errors

**Error Code: CFG-001**  
**Error**: `Config file not found at path: gs://bucket/path/to/config.json`

**Cause**: Config file doesn't exist at specified path, file was deleted, or path is incorrect.

**Diagnostic Steps**:
1. Verify file exists in GCS bucket:
   ```bash
   gsutil ls gs://eventarc-gp74/path/to/*_config.json
   ```
2. Check file naming pattern (must end with `_config.json`):
   ```bash
   gsutil ls gs://eventarc-gp74/**/*_config.json
   ```
3. Verify bucket permissions:
   ```bash
   gsutil iam get gs://eventarc-gp74/ | \
     grep cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```
4. Check Cloud Function logs for file path:
   ```bash
   gcloud logging read \
     "resource.type=cloud_function AND resource.labels.function_name=gcf_pos_file" \
     --limit=20 --format=json | jq '.[] | select(.jsonPayload.message | contains("config"))'
   ```

**Solution**:
1. Verify config file was uploaded successfully
2. Check file path matches exactly (case-sensitive)
3. Ensure file name ends with `_config.json`
4. Grant service account `roles/storage.objectViewer` on bucket if missing
5. Re-upload config file if it was deleted

**When to Escalate**: If file exists but function cannot access it despite correct permissions.

---

#### Dataset Errors

**Error Code: DATASET-001**  
**Error**: `Dataset raw_fivetran_salesforce does not exist`

**Cause**: Target dataset doesn't exist in BigQuery or dataset ID is incorrect.

**Diagnostic Steps**:
1. Verify dataset exists in BigQuery:
   ```bash
   bq ls -d --format=prettyjson | jq '.[] | select(.datasetReference.datasetId == "raw_fivetran_salesforce")'
   ```
2. Check dataset ID spelling and format:
   ```bash
   # Dataset IDs are case-sensitive
   bq show --format=prettyjson raw_fivetran_salesforce
   ```
3. Verify project ID is correct:
   ```bash
   bq show --format=prettyjson quantiphi-test-470710:raw_fivetran_salesforce
   ```

**Solution**:
1. Create dataset via Terraform:
   ```bash
   cd bq_objects/terraform
   terraform plan -var-file=terraform.tfvars.dev
   terraform apply -var-file=terraform.tfvars.dev
   ```
2. Or create manually in BigQuery console
3. Verify dataset ID in config file matches exactly
4. Check project ID matches current project

**When to Escalate**: If dataset should exist but doesn't, or if dataset creation fails.

---

#### Permission Errors

**Error Code: PERM-001**  
**Error**: `Permission denied for BigQuery operation: bigquery.tables.get`

**Cause**: Service account lacks required BigQuery permissions.

**Diagnostic Steps**:
1. Verify service account has required roles:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com" \
     --format="table(bindings.role)"
   ```
2. Check specific permissions needed:
   - `roles/bigquery.dataEditor` - Load data to tables
   - `roles/bigquery.jobUser` - Create and manage jobs
   - `roles/storage.objectViewer` - Read GCS objects
3. Verify service account email is correct:
   ```bash
   gcloud iam service-accounts describe \
     cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```

**Solution**:
1. Grant required roles to service account:
   ```bash
   gcloud projects add-iam-policy-binding quantiphi-test-470710 \
     --member="serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com" \
     --role="roles/bigquery.dataEditor"
   
   gcloud projects add-iam-policy-binding quantiphi-test-470710 \
     --member="serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com" \
     --role="roles/bigquery.jobUser"
   ```
2. Wait 1-2 minutes for IAM changes to propagate
3. Retry the operation

**When to Escalate**: If permissions are correct but errors persist, or if new permissions are needed.

---

#### Timeout Errors

**Error Code: TIMEOUT-001**  
**Error**: `BigQuery load job exceeded timeout of 540 seconds`

**Cause**: File is too large, BigQuery job is slow, or network issues.

**Diagnostic Steps**:
1. Check file size:
   ```bash
   gsutil du -h gs://eventarc-gp74/path/to/file.csv
   ```
2. Review BigQuery job details:
   ```sql
   SELECT 
     job_id,
     creation_time,
     total_bytes_processed / POW(10, 9) as gb_processed,
     total_slot_ms / 1000 / 60 as slot_minutes,
     state,
     error_result
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE job_id = '<job_id>'
   ORDER BY creation_time DESC
   LIMIT 1
   ```
3. Check for concurrent jobs:
   ```sql
   SELECT COUNT(*) as concurrent_jobs
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
     AND state = 'RUNNING'
   ```

**Solution**:
1. Split large files into smaller chunks (< 1GB recommended)
2. Increase timeout (max 540 seconds, configured in function code)
3. Check BigQuery slot availability and quotas
4. Retry during off-peak hours
5. Consider using BigQuery load job with different settings (e.g., allow_jagged_rows)

**When to Escalate**: If files consistently timeout despite being small, or if BigQuery performance is degraded.

---

#### Schema Errors

**Error Code: SCHEMA-001**  
**Error**: `Schema mismatch: Expected column 'X' but found 'Y'`

**Cause**: CSV columns don't match expected schema, delimiter is incorrect, or encoding issues.

**Diagnostic Steps**:
1. Verify CSV format:
   ```bash
   # Check first few lines
   gsutil cat gs://eventarc-gp74/path/to/file.csv | head -5
   ```
2. Check delimiter (should be comma):
   ```bash
   gsutil cat gs://eventarc-gp74/path/to/file.csv | head -1 | tr ',' '\n' | nl
   ```
3. Verify column names match config:
   ```json
   {
     "dataset": "raw_fivetran_salesforce",
     "tablename": "test_table",
     "file_location": "gs://bucket/file.csv",
     "is_header": true  // Must match actual CSV header
   }
   ```
4. Check encoding (should be UTF-8):
   ```bash
   file -bi gs://eventarc-gp74/path/to/file.csv
   ```

**Solution**:
1. Verify CSV delimiter is comma (not semicolon or tab)
2. Ensure `is_header` matches actual CSV (true if header row exists)
3. Check column names match exactly (case-sensitive)
4. Verify encoding is UTF-8
5. Remove special characters or BOM from CSV if present
6. Test with small sample file first

**When to Escalate**: If CSV format is correct but schema errors persist, or if schema definition needs updating.

---

#### Quota Errors

**Error Code: QUOTA-001**  
**Error**: `Quota exceeded: Your project exceeded quota for concurrent queries`

**Cause**: BigQuery quota limits reached (concurrent queries, daily query bytes, etc.).

**Diagnostic Steps**:
1. Check current quota usage:
   ```bash
   gcloud compute project-info describe --project=quantiphi-test-470710 \
     --format="get(quotas[].limit,quotas[].usage)"
   ```
2. Review recent BigQuery jobs:
   ```sql
   SELECT 
     COUNT(*) as job_count,
     SUM(total_bytes_processed) / POW(10, 12) as tb_processed
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
   ```
3. Check for stuck or long-running jobs:
   ```sql
   SELECT job_id, creation_time, state, total_slot_ms / 1000 / 60 as slot_minutes
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE state = 'RUNNING'
     AND creation_time < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
   ```

**Solution**:
1. Wait and retry (automatic retry with exponential backoff is implemented)
2. Cancel stuck jobs:
   ```bash
   bq cancel <job_id>
   ```
3. Request quota increase if consistently hitting limits:
   - Go to GCP Console → IAM & Admin → Quotas
   - Request increase for specific quota
4. Optimize queries to reduce bytes processed
5. Schedule large jobs during off-peak hours

**When to Escalate**: If quota limits are consistently exceeded and increase is needed.

---

#### GCS Errors

**Error Code: GCS-001**  
**Error**: `Access denied: gs://bucket/path/to/file.csv`

**Cause**: Service account cannot access GCS bucket or object.

**Diagnostic Steps**:
1. Verify bucket exists:
   ```bash
   gsutil ls gs://eventarc-gp74/
   ```
2. Check service account has bucket access:
   ```bash
   gsutil iam get gs://eventarc-gp74/ | \
     grep cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```
3. Test file access directly:
   ```bash
   gsutil cat gs://eventarc-gp74/path/to/file.csv | head -1
   ```
4. Verify object exists:
   ```bash
   gsutil ls -l gs://eventarc-gp74/path/to/file.csv
   ```

**Solution**:
1. Grant service account `roles/storage.objectViewer` on bucket:
   ```bash
   gsutil iam ch \
     serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com:roles/storage.objectViewer \
     gs://eventarc-gp74/
   ```
2. Verify file path is correct (case-sensitive)
3. Check file wasn't deleted or moved
4. Ensure bucket lifecycle policies haven't deleted the file

**When to Escalate**: If permissions are correct but access still fails.

---

#### Email Errors

**Error Code: EMAIL-001**  
**Error**: `Failed to send email notification: 401 Unauthorized`

**Cause**: SendGrid API key is invalid, missing, or email service is disabled.

**Diagnostic Steps**:
1. Check if email is enabled in config:
   ```json
   {
     "email": "user@example.com",  // Must be present
     "email_enabled": "true"  // In Terraform variables
   }
   ```
2. Verify SendGrid secret exists:
   ```bash
   gcloud secrets versions access latest --secret=sendgrid-api-key
   ```
3. Check service account can access secret:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com" \
     --filter="bindings.role:roles/secretmanager.secretAccessor"
   ```

**Solution**:
1. Verify SendGrid API key is valid and active
2. Grant service account `roles/secretmanager.secretAccessor` if missing
3. Check email address format is valid
4. Email failures are logged but don't fail the function - check logs for details

**When to Escalate**: If email notifications are critical and consistently failing.

---

### Step-by-Step Diagnostic Procedures

#### Procedure 1: Diagnose Failed File Processing

1. **Check Cloud Function Logs**:
   ```bash
   gcloud logging read \
     "resource.type=cloud_function AND resource.labels.function_name=gcf_pos_file" \
     --limit=50 --format=json | jq '.[] | {timestamp, severity, message: .jsonPayload.message}'
   ```

2. **Identify Error Type**:
   - Look for error codes (CFG-001, DATASET-001, etc.)
   - Note timestamp and severity level

3. **Check Config File**:
   ```bash
   gsutil cat gs://eventarc-gp74/path/to/*_config.json | jq .
   ```

4. **Verify File Exists**:
   ```bash
   gsutil ls -l gs://eventarc-gp74/path/to/file.csv
   ```

5. **Check BigQuery Job Status** (if job was created):
   ```sql
   SELECT job_id, creation_time, state, error_result
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
   ORDER BY creation_time DESC
   LIMIT 10
   ```

6. **Review Service Account Permissions**:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com"
   ```

#### Procedure 2: Diagnose BigQuery Load Job Failures

1. **Identify Job ID from Logs**:
   ```bash
   gcloud logging read \
     "resource.type=cloud_function AND jsonPayload.message=~'job_id'" \
     --limit=10 --format=json | jq '.[] | .jsonPayload.message'
   ```

2. **Query Job Details**:
   ```sql
   SELECT 
     job_id,
     creation_time,
     state,
     error_result,
     total_bytes_processed / POW(10, 9) as gb_processed,
     total_slot_ms / 1000 / 60 as slot_minutes
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE job_id = '<job_id>'
   ```

3. **Check Job Statistics**:
   ```sql
   SELECT 
     job_id,
     creation_time,
     start_time,
     end_time,
     TIMESTAMP_DIFF(end_time, start_time, SECOND) as duration_seconds,
     total_bytes_processed,
     error_result
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE job_id = '<job_id>'
   ```

4. **Review Error Details**:
   - Check `error_result.reason` and `error_result.message`
   - Common reasons: `invalid`, `notFound`, `accessDenied`, `backendError`

5. **Verify Table Schema**:
   ```bash
   bq show --format=prettyjson quantiphi-test-470710:dataset.table
   ```

#### Procedure 3: Diagnose Permission Issues

1. **Verify Service Account Exists**:
   ```bash
   gcloud iam service-accounts describe \
     cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```

2. **Check IAM Policy Bindings**:
   ```bash
   gcloud projects get-iam-policy quantiphi-test-470710 \
     --flatten="bindings[].members" \
     --filter="bindings.members:serviceAccount:cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com" \
     --format="table(bindings.role)"
   ```

3. **Test Specific Permissions**:
   ```bash
   # Test BigQuery access
   bq query --use_legacy_sql=false "SELECT 1" \
     --service_account=cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   
   # Test GCS access
   gsutil ls gs://eventarc-gp74/ \
     --impersonate-service-account=cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```

4. **Check Secret Manager Access**:
   ```bash
   gcloud secrets versions access latest --secret=sendgrid-api-key \
     --impersonate-service-account=cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com
   ```

---

### Runbooks

#### Runbook 1: Recover from Failed File Processing

**Scenario**: Config file was processed but BigQuery load job failed.

**Steps**:
1. **Identify Failed Job**:
   ```sql
   SELECT job_id, creation_time, state, error_result
   FROM `region-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT`
   WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
     AND state = 'DONE'
     AND error_result IS NOT NULL
   ORDER BY creation_time DESC
   LIMIT 1
   ```

2. **Review Error Details**:
   - Check `error_result.reason` and `error_result.message`
   - Determine if retry is possible or fix is needed

3. **Fix Root Cause**:
   - Schema mismatch: Fix CSV format or update table schema
   - Permission error: Grant required permissions
   - Quota exceeded: Wait and retry, or request quota increase

4. **Re-process File**:
   - Re-upload config file to trigger function again
   - Or manually trigger function:
     ```bash
     gcloud functions call gcf_pos_file \
       --region=us-central1 \
       --data='{"bucket":"eventarc-gp74","name":"path/to/config.json"}'
     ```

5. **Verify Success**:
   ```sql
   SELECT COUNT(*) as row_count
   FROM `quantiphi-test-470710.dataset.table`
   WHERE _PARTITIONTIME >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
   ```

#### Runbook 2: Handle Large File Timeout

**Scenario**: File processing times out due to large file size.

**Steps**:
1. **Check File Size**:
   ```bash
   gsutil du -h gs://eventarc-gp74/path/to/file.csv
   ```

2. **Split File** (if > 1GB):
   ```bash
   # Split into 500MB chunks
   gsutil -m cp gs://bucket/large-file.csv - | \
     split -l 1000000 - chunk_
   
   # Upload chunks
   for chunk in chunk_*; do
     gsutil cp $chunk gs://bucket/chunks/$chunk.csv
   done
   ```

3. **Create Config Files for Each Chunk**:
   ```json
   {
     "dataset": "raw_fivetran_salesforce",
     "tablename": "table_name",
     "file_location": "gs://bucket/chunks/chunk_aa.csv",
     "email": "user@example.com",
     "override": false,
     "is_header": false  // Only first chunk has header
   }
   ```

4. **Process Chunks Sequentially**:
   - Upload config files one at a time
   - Wait for each to complete before next

5. **Verify All Data Loaded**:
   ```sql
   SELECT COUNT(*) as total_rows
   FROM `quantiphi-test-470710.dataset.table`
   ```

#### Runbook 3: Fix Schema Mismatch

**Scenario**: CSV columns don't match table schema.

**Steps**:
1. **Compare CSV Header with Table Schema**:
   ```bash
   # Get CSV header
   gsutil cat gs://bucket/file.csv | head -1
   
   # Get table schema
   bq show --format=prettyjson quantiphi-test-470710:dataset.table | \
     jq '.schema.fields[].name'
   ```

2. **Identify Mismatches**:
   - Column name differences (case-sensitive)
   - Missing columns
   - Extra columns

3. **Fix CSV** (if possible):
   - Rename columns to match schema
   - Remove extra columns
   - Add missing columns with default values

4. **Or Update Table Schema** (if CSV is correct):
   ```bash
   bq show --format=prettyjson quantiphi-test-470710:dataset.table > schema.json
   # Edit schema.json
   bq update quantiphi-test-470710:dataset.table schema.json
   ```

5. **Re-process File**:
   - Re-upload config file
   - Verify load succeeds

#### Runbook 4: Restore from Backup

**Scenario**: Data was accidentally overwritten or deleted.

**Steps**:
1. **Check Table History** (if time travel enabled):
   ```sql
   SELECT *
   FROM `quantiphi-test-470710.dataset.table`
   FOR SYSTEM_TIME AS OF TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
   LIMIT 10
   ```

2. **Check GCS Backup** (if configured):
   ```bash
   gsutil ls gs://backup-bucket/dataset/table/
   ```

3. **Restore from Snapshot** (if available):
   ```bash
   bq cp --snapshot <snapshot_id> \
     quantiphi-test-470710:dataset.table_backup \
     quantiphi-test-470710:dataset.table
   ```

4. **Re-process Source Files** (if available):
   - Re-upload config files from source
   - Process with `override: false` to append

5. **Verify Data Restored**:
   ```sql
   SELECT COUNT(*) as row_count, MAX(timestamp) as latest
   FROM `quantiphi-test-470710.dataset.table`
   ```

---

### When to Escalate

Escalate to the infrastructure team or project owner when:

1. **Data Loss**: Suspected or confirmed data loss
2. **Persistent Permission Errors**: Permissions are correct but errors persist
3. **Quota Limits**: Consistently hitting quota limits and increase is needed
4. **Service Outage**: Function is not processing files or BigQuery is unavailable
5. **Security Issues**: Unauthorized access or security breaches
6. **Schema Changes**: Table schema needs to be modified but requires coordination
7. **Production Impact**: Issues affecting production data pipelines
8. **Provider Bugs**: Suspected GCP service bugs (check GCP status page first)

**Escalation Contacts**:
- Infrastructure Team: [Contact Information]
- Project Owner: [Contact Information]
- On-Call Engineer: [Contact Information]

**Information to Provide When Escalating**:
- Error code and error message
- Cloud Function execution ID (from logs)
- BigQuery job ID (if applicable)
- Config file path and contents (sanitized)
- Steps already attempted
- Relevant log excerpts
- Timestamp of failure

## Security

For comprehensive security documentation, including detailed service account permissions, permission justifications, and least privilege principles, see [docs/SECURITY.md](../../docs/SECURITY.md).

### Service Account Permissions

**Runtime Service Account** (`cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com`):

Required IAM roles:
- `roles/storage.objectUser` - Read/write GCS objects (config and data files)
- `roles/bigquery.dataEditor` - Load data to BigQuery tables
- `roles/bigquery.jobUser` - Create and manage BigQuery load jobs
- `roles/secretmanager.secretAccessor` - Access SendGrid API keys from Secret Manager
- `roles/logging.logWriter` - Write function execution logs
- `roles/monitoring.metricWriter` - Emit custom metrics

**See [docs/SECURITY.md](../../docs/SECURITY.md) for detailed permission justifications, permission matrix, and least privilege documentation.**

### IAM Best Practices

- **Least Privilege**: Service account has only required permissions
- **No Public Access**: Cloud Function is not publicly accessible (triggered only by GCS events)
- **Secret Management**: API keys stored in Secret Manager, not in code or environment variables
- **Audit Logging**: All operations are logged for security auditing

### Encryption

- **At Rest**: GCS and BigQuery use default Google-managed encryption (sufficient for sales data)
- **In Transit**: All API calls use TLS encryption
- **CMEK**: Optional via `kms_key_name` variable, but not required for POS sales data. Google-managed encryption provides adequate security for business sales data.
- **Secrets**: Secret Manager encrypts secrets at rest with Google-managed keys

### Access Control

- **GCS Bucket**: Uniform bucket-level access enabled, IAM-only access control
- **BigQuery**: Dataset-level access control via IAM policies
- **Cloud Function**: Invoked only by Eventarc (no public HTTP endpoint)
- **Secret Manager**: Access restricted to service account with `secretAccessor` role

### Resource Labels

All resources include comprehensive labels for cost tracking and resource organization:

**POS Files Bucket:**
- Standard labels: `environment`, `project`, `managed_by`, `cost_center`
- Enhanced labels:
  - `data_classification = "internal"` - For security/compliance classification
  - `backup_required` - Dynamic based on `enable_bucket_versioning` variable (true if versioning enabled)
  - `retention_days = "2555"` - 7 years in days (matches retention policy)
  - `owner = "data-engineering"` - For ownership tracking

**Function Source Bucket:**
- Standard labels: `environment`, `project`, `managed_by`, `cost_center`, `purpose`
- Enhanced labels:
  - `data_classification = "internal"` - For security/compliance classification
  - `backup_required = "false"` - Function source archives are temporary and replaced on each deployment
  - `owner = "data-engineering"` - For ownership tracking

These labels enable better cost allocation, lifecycle management, compliance tracking, and backup policy enforcement.

## Performance

### Timeout Configuration

- **Cloud Function Timeout**: 600 seconds (10 minutes) - configured in Terraform
- **BigQuery Job Timeout**: 540 seconds (9 minutes) - configured in function code
- **Timeout Buffer**: 60-second buffer between function and job timeout to allow cleanup

### Concurrency

- **Cloud Function**: Default concurrency (80 concurrent executions)
- **BigQuery**: Quota limits apply (varies by project)
- **File Processing**: Sequential processing per function invocation

### Scaling Considerations

- **Automatic Scaling**: Cloud Functions scale automatically based on event volume
- **BigQuery Quotas**: Monitor quota usage for high-volume scenarios
- **File Size Limits**: Maximum file size is 1000 MB (configurable via `MAX_FILE_SIZE_MB`)

### Optimization Tips

- **Batch Processing**: For multiple files, upload config files sequentially to avoid quota issues
- **File Size**: Keep files under 500 MB for optimal processing time
- **Partitioning**: Use partitioned BigQuery tables for better query performance
- **Monitoring**: Monitor function execution times and BigQuery job durations

## Configuration Reference

### Environment Variables

The Cloud Function supports the following environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `MAX_RETRIES` | `1` | Maximum number of retry attempts for transient errors |
| `RETRY_DELAY` | `5` | Base delay in seconds for exponential backoff |
| `MAX_FILE_SIZE_MB` | `1000` | Maximum file size in MB (validation limit) |
| `TIMEOUT_SECONDS` | `540` | BigQuery job timeout in seconds (max 540) |
| `EMAIL_ENABLED` | `true` | Enable/disable email notifications |

### Config File Schema

The `*_config.json` file must contain:

```json
{
  "dataset": "string (required)",
  "tablename": "string (optional, defaults to filename)",
  "file_location": "string (required, GCS URI)",
  "email": "string (required, comma-separated for multiple)",
  "override": "boolean (optional, default: true)",
  "is_header": "boolean (optional, default: true)"
}
```

**Field Descriptions**:
- `dataset`: BigQuery dataset ID (must exist)
- `tablename`: Target table name (sanitized automatically)
- `file_location`: GCS URI (e.g., `gs://bucket-name/path/to/file.csv`)
- `email`: Recipient email address(es) for notifications
- `override`: If `true`, truncates table before loading; if `false`, appends data
- `is_header`: If `true`, skips first row as header; if `false`, treats all rows as data

### Secret Manager Secrets

The following secrets must exist in Secret Manager:

- `POS_LOAD_SENDGRID_KEY`: SendGrid API key for email notifications
- `POS_LOAD_SENDGRID_FROM`: Sender email address for notifications

**Secret Location**: Project-level secrets in `quantiphi-test-470710`
