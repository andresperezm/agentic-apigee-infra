output "datastore_id" {
  value = module.datastore.datastore_id
}

output "datastore_location" {
    value = module.datastore.datastore_location
}

output "mcp_server_sa_email" {
  value = module.mcp_server_sa.mcp_server_sa_email
}

output "mcp_server_deploy_sa_email" {
    value = module.mcp_server_sa.mcp_server_deploy_sa_email
}