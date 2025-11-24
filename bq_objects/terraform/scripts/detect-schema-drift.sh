#!/bin/bash
# Schema Drift Detection Script for Fivetran Tables
# Analyzes Terraform plan to detect any changes on Fivetran-managed tables.
# Logs findings for monitoring/alerting even though lifecycle blocks prevent
# schema changes from being applied.
#
# This script runs after terraform plan and checks for any resource changes
# on google_bigquery_table resources. Since lifecycle blocks ignore schema,
# time_partitioning, and clustering changes, this helps detect when Fivetran
# has modified table schemas.

set -euo pipefail

PLAN_FILE="${1:-tfplan-bq}"
TERRAFORM_DIR="${2:-.}"

if [ ! -f "$TERRAFORM_DIR/$PLAN_FILE" ]; then
  echo "WARNING: Plan file $TERRAFORM_DIR/$PLAN_FILE not found. Skipping drift detection."
  exit 0
fi

echo "=========================================="
echo "Schema Drift Detection for Fivetran Tables"
echo "=========================================="
echo ""

cd "$TERRAFORM_DIR"

# Check if jq is available (required for JSON parsing)
if ! command -v jq &> /dev/null; then
  echo "INFO: jq not available. Using terraform plan text output for detection."
  USE_JSON=false
else
  USE_JSON=true
fi

if [ "$USE_JSON" = true ]; then
  # Extract plan JSON and analyze for table changes
  PLAN_JSON=$(terraform show -json "$PLAN_FILE" 2>/dev/null || echo "{}")

  if [ "$PLAN_JSON" = "{}" ]; then
    echo "WARNING: Could not extract plan JSON. Skipping drift detection."
    exit 0
  fi

  # Find all google_bigquery_table resources with any changes
  # Note: With lifecycle blocks, schema changes won't appear, but other changes might
  TABLE_CHANGES=$(echo "$PLAN_JSON" | jq -c '
    [.resource_changes[]? |
    select(.type == "google_bigquery_table") |
    select(.change.actions[]? | . != "no-op") |
    {
      address: .address,
      actions: .change.actions,
      action_summary: (
        if (.change.actions | contains(["create"])) then "create"
        elif (.change.actions | contains(["delete"])) then "delete"
        elif (.change.actions | contains(["update"])) then "update"
        elif (.change.actions | contains(["replace"])) then "replace"
        else "unknown"
        end
      )
    }]
  ' 2>/dev/null || echo "[]")

  # Get change count, ensuring we get a single integer value
  # Use -c (compact) to avoid newlines, then extract length
  CHANGE_COUNT=$(echo "$TABLE_CHANGES" | jq -r 'length' 2>/dev/null || echo "0")
  # Ensure we have a single integer value (strip any whitespace/newlines)
  CHANGE_COUNT=$(echo "$CHANGE_COUNT" | tr -d '\n\r ' | grep -oE '^[0-9]+' || echo "0")

  if [ "$CHANGE_COUNT" -eq 0 ]; then
    echo "✓ No changes detected on Fivetran-managed tables"
    echo ""
    echo "Note: Lifecycle blocks prevent schema drift from appearing in plans."
    echo "If Fivetran modifies schemas, those changes are ignored by Terraform."
    exit 0
  fi

  echo "⚠️  CHANGES DETECTED: $CHANGE_COUNT Fivetran table(s) have pending changes"
  echo ""
  echo "The following tables have changes (note: schema changes are ignored by lifecycle blocks):"
  echo ""

  # Log each detected change (only if we have valid JSON array)
  if [ "$CHANGE_COUNT" -gt 0 ] && [ "$CHANGE_COUNT" != "" ]; then
    echo "$TABLE_CHANGES" | jq -r '.[] |
      "  - \(.address) [\(.action_summary)]"
    ' 2>/dev/null || echo "$TABLE_CHANGES" | jq -r '
      "  - \(.address) [\(.action_summary)]"
    ' 2>/dev/null || echo "  (Unable to parse change details)"
  fi

else
  # Fallback: Parse terraform plan text output
  PLAN_OUTPUT=$(terraform show "$PLAN_FILE" 2>/dev/null || echo "")

  if [ -z "$PLAN_OUTPUT" ]; then
    echo "WARNING: Could not read plan output. Skipping drift detection."
    exit 0
  fi

  # Count table resources with changes
  CHANGE_COUNT=$(echo "$PLAN_OUTPUT" | grep -c "google_bigquery_table\." || echo "0")

  if [ "$CHANGE_COUNT" -eq 0 ]; then
    echo "✓ No changes detected on Fivetran-managed tables"
    exit 0
  fi

  echo "⚠️  CHANGES DETECTED: Found references to table changes in plan"
  echo ""
  echo "Note: Lifecycle blocks prevent schema changes from being applied."
  echo "Review the plan output above for details on any non-schema changes."
fi

echo ""
echo "=========================================="
echo "Drift Detection Summary"
echo "=========================================="
echo "Tables with changes: $CHANGE_COUNT"
echo ""
echo "Lifecycle blocks ensure schema, time_partitioning, and clustering"
echo "changes are ignored to prevent Terraform from reverting Fivetran's"
echo "schema modifications. Other changes (if any) will be applied."
echo ""

# Log to Cloud Logging in structured format (if running in Cloud Build)
if [ -n "${BUILD_ID:-}" ]; then
  LOG_ENTRY=$(cat <<EOF
{
  "severity": "WARNING",
  "message": "Fivetran table changes detected in Terraform plan",
  "change_count": $CHANGE_COUNT,
  "build_id": "${BUILD_ID:-unknown}",
  "plan_file": "$PLAN_FILE"
}
EOF
)

  # Use gcloud logging if available
  if command -v gcloud &> /dev/null && [ -n "${PROJECT_ID:-}" ]; then
    echo "$LOG_ENTRY" | gcloud logging write schema-drift \
      --payload-type=json \
      --severity=WARNING \
      --project="${PROJECT_ID}" 2>/dev/null || echo "$LOG_ENTRY"
  else
    echo "Structured log entry:"
    echo "$LOG_ENTRY"
  fi
fi

# Exit with 0 to never fail the build
# This is informational only - lifecycle blocks prevent schema changes from being applied
exit 0
