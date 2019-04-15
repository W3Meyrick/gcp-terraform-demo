provider "google-beta" {
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
  credentials = "${var.terraform_service_account}"
}

terraform {
  backend "gcs" {
    project     = "${var.gcp_project}"
    bucket      = "${var.gcp_state_bucket}"
    prefix      = "state"
    credentials = "${var.terraform_service_account}"
  }
}
