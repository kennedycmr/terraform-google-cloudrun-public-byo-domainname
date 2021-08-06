# Create HTTP URL Map
resource "google_compute_url_map" "http" {
  name    = local.HTTP_URLMAP_NAME
  project = data.google_project.primary.number
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

# Create HTTP Target Proxy
resource "google_compute_target_http_proxy" "http" {
  name    = local.HTTP_PROXY_NAME
  project = data.google_project.primary.number
  url_map = google_compute_url_map.http.self_link
}

# HTTP forwarding rule
resource "google_compute_global_forwarding_rule" "http" {
  name                  = local.HTTP_FWD_RULE_NAME
  project               = data.google_project.primary.number
  target                = google_compute_target_http_proxy.http.self_link
  port_range            = "80"
  ip_address            = google_compute_global_address.public_ip.address
  load_balancing_scheme = "EXTERNAL"
}



# Create HTTPS URL Map
resource "google_compute_url_map" "https" {
  name            = local.HTTPS_URLMAP_NAME
  project         = data.google_project.primary.number
  default_service = google_compute_backend_service.prd.self_link

  host_rule {
    hosts        = [var.DOMAIN_NAME]
    path_matcher = replace(var.DOMAIN_NAME, ".", "-")
  }

  path_matcher {
    name            = replace(var.DOMAIN_NAME, ".", "-")
    default_service = google_compute_backend_service.prd.self_link
  }
}

# Create HTTPS Target Proxy
resource "google_compute_target_https_proxy" "https" {
  name       = local.HTTPS_PROXY_NAME
  project    = data.google_project.primary.number
  url_map    = google_compute_url_map.https.self_link
  ssl_policy = google_compute_ssl_policy.primary.self_link

  ssl_certificates = [
    google_compute_managed_ssl_certificate.ssl.self_link
  ]
}

# HTTPS forwarding rule
resource "google_compute_global_forwarding_rule" "https" {
  name                  = local.HTTPS_FWD_RULE_NAME
  project               = data.google_project.primary.number
  target                = google_compute_target_https_proxy.https.self_link
  port_range            = "443"
  ip_address            = google_compute_global_address.public_ip.address
  load_balancing_scheme = "EXTERNAL"
}