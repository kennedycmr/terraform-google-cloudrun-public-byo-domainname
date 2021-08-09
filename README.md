# Cloud Run Publicly Accessible using Your Own Domain Name

This module will publish your existing gcr.io container to Cloud Run and make it accessible publicly.  
* It sets the IAM policy of the Cloud Run deployment to allow anonymous access. 
* It deploys a load balancer. 
* Access to the Cloud Run deployment is only allowed via the load balancer.
* Cloud Armor (WAF) is deployed for additonal protection.
* HTTP redirect to HTTPS is provisioned to ensure users are directed through SSL connection. 
* A new external IP address is created. 
* A cloud DNS zone is provisioned. 
* DNS records for both the host and www are created in the new DNS zone.


## Quick start

To use this module: 

1. In your main.tf include the following: 
```
module "website" {
  source = "<url to this git repo>"

  GCP_PROJECT_ID         = "gcpprojectid"
  GCP_DEPLOYMENT_REGION  = "us-east4"
  CLOUDRUN_SA_EMAIL      = "serviceaccount@gcpprojectid.iam.gserviceaccount.com"
  CLOUDRUN_PRD_CONTAINER = "gcr.io/gcpprojectid/deployment/revision_v1-1-2"
  CLOUDRUN_NAME          = "deployment-prd"
  DOMAIN_NAME            = "mydomain.xyz"
}
```
1. Run terraform validate and fix any issues that appear.    
1. Run terraform plan and confirm you are ok with what will be deployed.   
1. Run terraform apply to have the resources deployed.
1. Once the resources have been deployed, ensure your DNS provider is updated so your domain is redirected to the name servers of Cloud DNS. 
1. It can take several hours for both DNS to replicate, and the SSL certificate to propogate to the load balancers once it has been provisioned. 
1. Ensure you check the status of the SSL certificate to ensure it doesn't sit in a PROVISIONING state pending you verifying ownership of the DNS record.
