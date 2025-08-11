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

output "apigee_agents_sa_email" {
  value = module.apigee_agents_sa.apigee_agents_sa_email
}

output "apigee_agents_deploy_sa_email" {
  value = module.apigee_agents_sa.apigee_agents_deploy_sa_email
}

output "db_connection_name" {
  value = module.db.connection_name
}

output "db_name_secret_id" {
  value = module.db.name_secret_id
}

output "db_user_secret_id" {
  value = module.db.user_secret_id
}

output "db_password_secret_id" {
  value = module.db.password_secret_id
}
