
# vip-homebanking-qa-pam
resource "google_compute_region_backend_service" "backend_service" {
  project                         = var.backend_service.project
  name                            = var.backend_service.name
  region                          = var.backend_service.region
  protocol                        = var.backend_service.protocol
  load_balancing_scheme           = "INTERNAL_MANAGED"
  health_checks                   = var.backend_service.health_checks
  port_name                       = var.backend_service.port_name
  locality_lb_policy              = var.backend_service.locality_lb_policy
  timeout_sec                     = var.backend_service.timeout_sec
  connection_draining_timeout_sec = var.backend_service.connection_draining_timeout_sec
  backend {
    group           = var.backend_service.backend.group
    balancing_mode  = var.backend_service.backend.balancing_mode
    max_rate        = var.backend_service.backend.max_rate
    capacity_scaler = var.backend_service.backend.capacity_scaler
  }
}
