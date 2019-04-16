# resource "google_compute_region_backend_service" "primary-be" {
#   provider = "google-beta"
#   name     = "${var.backendservice_name}"
#   project  = "${var.gcp_project}"
#   region   = "${var.gcp_region}"
#   protocol = "TCP"
# 
#   backend {
#     group = "${google_compute_region_instance_group_manager.primary-igm.instance_group}"
#   }
# 
#   health_checks = ["${google_compute_health_check.primary-hc.self_link}"]
# }
# 
# resource "google_compute_forwarding_rule" "primary-forwarding-rule" {
#   provider              = "google-beta"
#   name                  = "${var.forwardingrule_name}"
#   region                = "${var.gcp_region}"
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "INTERNAL"
#   backend_service       = "${google_compute_region_backend_service.primary-be.self_link}"
#   ports                 = ["443"]
# }
