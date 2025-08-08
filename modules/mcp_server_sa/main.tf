# Configure the Google Cloud provider
provider "google" {
  project = var.project
  user_project_override = true
}

# Define local variables for easy configuration
locals {
  mcp_server_roles = [
    "roles/apigee.admin"
  ]
  mcp_server_deploy_roles = [
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/artifactregistry.writer",
    "roles/run.admin",
    "roles/iam.serviceAccountUser"
  ]
}

# MCP Server Service Account
resource "google_service_account" "mcp_server_sa" {
  account_id   = "${var.mcp_service_name}-sa"
  display_name = "Apigee MCP Server SA"
  description  = "Service account that will be used by the Apigee MCP server"
}

# Assign IAM Roles to the MCP Server Service Account
resource "google_project_iam_member" "mcp_server_sa_roles" {
  for_each = toset(local.mcp_server_roles)
  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.mcp_server_sa.email}"
}

# MCP Server Deploy Service Account
resource "google_service_account" "mcp_server_deploy_sa" {
  account_id   = "${var.mcp_service_name}-deploy-sa"
  display_name = "Apigee MCP Server Deploy SA"
  description  = "Service account that will be used to deploy the Apigee MCP server"
}

# Assign IAM Roles to the MCP Server Service Account
resource "google_project_iam_member" "mcp_server_deploy_sa_roles" {
  for_each = toset(local.mcp_server_deploy_roles)
  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.mcp_server_deploy_sa.email}"
}