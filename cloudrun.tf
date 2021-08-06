#Deploy Cloud Run Revision
resource "google_cloud_run_service" "prd" {
  name                       = var.CLOUDRUN_NAME
  project                    = data.google_project.primary.project_id
  location                   = var.GCP_DEPLOYMENT_REGION
  autogenerate_revision_name = true
  template {
    spec {
      service_account_name = var.CLOUDRUN_SA_EMAIL
      containers {
        image = var.CLOUDRUN_PRD_CONTAINER
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "prd" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "prd" {
  location    = google_cloud_run_service.prd.location
  project     = google_cloud_run_service.prd.project
  service     = google_cloud_run_service.prd.name
  policy_data = data.google_iam_policy.prd.policy_data
}




