#!/bin/bash
# Terraform validation script for local and CI/CD use
# Usage: ./scripts/validate-terraform.sh [terraform-dir]
# Example: ./scripts/validate-terraform.sh bq_objects/terraform

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}ERROR:${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

print_info() {
    echo -e "ℹ ${1}"
}

# Function to validate a Terraform directory
validate_terraform_dir() {
    local tf_dir="$1"
    local dir_name=$(basename "$tf_dir")

    if [ ! -d "$tf_dir" ]; then
        print_error "Directory does not exist: $tf_dir"
        return 1
    fi

    print_info "Validating Terraform in: $tf_dir"
    cd "$tf_dir"

    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed or not in PATH"
        return 1
    fi

    local terraform_version=$(terraform version -json | jq -r '.terraform_version')
    print_info "Terraform version: $terraform_version"

    # Check required version
    local required_version=$(grep -E '^\s*required_version\s*=' main.tf 2>/dev/null | head -1 | sed -E 's/.*>= ([0-9]+\.[0-9]+).*/\1/' || echo "")
    if [ -n "$required_version" ]; then
        print_info "Required version: >= $required_version"
    fi

    # Step 1: Format check
    print_info "Checking Terraform formatting..."
    if terraform fmt -check -recursive -diff . > /tmp/terraform-fmt-${dir_name}.log 2>&1; then
        print_success "Terraform formatting is correct"
    else
        print_error "Terraform files are not properly formatted"
        echo "Run 'terraform fmt -recursive' to fix formatting issues"
        cat /tmp/terraform-fmt-${dir_name}.log
        return 1
    fi

    # Step 2: Initialize (without backend for validation)
    print_info "Initializing Terraform (backend=false)..."
    if terraform init -backend=false > /tmp/terraform-init-${dir_name}.log 2>&1; then
        print_success "Terraform initialization successful"
    else
        print_error "Terraform initialization failed"
        cat /tmp/terraform-init-${dir_name}.log
        return 1
    fi

    # Step 3: Validate syntax and configuration
    print_info "Validating Terraform configuration..."
    if terraform validate -no-color > /tmp/terraform-validate-${dir_name}.log 2>&1; then
        print_success "Terraform validation passed"
    else
        print_error "Terraform validation failed"
        cat /tmp/terraform-validate-${dir_name}.log
        return 1
    fi

    # Step 4: Check for common issues
    print_info "Checking for common Terraform issues..."
    local issues_found=0

    # Check for hardcoded credentials (basic check)
    if grep -r -i "password\|secret\|api_key" --include="*.tf" --include="*.tfvars" . | grep -v "#\|variable\|output\|description" | grep -v "\.example\|\.dev" > /dev/null 2>&1; then
        print_warning "Potential hardcoded credentials found (review manually)"
        issues_found=$((issues_found + 1))
    fi

    # Check for missing descriptions in variables
    local vars_without_desc=$(grep -r "^variable" --include="*.tf" . | wc -l)
    local vars_with_desc=$(grep -r "description\s*=" --include="*.tf" . | wc -l)
    if [ "$vars_without_desc" -gt "$vars_with_desc" ]; then
        print_warning "Some variables may be missing descriptions"
        issues_found=$((issues_found + 1))
    fi

    if [ $issues_found -eq 0 ]; then
        print_success "No common issues detected"
    fi

    # Cleanup
    rm -f /tmp/terraform-*-${dir_name}.log 2>/dev/null || true

    print_success "All validation checks passed for $dir_name"
    return 0
}

# Main execution
main() {
    local tf_dirs=()

    # If directory argument provided, validate only that directory
    if [ $# -gt 0 ]; then
        tf_dirs=("$@")
    else
        # Otherwise, validate all Terraform directories
        tf_dirs=(
            "bq_objects/terraform"
            "pos_ingestion/terraform"
        )
    fi

    local failed=0
    local total=${#tf_dirs[@]}

    print_info "Validating $total Terraform directory(ies)..."
    echo ""

    for tf_dir in "${tf_dirs[@]}"; do
        if [ ! -d "$tf_dir" ]; then
            print_error "Directory not found: $tf_dir"
            failed=$((failed + 1))
            continue
        fi

        # Save current directory
        local original_dir=$(pwd)

        if validate_terraform_dir "$tf_dir"; then
            echo ""
        else
            failed=$((failed + 1))
            echo ""
        fi

        # Return to original directory
        cd "$original_dir"
    done

    echo "=========================================="
    if [ $failed -eq 0 ]; then
        print_success "All Terraform validations passed ($total/$total)"
        return 0
    else
        print_error "Terraform validation failed ($failed/$total directories)"
        return 1
    fi
}

# Run main function
main "$@"
