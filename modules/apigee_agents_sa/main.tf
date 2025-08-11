# Configure the Google Cloud provider
provider "google" {
  project = var.project
  user_project_override = true
}

# Define local variables for easy configuration
locals {
  apigee_agents_roles = [
    "roles/aiplatform.user",
    "roles/discoveryengine.user"
  ]
  apigee_agents_deploy_roles = [
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/artifactregistry.writer",
    "roles/run.admin",
    "roles/iam.serviceAccountUser"
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
  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.apigee_agents_sa.email}"
}

# Apigee agents deploy Service Account
resource "google_service_account" "apigee_agents_deploy_sa" {
  account_id   = "${var.agents_service_name}-deploy-sa"
  display_name = "Apigee MCP Server Deploy SA"
  description  = "Service account that will be used to deploy the Apigee Agents"
}

# Assign IAM Roles to the Apigee Agents Service Account
resource "google_project_iam_member" "apigee_agents_deploy_sa_roles" {
  for_each = toset(local.apigee_agents_deploy_roles)
  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.apigee_agents_deploy_sa.email}"
}