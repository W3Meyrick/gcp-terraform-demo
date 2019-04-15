provider "google-beta" {
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
  credentials = "${var.terraform_service_account}"
}

terraform {
  backend "gcs" {
    project     = "rs-tf-sandbox"
    bucket      = "w3-terraform-state"
    prefix      = "tf-state/state"
    credentials = "/opt/terraform/key.json"
  }
}
