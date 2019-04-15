resource "google_compute_region_instance_group_manager" "primary-igm" {
  provider           = "google-beta"
  name               = "${var.instancegroup_name}"
  base_instance_name = "${var.instancegroup_name}"
  region             = "${var.gcp_region}"
  target_size        = 1

  version {
    name              = "main"
    instance_template = "${google_compute_instance_template.primary-instance-template.self_link}"
  }

  named_port {
    name = "https"
    port = 443
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.primary-hc.self_link}"
    initial_delay_sec = 60
  }
}
