output "datastore_id" {
  value = google_discovery_engine_data_store.website_data_store
}

output "datastore_location" {
    value = google_discovery_engine_data_store.website_data_store.location
}