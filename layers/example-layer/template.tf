resource "google_compute_instance_template" "primary-instance-template" {
  #  provider    = "google-beta"
  name        = "${var.instancetemplate_name}"
  description = "${var.instancetemplate_description}"
  project     = "${var.gcp_project}"

  tags = ["${var.instance_tags}"]

  labels = {
    environment = "${var.label_environment}"
    role        = "${var.label_role}"
  }

  machine_type = "g1-small"

  network_interface {
    network = "default"

    access_config {
      # The presence of this property assigns a public IP address to each Compute Instance. It is intentionally left
      # blank so that an external IP address is selected automatically.
      nat_ip = ""
    }
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
