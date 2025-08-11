output "mcp_server_sa_email" {
  value = google_service_account.mcp_server_sa.email
}

output "mcp_server_deploy_sa_email" {
    value = google_service_account.mcp_server_deploy_sa.email
}