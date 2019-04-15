#******************************************************************************
# Variable Definitions
#******************************************************************************

# GCP Specifics
variable "gcp_project" {}

variable "gcp_region" {}
variable "gcp_zone" {}
variable "gcp_state_bucket" {}

# Authentication
variable "terraform_service_account" {}

# Network
variable "vpc_host_project" {}

variable "primary_vpc" {}
variable "healthcheck_name" {}
variable "backendservice_name" {}
variable "forwardingrule_name" {}

# Instance template
variable "instancegroup_name" {}
variable "instancetemplate_name" {}
variable "instancetemplate_description" {}
variable "source_image" {}
variable "service_account" {}
variable "label_environment" {}
variable "label_role" {}

variable "instance_tags" {
  description = "A list of tags that will be added to the Compute Instance Template in addition to the tags automatically added by this module."
  type        = "list"
  default     = []
}
