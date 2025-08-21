# Configure the Google Cloud provider
provider "google" {
  project               = var.project
  user_project_override = true
}

provider "google-beta" {
  project               = var.project
  user_project_override = true
}

resource "google_cloud_run_v2_service" "apigee_agents" {
  provider            = google-beta
  name                = var.agents_service_name
  location            = var.location
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"
  launch_stage        = "BETA"
  iap_enabled         = true

  template {
    service_account = var.agents_sa_email
    containers {
      image = "gcr.io/${var.project}/${var.agents_service_name}:latest"
      resources {
        limits = {
          "cpu"    = "1"
          "memory" = "512Mi"
        }
        startup_cpu_boost = true
      }
      env {
        name  = "DB_INSTANCE_CONNECTION_NAME"
        value = var.db_connection_name
      }
      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project
      }
      env {
        name  = "GOOGLE_CLOUD_LOCATION"
        value = "global"
      }
      env {
        name  = "GOOGLE_GENAI_USE_VERTEXAI"
        value = "true"
      }
      env {
        name  = "SERVE_WEB_INTERFACE"
        value = "true"
      }
      env {
        name  = "DATASTORE_ID"
        value = var.datastore_id
      }
      env {
        name  = "MCP_SERVER_URL"
        value = var.mcp_server_url
      }
      env {
        name = "DB_NAME"
        value_source {
          secret_key_ref {
            secret  = var.db_name_secret_id
            version = "latest"
          }
        }
      }
      env {
        name = "DB_USER"
        value_source {
          secret_key_ref {
            secret  = var.db_user_secret_id
            version = "latest"
          }
        }
      }
      env {
        name = "DB_PASS"
        value_source {
          secret_key_ref {
            secret  = var.db_password_secret_id
            version = "latest"
          }
        }
      }
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
    scaling {
      min_instance_count = 1
      max_instance_count = 10
    }
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.db_connection_name]
      }
    }
  }
}

data "google_iam_policy" "agent_accessors" {
  binding {
    role    = "roles/iap.httpsResourceAccessor"
    members = var.agent_accessors
  }
}

resource "google_iap_web_cloud_run_service_iam_policy" "agents_iap_policy" {
  project                = google_cloud_run_v2_service.apigee_agents.project
  location               = google_cloud_run_v2_service.apigee_agents.location
  cloud_run_service_name = google_cloud_run_v2_service.apigee_agents.name
  policy_data            = data.google_iam_policy.agent_accessors.policy_data
}

resource "google_project_service_identity" "iap_sa" {
  provider = google-beta
  project  = var.project
  service  = "iap.googleapis.com"
}

resource "google_cloud_run_v2_service_iam_member" "invoker_role_binding" {
  location = google_cloud_run_v2_service.apigee_agents.location
  name     = google_cloud_run_v2_service.apigee_agents.name
  role     = "roles/run.invoker"
  member   = google_project_service_identity.iap_sa.member
}
