
locals {
  ip_address = var.ips_id[var.lb4ext.address_name]
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  project               = var.lb4ext.project
  description           = var.lb4ext.description
  name                  = var.lb4ext.name
  region                = var.lb4ext.region
  ip_address            = local.ip_address
  allow_global_access   = lookup(var.lb4ext, "allow_global_access", false)
  load_balancing_scheme = "EXTERNAL"
  backend_service       = google_compute_region_backend_service.backend_service.self_link
  ip_protocol           = "TCP"
  all_ports             = lookup(var.lb4ext, "all_ports", false)
  ports                 = lookup(var.lb4ext, "ports", [])
}

resource "google_compute_region_backend_service" "backend_service" {
  project                         = var.lb4ext.project
  name                            = var.lb4ext.backend.name
  region                          = var.lb4ext.region
  connection_draining_timeout_sec = lookup(var.lb4ext.backend, "connection_draining_timeout_sec", 0)
  load_balancing_scheme           = "EXTERNAL"
  protocol                        = "TCP"
  session_affinity                = "NONE"
  backend {
    group = var.migs[var.lb4ext.backend.group]
  }

  health_checks = [var.health_checks[var.lb4ext.health_check.name]]
}



