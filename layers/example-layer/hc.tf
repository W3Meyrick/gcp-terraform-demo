resource "google_compute_health_check" "primary-hc" {
  provider            = "google-beta"
  name                = "${var.healthcheck_name}"
  project             = "${var.gcp_project}"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/"
    port         = 80
  }
}
