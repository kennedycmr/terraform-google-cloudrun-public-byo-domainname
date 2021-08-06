# Create Backend Service - Frontend
resource "google_compute_backend_service" "prd" {
  name        = local.BACKEND_NAME
  project     = data.google_project.primary.number
  protocol    = "HTTPS"
  port_name   = "http"
  timeout_sec = 30
  log_config {
    enable      = true
    sample_rate = 1
  }
  #security_policy       = google_compute_security_policy.canary-dev_sec_policy.self_link
  load_balancing_scheme = "EXTERNAL"
  backend {
    group = google_compute_region_network_endpoint_group.prd.self_link
  }
}
