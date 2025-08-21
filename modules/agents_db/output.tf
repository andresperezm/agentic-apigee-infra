# Output the instance's public IP and the generated password
output "connection_name" {
  description = "The name of the Cloud SQL DB connection."
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "db_name_secret_id" {
  description = "The ID of the secret containing the database name."
  value       = google_secret_manager_secret.db_name_secret.id
}

output "user_secret_id" {
  description = "The ID of the secret containing the database user."
  value       = google_secret_manager_secret.db_user_secret.id
}

output "password_secret_id" {
  description = "The ID of the secret containing the database password."
  value       = google_secret_manager_secret.db_password_secret.id
}
