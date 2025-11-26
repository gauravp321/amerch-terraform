# Local values for the tables module
# These are derived from variables passed from the parent module

locals {
  # Base labels passed from parent module
  labels = var.labels

  # Lineage labels for each source system
  lineage_labels_mysql      = var.lineage_labels_mysql
  lineage_labels_salesforce  = var.lineage_labels_salesforce
  lineage_labels_workday_hcm = var.lineage_labels_workday_hcm
}
