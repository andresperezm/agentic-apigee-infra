# Configure the Google Cloud provider
provider "google" {}
provider "google-beta" {}

module "iam" {
  source  = "./modules/iam"
  project = var.project
}

module "db" {
  source   = "./modules/agents_db"
  project  = var.project
  location = var.location
}

module "datastore" {
  source         = "./modules/agents_ds"
  project        = var.project
  datastore_name = "apigee-fundamentals-ds"
  uris           = var.uris
}
module "mcp_server" {
  source              = "./modules/mcp_server"
  project             = var.project
  location            = var.location
  agents_sa_email     = module.iam.apigee_agents_sa_email
  mcp_server_sa_email = module.iam.mcp_server_sa_email
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
}
