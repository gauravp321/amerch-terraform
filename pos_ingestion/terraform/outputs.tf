# Output POS files bucket name
# Business Purpose: Provides the GCS bucket name where POS configuration and data files are uploaded.
# Use this output to reference the bucket in other Terraform modules, scripts, or documentation.
output "bucket_name" {
  description = "Name of the GCS bucket used as the landing zone for POS configuration files and CSV data files. Files uploaded to this bucket trigger the Cloud Function when *_config.json files are created. Use this output to reference the bucket in other modules or scripts."
  value       = google_storage_bucket.pos_files.name
}

# Output POS files bucket URL
# Business Purpose: Provides the GCS bucket URL for direct access or documentation.
# Useful for providing links to users or in documentation for file upload instructions.
output "bucket_url" {
  description = "Full GCS URL of the POS files bucket (gs://bucket-name). Use this for documentation, user instructions, or direct bucket access via gsutil or the GCP Console."
  value       = google_storage_bucket.pos_files.url
}

# Output Cloud Function name
# Business Purpose: Provides the Cloud Function name for monitoring, debugging, or integration.
# Useful for referencing the function in monitoring dashboards, logs, or other services.
output "function_name" {
  description = "Name of the Cloud Function that processes POS configuration files and loads data into BigQuery. Use this for monitoring, logging, or referencing the function in other services."
  value       = google_cloudfunctions2_function.pos_file_processor.name
}

# Output Cloud Function URL
# Business Purpose: Provides the Cloud Function service URL for HTTP invocations (if needed).
# Note: This function is primarily triggered by Eventarc, but the URL can be used for manual testing or HTTP triggers.
output "function_url" {
  description = "Service URL of the Cloud Function (for HTTP invocations). Note: This function is primarily event-driven via Eventarc, but this URL can be used for manual testing or HTTP-based triggers if needed."
  value       = google_cloudfunctions2_function.pos_file_processor.service_config[0].uri
}

# Output trigger resource path pattern
# Business Purpose: Documents the GCS object path pattern that triggers the Cloud Function.
# Useful for understanding which files trigger processing and for troubleshooting.
output "trigger_resource_path" {
  description = "GCS object path pattern that triggers the Cloud Function. Only files matching this pattern (*_config.json) will trigger processing. Use this to understand which files trigger the function and for troubleshooting trigger issues."
  value       = "/projects/_/buckets/${var.bucket_name}/objects/*_config.json"
}

# Output function source bucket name
# Business Purpose: Provides the GCS bucket name where Cloud Function source code archives are stored.
# Useful for debugging deployment issues or understanding the deployment process.
output "function_source_bucket_name" {
  description = "Name of the GCS bucket that stores Cloud Function source code archives. This bucket is separate from the POS files bucket for security isolation. Use this for debugging deployment issues or understanding the function deployment process."
  value       = google_storage_bucket.function_source.name
}

# Output function trigger topic
# Business Purpose: Provides the Pub/Sub topic name used by Eventarc for triggering the function.
# Note: This may not be available on first deployment as Eventarc creates the topic automatically.
output "function_trigger_topic" {
  description = "Pub/Sub topic name used by Eventarc to trigger the Cloud Function. This topic is created automatically by Eventarc on first deployment. May return 'N/A' if the topic hasn't been created yet. Use this for monitoring or debugging Eventarc trigger issues."
  value       = try(google_cloudfunctions2_function.pos_file_processor.event_trigger[0].pubsub_topic, "N/A - topic created on first deployment")
}

# Output function service account
# Business Purpose: Provides the service account email used by the Cloud Function for execution.
# Useful for IAM troubleshooting, monitoring, or understanding function permissions.
output "function_service_account" {
  description = "Service account email used by the Cloud Function for execution. This service account must have permissions to read from GCS, write to BigQuery, and send emails (if email notifications are enabled). Use this for IAM troubleshooting or understanding function permissions."
  value       = google_cloudfunctions2_function.pos_file_processor.service_config[0].service_account_email
}

# Output retention policy lock status
# Business Purpose: Indicates whether the bucket retention policy is locked (immutable).
# Useful for compliance verification and understanding data retention enforcement.
output "retention_policy_locked" {
  description = "Whether the GCS bucket retention policy is locked (immutable). When locked, the retention policy cannot be modified or removed, ensuring data is retained for the full 7-year period. Use this to verify compliance with data retention requirements."
  value       = var.retention_policy_locked
}
