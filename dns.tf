module "dns-public-zone" {
  #ref: https://registry.terraform.io/modules/terraform-google-modules/cloud-dns/google/latest
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "3.1.0"
  project_id = data.google_project.primary.number
  type       = "public"
  name       = replace(var.DOMAIN_NAME, ".", "-")
  domain     = "${var.DOMAIN_NAME}."

  recordsets = [
    {
      name = var.DOMAIN_NAME
      type = "A"
      ttl  = 300
      records = [
        google_compute_global_address.public_ip.address,
      ]
    },
    {
      name = "www"
      type = "A"
      ttl  = 300
      records = [
        google_compute_global_address.public_ip.address,
      ]
    }
  ]
}
