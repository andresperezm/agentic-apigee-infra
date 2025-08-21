# Configure the Google Cloud provider
provider "google" {
  project               = var.project
  user_project_override = true
}

# Create a Discovery Engine data store
resource "google_discovery_engine_data_store" "website_data_store" {
  location          = var.location
  data_store_id     = var.datastore_name
  display_name      = var.datastore_name
  industry_vertical = "GENERIC"
  content_config    = "PUBLIC_WEBSITE"
  solution_types    = ["SOLUTION_TYPE_SEARCH"]
}

# Specify the target site(s) to be indexed
resource "google_discovery_engine_target_site" "target_site" {
  for_each             = var.uris
  data_store_id        = google_discovery_engine_data_store.website_data_store.data_store_id
  provided_uri_pattern = each.key
  type                 = "INCLUDE"
  exact_match          = false
  location             = var.location
}
