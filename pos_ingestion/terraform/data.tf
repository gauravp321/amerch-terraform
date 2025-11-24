# Data Sources
# This file contains all data source definitions for the POS ingestion infrastructure

# Data source to get the bucket location (needed for Eventarc trigger)
# Business Purpose: Eventarc requires the trigger location to match the bucket location exactly.
# Design Decision: This data source handles cases where the bucket is multi-region (e.g., "US") vs regional.
# Using a data source ensures we get the actual bucket location rather than assuming it matches var.region,
# which is critical for Eventarc trigger creation. The location is converted to lowercase for Eventarc compatibility.
data "google_storage_bucket" "pos_files" {
  name = var.bucket_name
}

# Archive Cloud Function source code
# Business Purpose: Packages the Cloud Function source code and dependencies into a ZIP archive for deployment.
# Design Decision: Uses Terraform's archive_file data source to create the deployment package automatically.
# The archive includes all files from src/ directory and is uploaded to GCS for Cloud Functions to use.
# MD5 hash in the archive name enables cache busting to ensure new deployments use updated code.
data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/function-source.zip"
}
