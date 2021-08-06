# Create SSL Policy
resource "google_compute_ssl_policy" "primary" {
  name            = local.SSL_CERT_NAME
  project         = data.google_project.primary.number
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
  lifecycle {
    create_before_destroy = true
  }
}

# Create SSL Certificate (Google managed)
resource "google_compute_managed_ssl_certificate" "ssl" {
  name    = local.SSL_CERT_NAME
  project = data.google_project.primary.number
  managed {
    domains = [var.DOMAIN_NAME]
  }
  lifecycle {
    create_before_destroy = true
  }
}

