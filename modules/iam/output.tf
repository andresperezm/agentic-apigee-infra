output "apigee_agents_sa_email" {
  value = google_service_account.apigee_agents_sa.email
}

output "mcp_server_sa_email" {
  value = google_service_account.mcp_server_sa.email
}
