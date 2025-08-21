# Configure the Google Cloud provider
provider "google" {
  project               = var.project
  user_project_override = true
}


# 1. Create the Cloud SQL for PostgreSQL instance
resource "google_sql_database_instance" "postgres_instance" {
  name             = "organization-agent-db"
  database_version = "POSTGRES_14"
  region           = var.location

  settings {
    tier = "db-custom-1-3840"

    ip_configuration {
      ipv4_enabled = true
    }

    backup_configuration {
      enabled = false
    }
  }

  deletion_protection = false
}

# 2. Create a database within the instance
resource "google_sql_database" "app_db" {
  name     = "agentic-apigee"
  instance = google_sql_database_instance.postgres_instance.name
}

# 3. Generate a random password for the database user
resource "random_password" "db_user_password" {
  length  = 16
  special = true
}

# 4. Create a user for the database
resource "google_sql_user" "db_user" {
  name     = "agents"
  instance = google_sql_database_instance.postgres_instance.name
  password = random_password.db_user_password.result
}

# 5. Create secrets in Secret Manager
resource "google_secret_manager_secret" "db_name_secret" {
  secret_id = "apigee_agents_db_name"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "db_user_secret" {
  secret_id = "apigee_agents_db_user"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "apigee_agents_db_password"
  replication {
    auto {}
  }
}

# 6. Add versions to the secrets
resource "google_secret_manager_secret_version" "db_name_version" {
  secret      = google_secret_manager_secret.db_name_secret.id
  secret_data = google_sql_database.app_db.name
}

resource "google_secret_manager_secret_version" "db_user_version" {
  secret      = google_secret_manager_secret.db_user_secret.id
  secret_data = google_sql_user.db_user.name
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = random_password.db_user_password.result
}
