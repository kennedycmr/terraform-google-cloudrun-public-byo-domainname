# Create Serverless (Cloud Run) NEG
resource "google_compute_region_network_endpoint_group" "prd" {
  name                  = local.NEG_NAME
  network_endpoint_type = "SERVERLESS"
  region                = var.GCP_DEPLOYMENT_REGION
  project               = data.google_project.primary.number
  cloud_run {
    service = google_cloud_run_service.prd.name
  }
  lifecycle {
    create_before_destroy = true
  }
}

