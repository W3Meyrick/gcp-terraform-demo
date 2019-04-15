data "google_compute_subnetwork" "primary-vpc" {
  provider = "google-beta"
  name     = "${var.primary_vpc}"
  project  = "${var.gcp_project}"
  region   = "${var.gcp_region}"
}

data "google_compute_address" "static-internal-ip" {
  provider = "google-beta"
  name     = "jenkins-build-server-dev"
  project  = "${var.gcp_project}"
  region   = "${var.gcp_region}"
}
