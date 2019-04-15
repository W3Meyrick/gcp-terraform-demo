#******************************************************************************
# Variable Values
#******************************************************************************

# GCP Specifics
gcp_project             = "rs-tf-sandbox" 
gcp_region              = "europe-west1" 
gcp_zone                = "europe-west1-b" 
gcp_state_bucket        = "w3-terraform-state"

# Authentication Details
terraform_service_account = "/opt/terraform/key.json"

# Network
healthcheck_name         = "gce-healthcheck-example-usecase-dev"
backendservice_name      = "gce-backendservice-example-usecase-dev"
forwardingrule_name      = "gce-forwardingrule-example-usecase-dev"

# Instance Template
instancegroup_name            = "gce-instance-example-usecase-dev"
instancetemplate_name         = "gce-instancetemplate-example-usecase-dev"             
instancetemplate_description  = "This template is used to build the example usecase instance"
source_image                  = "gce-image-demo-centos7"
service_account               = "terraform@rs-tf-sandbox.iam.gserviceaccount.com"
label_environment             = "dev"
label_role                    = "example"
instance_tags                 = [
    "http-server",
    "https-server"
]