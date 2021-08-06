output "ssl_self_link" {
  value = google_compute_managed_ssl_certificate.ssl.self_link
}

output "cloudrun_name" {
  value = google_cloud_run_service.prd.name
}

output "public_ip" {
  value = google_compute_global_address.public_ip.address
}

output "ssl_policy" {
  value = google_compute_ssl_policy.primary.self_link
}

