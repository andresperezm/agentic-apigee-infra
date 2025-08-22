# Configure the Google Cloud provider
provider "google" {}
provider "google-beta" {}

module "iam" {
  source  = "./modules/iam"
  project = var.project
}

module "db" {
  source          = "./modules/agents_db"
  project         = var.project
  location        = var.location
  agents_sa_email = module.iam.apigee_agents_sa_email
}

module "datastore" {
  source          = "./modules/agents_ds"
  project         = var.project
  datastore_name  = "apigee-fundamentals-ds"
  uris            = var.uris
  agents_sa_email = module.iam.apigee_agents_sa_email
}
module "mcp_server" {
  source              = "./modules/mcp_server"
  project             = var.project
  location            = var.location
  agents_sa_email     = module.iam.apigee_agents_sa_email
  mcp_server_sa_email = module.iam.mcp_server_sa_email
  mcp_service_name    = coalesce(var.mcp_service_name, var.mcp_image_name)
  mcp_image_name      = var.mcp_image_name
  mcp_image_version   = var.mcp_image_version
}

module "agents" {
  source                = "./modules/agents"
  project               = var.project
  location              = var.location
  agent_accessors       = var.agent_accessors
  datastore_id          = module.datastore.datastore_id
  mcp_server_url        = module.mcp_server.mcp_server_url
  db_connection_name    = module.db.connection_name
  db_name_secret_id     = module.db.db_name_secret_id
  db_user_secret_id     = module.db.user_secret_id
  db_password_secret_id = module.db.password_secret_id
  agents_sa_email       = module.iam.apigee_agents_sa_email
  agents_service_name   = coalesce(var.agents_service_name, var.agents_image_name)
  agents_image_name     = var.agents_image_name
  agents_image_version  = var.agents_image_version
}
