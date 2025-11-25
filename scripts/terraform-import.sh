#!/bin/sh
# Terraform Import Helper Script
# Provides consistent error handling and logging for terraform import operations
#
# Usage:
#   terraform-import.sh <resource_address> <resource_id> [options]
#
# Options:
#   --skip-state-check    Skip checking if resource is already in state
#   --non-critical        Treat failures as warnings (non-critical)
#
# Examples:
#   terraform-import.sh google_storage_bucket.pos_files "my-bucket"
#   terraform-import.sh 'google_bigquery_dataset.datasets["my_dataset"]' "projects/my-project/datasets/my_dataset"

set -eu

# Enable pipefail if supported (bash/zsh); ignore error on shells without it
set -o pipefail 2>/dev/null || true

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
RESOURCE_ADDRESS=""
RESOURCE_ID=""
SKIP_STATE_CHECK=false
NON_CRITICAL=false

while [ $# -gt 0 ]; do
  case $1 in
    --skip-state-check)
      SKIP_STATE_CHECK=true
      shift
      ;;
    --non-critical)
      NON_CRITICAL=true
      shift
      ;;
    *)
      if [ -z "$RESOURCE_ADDRESS" ]; then
        RESOURCE_ADDRESS="$1"
      elif [ -z "$RESOURCE_ID" ]; then
        RESOURCE_ID="$1"
      else
        echo -e "${RED}ERROR: Unexpected argument: $1${NC}" >&2
        exit 1
      fi
      shift
      ;;
  esac
done

# Validate required arguments
if [ -z "$RESOURCE_ADDRESS" ] || [ -z "$RESOURCE_ID" ]; then
  echo -e "${RED}ERROR: Missing required arguments${NC}" >&2
  echo "Usage: $0 <resource_address> <resource_id> [--skip-state-check] [--non-critical]" >&2
  exit 1
fi

# Function to check if resource is already in state
check_state() {
  local address="$1"
  if terraform state show "$address" >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

# Function to classify import error
classify_error() {
  local output="$1"

  # Critical errors - permission/authentication issues
  if echo "$output" | grep -qE "error loading state.*impersonate|iam.serviceAccounts.getAccessToken.*denied|Permission 'iam.serviceAccounts.getAccessToken' denied"; then
    echo "CRITICAL_BACKEND"
    return 0
  fi

  if echo "$output" | grep -qE "Permission denied|403|does not have|Permission '.*' denied"; then
    echo "CRITICAL_PERMISSION"
    return 0
  fi

  # Already managed - not an error
  if echo "$output" | grep -qE "already managed by Terraform|Resource already managed"; then
    echo "ALREADY_MANAGED"
    return 0
  fi

  # Resource doesn't exist - informational
  if echo "$output" | grep -qE "404|not found|does not exist"; then
    echo "NOT_FOUND"
    return 0
  fi

  # Other errors
  echo "OTHER"
  return 0
}

# Main import logic
main() {
  echo -e "${BLUE}Importing: ${RESOURCE_ADDRESS} -> ${RESOURCE_ID}${NC}"

  # Check if already in state (unless skipped)
  if [ "$SKIP_STATE_CHECK" = false ]; then
    if check_state "$RESOURCE_ADDRESS"; then
      echo -e "${GREEN}✓ Resource ${RESOURCE_ADDRESS} already in state, skipping import${NC}"
      return 0
    fi
  fi

  # Attempt import

  # echo -e "terraform import ${RESOURCE_ADDRESS} ${RESOURCE_ID} 2>&1"

  terraform import ${RESOURCE_ADDRESS} ${RESOURCE_ID} 2>&1

  IMPORT_OUTPUT=$(terraform import "$RESOURCE_ADDRESS" "$RESOURCE_ID" 2>&1)
  IMPORT_EXIT=$?

  echo -e "Import output : ${IMPORT_OUTPUT};  Import exit ${IMPORT_EXIT}"

  if [ $IMPORT_EXIT -eq 0 ]; then
    echo -e "${GREEN}✓ Successfully imported ${RESOURCE_ADDRESS}${NC}"
    return 0
  fi

  # Classify the error
  ERROR_TYPE=$(classify_error "$IMPORT_OUTPUT")

  case "$ERROR_TYPE" in
    CRITICAL_BACKEND)
      echo -e "${RED}ERROR [CRITICAL]: Backend state access failed - permission denied for impersonation${NC}" >&2
      echo "This indicates the Cloud Build SA cannot impersonate the Terraform SA for backend operations" >&2
      echo "Required permission: roles/iam.serviceAccountTokenCreator on sa-bq-tf-admin" >&2
      echo "Import output: $IMPORT_OUTPUT" >&2
      exit 1
      ;;
    CRITICAL_PERMISSION)
      echo -e "${RED}ERROR [CRITICAL]: Permission denied importing ${RESOURCE_ADDRESS}${NC}" >&2
      echo "Import output: $IMPORT_OUTPUT" >&2
      exit 1
      ;;
    ALREADY_MANAGED)
      echo -e "${GREEN}✓ Resource ${RESOURCE_ADDRESS} already in state, skipping import${NC}"
      return 0
      ;;
    NOT_FOUND)
      echo -e "${BLUE}INFO: Resource ${RESOURCE_ID} does not exist in GCP, will be created by Terraform${NC}"
      return 0
      ;;
    OTHER)
      if [ "$NON_CRITICAL" = true ]; then
        echo -e "${YELLOW}WARNING [NON-CRITICAL]: Failed to import ${RESOURCE_ADDRESS} (may not exist or already managed): $IMPORT_OUTPUT${NC}"
        return 0
      else
        echo -e "${RED}ERROR: Failed to import ${RESOURCE_ADDRESS}: $IMPORT_OUTPUT${NC}" >&2
        exit 1
      fi
      ;;
  esac

  echo -e "Execution completed"
}

# Run main function
main
