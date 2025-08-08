# Configure the Google Cloud provider
provider "google" {}

module "datastore" {
  source          = "./modules/knowledge_agent_datastore"
  project         = var.project
  uris            = var.uris
}
