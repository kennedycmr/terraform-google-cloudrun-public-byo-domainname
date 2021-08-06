### The below variables need to be passed in when calling this module.
variable "GCP_PROJECT_ID" {
  description = "GCP Project Id where all resources will be deployed to."
  type        = string
}

variable "GCP_DEPLOYMENT_REGION" {
  description = "GCP region where all resources will be provisioned in."
  type        = string
}

variable "CLOUDRUN_SA_EMAIL" {
  description = "Email address of the service account that Cloud Run deployment will run as."
  type        = string
}

variable "CLOUDRUN_PRD_CONTAINER" {
  description = "URL of the container image to be used as the Cloud Run deployment. E.g. gcr.io/gcpprojectid/deployment/revision_v1-1-2"
  type        = string
}

variable "DOMAIN_NAME" {
  description = "Domain name to host this Cloud Run as. You should already own the domain name and you will need to ensure the host records point to the IP address that will be provisioned here. E.g. mydomainname.xyz"
  type        = string
}

variable "CLOUDRUN_NAME" {
  description = "Name to call this Cloud Run deployment. Note many other resources are created using this as the prefix. See locals below for those variables."
  type        = string
}

### The below variables are created dynamically using the passed in variables as the seed.
locals {
  BACKEND_NAME        = var.CLOUDRUN_NAME
  HTTP_URLMAP_NAME    = "${var.CLOUDRUN_NAME}-http"
  HTTP_PROXY_NAME     = "${var.CLOUDRUN_NAME}-http"
  HTTP_FWD_RULE_NAME  = "${var.CLOUDRUN_NAME}-http"
  HTTPS_URLMAP_NAME   = "${var.CLOUDRUN_NAME}-https"
  HTTPS_PROXY_NAME    = "${var.CLOUDRUN_NAME}-https"
  HTTPS_FWD_RULE_NAME = "${var.CLOUDRUN_NAME}-https"
  NEG_NAME            = var.CLOUDRUN_NAME
  PUBLIC_IP_NAME      = "${var.CLOUDRUN_NAME}-public-ip"
  PUBLIC_IP_DESC      = "Publically accessible IP address provisioned for Cloud Run instance ${local.PUBLIC_IP_NAME}"
  SSL_CERT_NAME       = replace(var.DOMAIN_NAME, ".", "-")
}
