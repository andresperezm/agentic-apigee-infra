# Configure the Google Cloud provider
provider "google" {
  project               = var.project
  user_project_override = true
}

provider "google-beta" {
  project               = var.project
  user_project_override = true
}

# Define local variables for easy configuration
locals {
  apigee_agents_roles = [
    "roles/aiplatform.user",
    "roles/discoveryengine.user",
    "roles/cloudsql.client",
    "roles/secretmanager.secretAccessor"
  ]
  mcp_server_roles = [
    "roles/apigee.admin"
  ]
}

# Apigee Agents Service Account
resource "google_service_account" "apigee_agents_sa" {
  account_id   = "${var.agents_service_name}-sa"
  display_name = "Apigee Agents SA"
  description  = "Service account that will be used by the Apigee Agents"
}

# Assign IAM Roles to the Apigee agents Service Account
resource "google_project_iam_member" "apigee_agents_sa_roles" {
  for_each = toset(local.apigee_agents_roles)
  project  = var.project
  role     = each.key
  member   = google_service_account.apigee_agents_sa.member
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
  project  = var.project
  role     = each.key
  member   = google_service_account.mcp_server_sa.member
}
