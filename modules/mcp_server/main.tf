# Configure the Google Cloud provider
provider "google" {
  project               = var.project
  user_project_override = true
}

provider "google-beta" {
  project               = var.project
  user_project_override = true
}

resource "google_cloud_run_v2_service" "mcp_server" {
  provider            = google-beta
  name                = "${var.mcp_service_name}"
  location            = var.location
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"
  launch_stage        = "GA"

  template {
    service_account = var.mcp_server_sa_email
    containers {
      image = "gcr.io/${var.project}/${var.mcp_image_name}:${var.mcp_image_version}"
      resources {
        limits = {
          "cpu"    = "1"
          "memory" = "512Mi"
        }
        startup_cpu_boost = true
      }
    }
    scaling {
      min_instance_count = 1
      max_instance_count = 10
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "agents_invoker_role_binding" {
  location = google_cloud_run_v2_service.mcp_server.location
  name     = google_cloud_run_v2_service.mcp_server.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.agents_sa_email}"
}
