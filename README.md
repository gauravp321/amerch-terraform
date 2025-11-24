# BigQuery Dataflow


This repository contains infrastructure and code for BigQuery data ingestion and processing pipelines.

## Repository Structure

### `pos_ingestion/`

Infrastructure and code for the Point of Sale (POS) file ingestion pipeline. This includes:

- **Terraform Infrastructure as Code (IaC)**: GCP infrastructure provisioning for the POS ingestion pipeline
  - GCS bucket (`eventarc-gp74` for dev, `amerch-pos-files` for prod) for file landing zone
  - Cloud Function (`gcf_pos_file`) triggered by config file uploads
  - Lifecycle policies and event triggers
- **Cloud Function Source Code**: Python-based microservice for processing POS configuration files

The POS ingestion pipeline provides an event-driven mechanism for loading CSV files into BigQuery tables based on configuration files uploaded to GCS.

See [`pos_ingestion/README.md`](pos_ingestion/README.md) for detailed documentation on deployment and usage.

### `bq_objects/`

BigQuery objects and related configurations managed via Terraform. This includes:

- **BigQuery Datasets**: 10 datasets for Fivetran-synced data (MySQL Performance, Salesforce, Workday HCM)
- **BigQuery Tables**: 54 tables with schemas, partitioning, and clustering configurations
- **Data Lineage**: Tracks data flow from source systems (Fivetran connectors) to BigQuery

The BigQuery objects module provisions and manages all datasets and tables used for data warehousing and analytics.

See [`bq_objects/terraform/README.md`](bq_objects/terraform/README.md) for more information.

## Getting Started

### Prerequisites

- Google Cloud Platform (GCP) account with appropriate permissions
- Terraform (>= 1.0) for infrastructure provisioning
- Python 3.x for local development
- `gcloud` CLI for GCP authentication

### Quick Start

1. **Authenticate with GCP**:
   ```bash
   gcloud auth application-default login
   ```

2. **Deploy POS Ingestion Infrastructure**:
   ```bash
   cd pos_ingestion/terraform
   terraform init
   terraform plan
   terraform apply
   ```

For detailed instructions, refer to the README files in each subdirectory.

## Architecture Overview

The system consists of three main components that work together to provide end-to-end data ingestion and storage:

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Data Sources                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
│  │ Cloud SQL     │  │ Salesforce   │  │ Workday HCM  │            │
│  │ MySQL         │  │              │  │              │            │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘            │
│         │                  │                  │                     │
│         │ Fivetran         │ Fivetran        │ Fivetran            │
│         │ Connectors       │ Connector       │ Connector           │
└─────────┼──────────────────┼──────────────────┼────────────────────┘
          │                  │                  │
          │                  │                  │
          ▼                  ▼                  ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    BigQuery Data Warehouse                           │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  10 Datasets:                                                 │  │
│  │  - 8 MySQL Performance datasets (coreapp, activity, etc.)     │  │
│  │  - 1 Salesforce dataset                                       │  │
│  │  - 1 Workday HCM dataset                                      │  │
│  │  - 1 POS Files dataset                                        │  │
│  └──────────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  54 Tables:                                                   │  │
│  │  - Partitioned by _fivetran_synced (where applicable)        │  │
│  │  - Clustered for query optimization                           │  │
│  │  - Schema versioning labels                                   │  │
│  └──────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
          ▲
          │
          │ BigQuery Load Job
          │
┌─────────┴─────────────────────────────────────────────────────────┐
│                    POS File Ingestion Pipeline                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  File Upload (Config + CSV)                                   │  │
│  └───────────────────────┬──────────────────────────────────────┘  │
│                          │                                          │
│                          ▼                                          │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  GCS Bucket (amerch-pos-files-{env})                         │  │
│  │  - Landing zone for files                                     │  │
│  │  - Autoclass storage optimization                             │  │
│  │  - 7-year lifecycle policy                                    │  │
│  └───────────────────────┬──────────────────────────────────────┘  │
│                          │                                          │
│                          │ storage.objects.create (*_config.json)  │
│                          ▼                                          │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  Eventarc Trigger (gcs_trigger)                               │  │
│  └───────────────────────┬──────────────────────────────────────┘  │
│                          │                                          │
│                          ▼                                          │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  Cloud Function (gcf_pos_file)                                │  │
│  │  - Reads and validates config file                            │  │
│  │  - Validates CSV file format                                  │  │
│  │  - Loads data to BigQuery                                     │  │
│  │  - Sends email notifications                                  │  │
│  └──────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

### Infrastructure Management

```
┌─────────────────────────────────────────────────────────────────────┐
│                    Infrastructure as Code (Terraform)                │
│  ┌──────────────────────────┐  ┌──────────────────────────┐        │
│  │  bq_objects/terraform/   │  │  pos_ingestion/terraform/│        │
│  │  - Datasets & Tables      │  │  - GCS Buckets          │        │
│  │  - Schema definitions    │  │  - Cloud Functions      │        │
│  │  - Lifecycle blocks      │  │  - Eventarc Triggers    │        │
│  └──────────┬───────────────┘  └──────────┬───────────────┘        │
└─────────────┼──────────────────────────────┼───────────────────────┘
              │                              │
              │                              │
              ▼                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    CI/CD Pipeline (Cloud Build)                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  1. Terraform Init & Validate                                │  │
│  │  2. Terraform Plan (with schema drift detection)            │  │
│  │  3. Manual Approval Gate                                     │  │
│  │  4. Terraform Apply                                          │  │
│  │  5. Schema Drift Logging                                     │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  Triggered by:                                                      │
│  - Pull Requests → Plan only                                        │
│  - Branch Merges → Plan + Apply (with approval)                    │
└─────────────────────────────────────────────────────────────────────┘
```

### Component Relationships

- **POS Ingestion Pipeline**: Event-driven file processing that automatically loads CSV files into BigQuery when configuration files are uploaded
- **BigQuery Objects**: Pre-provisioned datasets and tables that receive data from both the POS ingestion pipeline and Fivetran connectors
- **Fivetran Connectors**: Automated data replication from source systems (Cloud SQL MySQL, Salesforce, Workday HCM) to BigQuery
- **CI/CD Pipeline**: Unified Cloud Build workflow that deploys both POS ingestion and BigQuery infrastructure together
- **Infrastructure as Code**: All infrastructure managed via Terraform with version control, validation, and automated deployment

## Data Flow

### POS File Ingestion Flow

1. **File Upload**: User uploads a `*_config.json` file to the GCS bucket
2. **Event Trigger**: GCS `storage.objects.create` event triggers the Cloud Function
3. **Config Processing**: Function reads and validates the configuration file
4. **Data Validation**: Function validates the referenced CSV file (size, format, permissions)
5. **BigQuery Load**: Function initiates a BigQuery load job from GCS to the target table
6. **File Cleanup**: Processed files are moved to `processed/` folder
7. **Notification**: Success or failure email notifications are sent

### BigQuery Data Flow

1. **Fivetran Connectors**: External data sources (MySQL, Salesforce, Workday) are synced via Fivetran
2. **Raw Datasets**: Data lands in `raw_fivetran_*` datasets
3. **Table Structure**: Tables are partitioned and clustered for query performance
4. **Data Consumption**: Analytics and reporting tools query the BigQuery tables

## Environment

### Projects

- **Development**: `quantiphi-test-470710`
- **Production**: `amerchgcp-amerch-prod`

### Regions

- **Primary Region**: `us-central1` (all resources)

### CI/CD Configuration

- **CI/CD Project**: `cicd-shared-414116`
- **State Bucket**: `amerch-terraform-state`
- **State Prefix**: `bq_dataflow/{environment}/{module}`
- **Repository**: `dashmanagement/bq_dataflow` (Bitbucket)
- **Configuration File**: `cloudbuild-plan.yaml` (repository root)

### Resource Naming

- **GCS Buckets**: `amerch-pos-files-{env}` (e.g., `eventarc-gp74`)
- **Cloud Function**: `gcf_pos_file`
- **BigQuery Datasets**: `raw_fivetran_{source}_{module}` (e.g., `raw_fivetran_gcloud_performance_coreapp`)
- **Service Accounts**: Project-specific (e.g., `terraform-demo@quantiphi-test-470710.iam.gserviceaccount.com`)

## Security

For comprehensive security documentation, including service account permissions, least privilege principles, and permission matrices, see [docs/SECURITY.md](docs/SECURITY.md).

### IAM Roles

**Terraform Service Account** (`terraform-demo@quantiphi-test-470710.iam.gserviceaccount.com`):
- Infrastructure provisioning permissions
- Service account impersonation capabilities
- State bucket access

**Cloud Function Runtime Service Account** (`cfdl-gp-test@quantiphi-test-470710.iam.gserviceaccount.com`):
- `roles/storage.objectUser` - Read/write GCS objects
- `roles/bigquery.dataEditor` - Load data to BigQuery
- `roles/bigquery.jobUser` - Create BigQuery jobs
- `roles/secretmanager.secretAccessor` - Access secrets
- `roles/logging.logWriter` - Write logs
- `roles/monitoring.metricWriter` - Write metrics

**See [docs/SECURITY.md](docs/SECURITY.md) for detailed permission justifications and least privilege documentation.**

### Encryption

- **GCS**: Default encryption at rest (Google-managed keys) - Sufficient for sales data
- **BigQuery**: Default encryption at rest
- **Secrets**: Stored in Secret Manager with encryption at rest
- **In Transit**: All communications use TLS

**Note:** CMEK (Customer-Managed Encryption Keys) is optional and not required for sales data. The infrastructure supports CMEK via `kms_key_name` variable if needed in the future, but Google-managed encryption is sufficient for business sales data.

### Access Control

- **GCS Buckets**: Uniform bucket-level access enabled
- **BigQuery Datasets**: Access controlled via IAM policies
- **Cloud Function**: Invoked only by GCS events (no public access)
- **State Bucket**: Access restricted to Cloud Build service accounts

## Troubleshooting

### Common Issues

**Cloud Build Failures**

- **Permission Errors**: Verify Terraform service account has required IAM roles
- **State Lock Errors**: Check if another build is running or manually unlock state
- **Import Failures**: Ensure resources exist in GCP before importing

**Cloud Function Errors**

- **Timeout Errors**: Check BigQuery job duration (max 540 seconds)
- **Permission Errors**: Verify runtime service account has required roles
- **File Not Found**: Ensure CSV file exists at the path specified in config
- **Schema Mismatch**: Verify CSV format matches expected schema

**BigQuery Load Failures**

- **Quota Exceeded**: Check BigQuery quotas and retry with exponential backoff
- **Invalid CSV Format**: Validate CSV delimiter, encoding, and header row
- **Table Not Found**: Ensure target dataset and table exist

### Debugging Steps

1. **Check Cloud Build Logs**: Review build history in Cloud Build console
2. **Check Cloud Function Logs**: View logs in Cloud Logging with filter `resource.type="cloud_function"`
3. **Check BigQuery Job Status**: Query `INFORMATION_SCHEMA.JOBS` for job details
4. **Verify Permissions**: Use `gcloud projects get-iam-policy` to check IAM bindings
5. **Validate Terraform State**: Run `terraform state list` to verify resources are tracked

### Getting Help

- Review module-specific README files for detailed troubleshooting
- Check Cloud Logging for detailed error messages
- Verify IAM permissions match documented requirements
- Ensure all prerequisites are met before deployment

## Contributing

### Development Workflow

1. **Create Feature Branch**: Branch from `dev` for development work
2. **Make Changes**: Update Terraform configurations or Cloud Function code
3. **Test Locally**: Run `terraform validate` and `terraform plan` locally
4. **Open Pull Request**: PR triggers Cloud Build plan (no apply)
5. **Review**: Team reviews plan output in PR
6. **Merge**: Merge to `dev` triggers full CI/CD pipeline
7. **Approval**: Manual approval required before apply steps

### Code Standards

- **Terraform**: Follow HashiCorp style guide, run `terraform fmt` before committing
- **Python**: Follow PEP 8, use type hints, include docstrings
- **Documentation**: Update README files when adding features or changing behavior
- **Commits**: Use conventional commit format (`feat:`, `fix:`, `docs:`, etc.)

### Testing Requirements

- **Terraform**: All configurations must pass `terraform validate` and `terraform fmt -check`
- **Cloud Function**: Unit tests for critical functions (when test infrastructure is available)
- **Documentation**: README files must be updated for any user-facing changes

### Infrastructure Testing

This repository includes automated testing for Terraform configurations:

**Local Testing:**
```bash
# Run all validation checks
make test

# Validate specific module
make validate-bq    # BigQuery objects
make validate-pos   # POS ingestion

# Format Terraform files
make fmt
```

**Pre-commit Hooks:**
Pre-commit hooks automatically validate code before commits. Install once:
```bash
make install-pre-commit
```

**CI/CD Testing:**
Cloud Build automatically runs validation on all pull requests and merges, including:
- Terraform formatting checks
- Terraform syntax validation
- Configuration validation

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed testing documentation.

### Review Process

- All PRs require at least one approval
- Cloud Build plan output must be reviewed before merge
- Breaking changes require explicit documentation
