# Configure the Google Cloud provider
provider "google" {}

module "datastore" {
  source  = "./modules/agents_ds"
  project = var.project
  uris    = var.uris
}

module "mcp_server_sa" {
  source  = "./modules/mcp_server_sa"
  project = var.project
}

module "apigee_agents_sa" {
  source  = "./modules/agents_sa"
  project = var.project
}

module "db" {
  source   = "./modules/agents_db"
  project  = var.project
  location = var.db_location
}
