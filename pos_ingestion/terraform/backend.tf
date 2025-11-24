terraform {
  backend "gcs" {
    # Backend bucket for Terraform state storage
    # CI/CD Configuration:
    #   - State bucket: amerch-terraform-state (in project quantiphi-test-470710)
    #   - Prefix: bq_dataflow/{environment}/pos_ingestion (e.g., bq_dataflow/dev/pos_ingestion, bq_dataflow/prod/pos_ingestion)
    #   - In Cloud Build, overridden via -backend-config flags:
    #     -backend-config="bucket=${_TERRAFORM_STATE_BUCKET}"
    #     -backend-config="prefix=${_TERRAFORM_STATE_PREFIX}/pos_ingestion"
    # 
    # WARNING: Default values below are for local development only.
    # Cloud Build MUST override these via -backend-config flags.
    # For local development, update these values or use backend config file.
    # bucket = "eventarc-gp74"
    # prefix = "terraform-state/pos_ingestion"

    bucket = "amerch-terraform-state"
    prefix = "bq_dataflow/dev/pos_ingestion/"

    # Encryption: State is encrypted using Google-managed encryption keys by default.
    # For customer-managed encryption keys (CMEK), add encryption_key configuration.
    # encryption_key = "projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING/cryptoKeys/KEY_NAME"
  }
}

