# Security Documentation
## Least Privilege and IAM Permissions

This document outlines the security model, service account permissions, and least privilege principles for the AMerch BigQuery data pipeline infrastructure.

**Last Updated:** 2025-01-27

---

## Overview

The infrastructure follows the principle of **least privilege**, where each service account is granted only the minimum permissions required to perform its specific function. This reduces the attack surface and limits the potential impact of compromised credentials.

---

## Service Accounts

### 1. Cloud Function Runtime Service Account

**Service Account:** `cfndl-pos-files@amerchgcp-amerch-{env}.iam.gserviceaccount.com`

**Purpose:** Executes the POS file ingestion Cloud Function that processes CSV files and loads them into BigQuery.

**Required IAM Roles:**

| Role | Justification | Scope |
|------|---------------|-------|
| `roles/storage.objectUser` | Read configuration files and CSV data files from GCS bucket. Write processed files to `processed/` folder. | Bucket: `amerch-pos-files-{env}` |
| `roles/bigquery.dataEditor` | Load data into BigQuery tables specified in configuration files. | Project-level or dataset-level |
| `roles/bigquery.jobUser` | Create and manage BigQuery load jobs from GCS to BigQuery tables. | Project-level |
| `roles/secretmanager.secretAccessor` | Access SendGrid API keys from Secret Manager for email notifications. | Specific secrets only |
| `roles/logging.logWriter` | Write function execution logs to Cloud Logging for monitoring and debugging. | Project-level |
| `roles/monitoring.metricWriter` | Emit custom metrics for monitoring (e.g., file processing failures, load job status). | Project-level |

**Permission Justification:**

- **Storage Object User**: The function must read `*_config.json` files and corresponding CSV files from the GCS bucket. It also moves processed files to the `processed/` folder. This role provides read/write access to objects but not bucket management permissions.

- **BigQuery Data Editor**: Required to insert data into BigQuery tables. The function loads CSV data into tables specified in the configuration file. This role allows data insertion but not schema modification or table deletion.

- **BigQuery Job User**: Required to create and manage BigQuery load jobs. The function initiates load jobs from GCS to BigQuery and monitors their completion. This role is necessary for job creation and status checking.

- **Secret Manager Secret Accessor**: Required to retrieve SendGrid API keys for sending email notifications. The function reads secrets at runtime to authenticate with SendGrid. Only specific secrets are accessed, not all secrets in the project.

- **Logging Log Writer**: Required to write execution logs. The function logs processing steps, errors, and status information for monitoring and debugging.

- **Monitoring Metric Writer**: Required to emit custom metrics for observability. The function tracks metrics like file processing success/failure rates and load job durations.

**Least Privilege Notes:**

- ✅ Does not have bucket management permissions (cannot create/delete buckets)
- ✅ Does not have BigQuery schema modification permissions (cannot alter table schemas)
- ✅ Does not have BigQuery table deletion permissions (cannot drop tables)
- ✅ Does not have Secret Manager secret creation/deletion permissions
- ✅ Does not have project-level admin permissions

---

### 2. Terraform Service Account

**Service Account:** `sa-bq-tf-admin@amerchgcp-amerch-{env}.iam.gserviceaccount.com`

**Purpose:** Executes Terraform operations to provision and manage infrastructure resources (BigQuery datasets, tables, GCS buckets, Cloud Functions, Eventarc triggers).

**Required IAM Roles:**

| Role | Justification | Scope |
|------|---------------|-------|
| `roles/editor` (or more specific roles) | Create, update, and delete GCP resources managed by Terraform (datasets, tables, buckets, functions, triggers). | Project-level |
| `roles/iam.serviceAccountUser` | Impersonate the Cloud Function runtime service account during Cloud Function creation. Required for Cloud Functions 2nd gen. | On `cfndl-pos-files@amerchgcp-amerch-{env}.iam.gserviceaccount.com` |
| `roles/iam.serviceAccountUser` | Impersonate the Compute Engine default service account during Cloud Function creation. Cloud Functions 2nd gen may temporarily use the default service account. | On `{PROJECT_NUMBER}-compute@developer.gserviceaccount.com` |
| `roles/storage.objectAdmin` | Read/write Terraform state files in the GCS state bucket. | Bucket: `amerch-terraform-state` (in CI/CD project) |

**Permission Justification:**

- **Editor Role**: Required to create, update, and delete all infrastructure resources managed by Terraform:
  - BigQuery datasets and tables
  - GCS buckets and bucket objects
  - Cloud Functions
  - Eventarc triggers
  - Other GCP resources defined in Terraform configurations

  **Note:** While `roles/editor` is a broad role, it is necessary for Terraform to manage infrastructure. In the future, this could be replaced with more specific roles (e.g., `roles/bigquery.admin`, `roles/storage.admin`, `roles/cloudfunctions.admin`) for better least privilege, but this requires careful testing to ensure all required permissions are included.

- **Service Account User (Cloud Function Runtime)**: Required to set the service account for Cloud Functions during creation. Terraform must be able to impersonate the runtime service account to configure it on the Cloud Function resource.

- **Service Account User (Compute Engine Default)**: Cloud Functions 2nd gen may temporarily use the Compute Engine default service account during creation. Terraform needs this permission to allow the function creation process to complete successfully.

- **Storage Object Admin (State Bucket)**: Required to read and write Terraform state files. Terraform state contains sensitive information about resource configurations and must be stored securely. This permission is scoped to the specific state bucket only.

**Least Privilege Notes:**

- ⚠️ Uses `roles/editor` which is broad but necessary for Terraform infrastructure management
- ✅ Service account user permissions are scoped to specific service accounts only
- ✅ State bucket access is scoped to a single bucket
- ✅ Does not have IAM admin permissions (cannot create/delete service accounts)
- ✅ Does not have project owner permissions

**Future Improvement:** Replace `roles/editor` with specific roles:
- `roles/bigquery.admin` - For BigQuery datasets and tables
- `roles/storage.admin` - For GCS buckets and objects
- `roles/cloudfunctions.admin` - For Cloud Functions
- `roles/eventarc.admin` - For Eventarc triggers
- `roles/secretmanager.admin` - For Secret Manager (if managing secrets via Terraform)

---

### 3. Cloud Build Service Account

**Service Account:** `sa-cb-amerch-{env}@cicd-shared-414116.iam.gserviceaccount.com`

**Purpose:** Executes Cloud Build pipelines that run Terraform operations for infrastructure deployment.

**Required IAM Roles:**

| Role | Justification | Scope |
|------|---------------|-------|
| `roles/storage.objectAdmin` | Read/write Terraform state files in the GCS state bucket. Required for `terraform init` steps that access the backend. | Bucket: `amerch-terraform-state` (in CI/CD project) |
| `roles/iam.serviceAccountTokenCreator` | Create tokens for service account impersonation. Required to impersonate the Terraform service account during Terraform operations. | On `sa-bq-tf-admin@amerchgcp-amerch-{env}.iam.gserviceaccount.com` |

**Permission Justification:**

- **Storage Object Admin (State Bucket)**: Cloud Build needs to access the Terraform state bucket for `terraform init` operations. The backend configuration requires read/write access to state files.

- **Service Account Token Creator**: Required to impersonate the Terraform service account. Cloud Build uses service account impersonation to run Terraform operations as the Terraform service account, which has the necessary permissions to manage infrastructure.

**Least Privilege Notes:**

- ✅ State bucket access is scoped to a single bucket only
- ✅ Service account token creator is scoped to the Terraform service account only
- ✅ Does not have direct infrastructure management permissions (uses impersonation)
- ✅ Does not have project-level admin permissions

---

## Permission Matrix

### Summary Table

| Service Account | Primary Function | Key Permissions | Scope |
|----------------|------------------|-----------------|-------|
| `cfndl-pos-files@...` | Cloud Function runtime | Storage object user, BigQuery data editor, BigQuery job user, Secret accessor | Project-level (scoped to specific resources) |
| `sa-bq-tf-admin@...` | Terraform operations | Editor (or specific admin roles), Service account user | Project-level |
| `sa-cb-amerch-{env}@...` | Cloud Build execution | Storage object admin (state bucket), Service account token creator | CI/CD project + impersonation |

### Detailed Permission Breakdown

#### Cloud Function Runtime Service Account

```
cfndl-pos-files@amerchgcp-amerch-{env}.iam.gserviceaccount.com
├── roles/storage.objectUser
│   └── Bucket: amerch-pos-files-{env}
│       ├── Read: *_config.json files
│       ├── Read: CSV data files
│       └── Write: processed/ folder
├── roles/bigquery.dataEditor
│   └── Project: amerchgcp-amerch-{env}
│       └── Insert data into tables
├── roles/bigquery.jobUser
│   └── Project: amerchgcp-amerch-{env}
│       └── Create and manage load jobs
├── roles/secretmanager.secretAccessor
│   └── Specific secrets only
│       └── SendGrid API keys
├── roles/logging.logWriter
│   └── Project: amerchgcp-amerch-{env}
│       └── Write execution logs
└── roles/monitoring.metricWriter
    └── Project: amerchgcp-amerch-{env}
        └── Emit custom metrics
```

#### Terraform Service Account

```
sa-bq-tf-admin@amerchgcp-amerch-{env}.iam.gserviceaccount.com
├── roles/editor (or specific roles)
│   └── Project: amerchgcp-amerch-{env}
│       ├── BigQuery: Create/update/delete datasets and tables
│       ├── Storage: Create/update/delete buckets and objects
│       ├── Cloud Functions: Create/update/delete functions
│       └── Eventarc: Create/update/delete triggers
├── roles/iam.serviceAccountUser
│   ├── On: cfndl-pos-files@amerchgcp-amerch-{env}.iam.gserviceaccount.com
│   └── On: {PROJECT_NUMBER}-compute@developer.gserviceaccount.com
└── roles/storage.objectAdmin
    └── Bucket: amerch-terraform-state (CI/CD project)
        └── Read/write Terraform state files
```

#### Cloud Build Service Account

```
sa-cb-amerch-{env}@cicd-shared-414116.iam.gserviceaccount.com
├── roles/storage.objectAdmin
│   └── Bucket: amerch-terraform-state (CI/CD project)
│       └── Read/write Terraform state files
└── roles/iam.serviceAccountTokenCreator
    └── On: sa-bq-tf-admin@amerchgcp-amerch-{env}.iam.gserviceaccount.com
        └── Impersonate Terraform service account
```

---

## Least Privilege Principles

### 1. Role-Based Access Control (RBAC)

- **Use predefined roles** where possible, as they are well-tested and follow Google's security best practices
- **Scope permissions** to specific resources (buckets, datasets) rather than project-level when feasible
- **Avoid custom roles** unless absolutely necessary, as they can be harder to maintain and audit

### 2. Service Account Isolation

- **Separate service accounts** for different functions (runtime vs. infrastructure management)
- **No shared service accounts** across different components
- **Environment-specific service accounts** (dev vs. prod) to prevent cross-environment access

### 3. Impersonation for Least Privilege

- **Cloud Build uses impersonation** to run Terraform operations as the Terraform service account
- This allows Cloud Build to have minimal permissions (only state bucket access and token creation)
- Terraform service account has the actual infrastructure management permissions

### 4. Resource-Level Permissions

- **Bucket-level permissions** for GCS access (storage.objectUser on specific bucket)
- **Dataset-level permissions** for BigQuery access (where possible)
- **Secret-level permissions** for Secret Manager access (specific secrets only)

### 5. Regular Access Reviews

- **Review service account permissions** quarterly
- **Audit IAM bindings** to ensure they match documented requirements
- **Remove unused permissions** promptly
- **Document any permission changes** and their justification

---

## Security Best Practices

### 1. Secret Management

- ✅ **Secrets stored in Secret Manager**, not in code or environment variables
- ✅ **Service accounts access only required secrets**, not all secrets
- ✅ **Secrets are encrypted at rest** with Google-managed keys
- ✅ **Secret access is logged** for audit purposes

### 2. Encryption

- ✅ **Data at rest**: Google-managed encryption (default) for GCS and BigQuery
- ✅ **Data in transit**: TLS encryption for all API calls
- ✅ **CMEK optional**: Can be enabled via `kms_key_name` variable if required
- ✅ **Secret encryption**: Secret Manager encrypts secrets at rest

### 3. Access Control

- ✅ **Uniform bucket-level access** enabled on GCS buckets (IAM-only access)
- ✅ **Cloud Functions not publicly accessible** (triggered only by GCS events)
- ✅ **No public IPs** or internet-facing endpoints
- ✅ **VPC Service Controls** can be added if required for compliance

### 4. Audit Logging

- ✅ **All operations logged** to Cloud Logging
- ✅ **IAM policy changes** are audited
- ✅ **Service account usage** is tracked
- ✅ **BigQuery job history** is logged

### 5. Network Security

- ✅ **Private Google Access** can be enabled if required
- ✅ **VPC connectors** can be added for Cloud Functions if needed
- ✅ **No public endpoints** exposed

---

## Permission Justification Process

When requesting new permissions:

1. **Document the requirement**: What operation requires this permission?
2. **Identify the minimum role**: What is the most restrictive role that provides this permission?
3. **Scope the permission**: Can it be scoped to specific resources rather than project-level?
4. **Justify the permission**: Why is this permission necessary? What would break without it?
5. **Review periodically**: Is this permission still needed? Can it be removed?

---

## Compliance and Auditing

### Regular Reviews

- **Quarterly IAM audit**: Review all service account permissions
- **Annual security review**: Comprehensive review of all security controls
- **Access review**: Verify service accounts are still in use and permissions are appropriate

### Documentation

- **This document**: Maintains current permission requirements
- **README files**: Reference this document for security information
- **Change log**: Document any permission changes and their justification

### Monitoring

- **Cloud Logging**: Monitor service account usage
- **Cloud Monitoring**: Alert on unusual access patterns
- **IAM Policy Analyzer**: Use to identify unused permissions

---

## Future Improvements

1. **Replace `roles/editor` with specific roles** for Terraform service account
2. **Implement dataset-level permissions** for BigQuery access where possible
3. **Add VPC Service Controls** if required for compliance
4. **Automate permission reviews** using Cloud Asset Inventory
5. **Implement permission approval workflow** for new permission requests

---

## References

- [Google Cloud IAM Best Practices](https://cloud.google.com/iam/docs/using-iam-securely)
- [Service Account Best Practices](https://cloud.google.com/iam/docs/best-practices-service-accounts)
- [Least Privilege Principle](https://cloud.google.com/iam/docs/using-iam-securely#least-privilege)
- [IAM Roles Reference](https://cloud.google.com/iam/docs/understanding-roles)

---

**Note:** This document should be reviewed and updated whenever service account permissions change. All permission changes should be documented with justification.

