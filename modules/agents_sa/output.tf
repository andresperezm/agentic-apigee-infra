output "apigee_agents_sa_email" {
  value = google_service_account.apigee_agents_sa.email
}

output "apigee_agents_deploy_sa_email" {
    value = google_service_account.apigee_agents_deploy_sa.email
}