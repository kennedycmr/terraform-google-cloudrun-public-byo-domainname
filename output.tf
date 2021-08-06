output "cloudrun_id" {
  description = "Id of the Cloud Run deployment"
  value = google_cloud_run_service.prd.id
}

output "public_ip" {
  description = "Public IP Address of the Cloud Run deployment."
  value = google_compute_global_address.public_ip.address
}
