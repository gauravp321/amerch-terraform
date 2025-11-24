# Makefile for Terraform infrastructure validation and testing
.PHONY: help validate fmt fmt-check test clean install-pre-commit

help: ## Show this help message
	@echo "Terraform Infrastructure Testing"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

validate: ## Validate all Terraform configurations
	@echo "Validating Terraform configurations..."
	@./scripts/validate-terraform.sh

validate-bq: ## Validate BigQuery Terraform configuration
	@./scripts/validate-terraform.sh bq_objects/terraform

validate-pos: ## Validate POS ingestion Terraform configuration
	@./scripts/validate-terraform.sh pos_ingestion/terraform

fmt: ## Format all Terraform files
	@echo "Formatting Terraform files..."
	@cd bq_objects/terraform && terraform fmt -recursive
	@cd pos_ingestion/terraform && terraform fmt -recursive
	@echo "✓ Formatting complete"

fmt-check: ## Check Terraform formatting without modifying files
	@echo "Checking Terraform formatting..."
	@cd bq_objects/terraform && terraform fmt -check -recursive || (echo "❌ Formatting issues found. Run 'make fmt' to fix." && exit 1)
	@cd pos_ingestion/terraform && terraform fmt -check -recursive || (echo "❌ Formatting issues found. Run 'make fmt' to fix." && exit 1)
	@echo "✓ All files are properly formatted"

test: fmt-check validate ## Run all tests (format check + validation)

install-pre-commit: ## Install pre-commit hooks
	@echo "Installing pre-commit hooks..."
	@PRE_COMMIT_CMD=""; \
	if [ -d "venv" ] && [ -f "venv/bin/pre-commit" ]; then \
		PRE_COMMIT_CMD="venv/bin/pre-commit"; \
	elif [ -d "venv" ] && [ -f "venv/bin/activate" ]; then \
		echo "Installing pre-commit in virtual environment..."; \
		. venv/bin/activate && pip install pre-commit; \
		PRE_COMMIT_CMD="venv/bin/pre-commit"; \
	elif command -v pre-commit &> /dev/null; then \
		PRE_COMMIT_CMD="pre-commit"; \
	elif command -v pip3 &> /dev/null; then \
		echo "Installing pre-commit with pip3..."; \
		pip3 install pre-commit; \
		PRE_COMMIT_CMD="pre-commit"; \
	elif command -v pip &> /dev/null; then \
		echo "Installing pre-commit with pip..."; \
		pip install pre-commit; \
		PRE_COMMIT_CMD="pre-commit"; \
	else \
		echo "ERROR: No pip/pip3 found. Please install Python and pip first."; \
		echo "  macOS: brew install python3"; \
		echo "  Or activate your virtual environment and try again."; \
		exit 1; \
	fi; \
	$$PRE_COMMIT_CMD install
	@echo "✓ Pre-commit hooks installed"

pre-commit-run: ## Run pre-commit hooks on all files
	@if [ -f "venv/bin/pre-commit" ]; then \
		venv/bin/pre-commit run --all-files; \
	elif command -v pre-commit &> /dev/null; then \
		pre-commit run --all-files; \
	else \
		echo "ERROR: pre-commit not found. Run 'make install-pre-commit' first."; \
		exit 1; \
	fi

clean: ## Clean Terraform cache and temporary files
	@echo "Cleaning Terraform cache..."
	@cd bq_objects/terraform && rm -rf .terraform .terraform.lock.hcl terraform.tfstate.d
	@cd pos_ingestion/terraform && rm -rf .terraform .terraform.lock.hcl terraform.tfstate.d
	@echo "✓ Clean complete"
