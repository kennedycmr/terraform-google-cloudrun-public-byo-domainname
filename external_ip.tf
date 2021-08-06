## Reserve IP address for the Load balancer
# This IP needs to be registered in your DNS provider which can take hours to propergate when created/changed.
# Warning renaming this resource will generate a new IP and DNS would need to be updated
resource "google_compute_global_address" "public_ip" {
  name        = local.PUBLIC_IP_NAME
  project     = data.google_project.primary.number
  description = local.PUBLIC_IP_DESC
}

