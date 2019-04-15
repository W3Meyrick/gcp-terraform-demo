resource "google_compute_instance_template" "primary-instance-template" {
  provider    = "google-beta"
  name        = "${var.instancetemplate_name}"
  description = "${var.instancetemplate_description}"
  project     = "${var.gcp_project}"

  tags = ["${var.instance_tags}"]

  labels = {
    environment = "${var.label_environment}"
    role        = "${var.label_role}"
  }

  machine_type = "n1-standard-1"

  network_interface {
    network = "default"
  }

  disk {
    source_image = "${var.source_image}"
    auto_delete  = true
    boot         = true
  }

  service_account {
    email  = "${var.service_account}"
    scopes = ["cloud-platform"]
  }
}
