output "cloudrun_id" {
  description = "Id of the Cloud Run deployment"
  value       = google_cloud_run_service.prd.id
}

output "public_ip" {
  description = "Public IP Address of the Cloud Run deployment."
  value       = google_compute_global_address.public_ip.address
}

output "name_servers" {
  description = "Dns Name servers your domain should be pointing to."
  value = module.dns-public-zone.name_servers
}

output "domain" {
  description = "Domain name created"
  value = module.dns-public-zone.domain
}

