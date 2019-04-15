#******************************************************************************
# Variable Values
#******************************************************************************

# GCP Specifics
gcp_project             = "hsbc-6320774-sharedsvcs2-dev" 
gcp_region              = "europe-west1" 
gcp_zone                = "europe-west1-b" 
gcp_state_bucket        = "logstash-terraform"

# Authentication
terraform_service_account = "/opt/terraform/google/account.json"

# Network
vpc_host_project         = "hsbc-6320774-vpchost-dev"
primary_vpc              = "hsbc-6320774-vpchost-dev-vpc1-europe-west1"
healthcheck_name         = "gce-healthcheck-logstash-siem-dev"
backendservice_name      = "gce-backendservice-logstash-siem-dev"
forwardingrule_name      = "gce-forwardingrule-logstash-siem-dev"

# Instance Template
instancegroup_name            = "gce-instance-logstash-siem-dev"
instancetemplate_name         = "gce-instancetemplate-logstash-siem-dev"             
instancetemplate_description  = "This template is used to build the Logstash SIEM instance"
source_image                  = "gce-imagefamily-type3-rhel7-stage3-logstash"
service_account               = "jenkins-build-server@hsbc-6320774-sharedsvcs2-dev.iam.gserviceaccount.com"
label_environment             = "dev"
label_role                    = "logstash"
instance_tags                 = [
    "fwtag-6320774-dev-all-in-mcafee",
    "fwtag-6320774-dev-all-out-mcafee",
    "fwtag-all-dev-in-alm-github",
    "fwtag-all-dev-out-alm-github",
    "fwtag-all-dev-out-efx-nexus-3-production",
    "t-6320774-dev-in-all-jenkinsmaster-ssh",
    "t-6320774-dev-out-all-jenkinsmaster-ssh",
    "t-all-dev-in-drn-jumpservers",
    "t-all-dev-in-unrestricted-api-forwarders"
]