locals {
  network_id    = var.network_id[var.lb4int.network]
  subnetwork_id = var.subnetwork_id[var.lb4int.subnetwork]
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  for_each              = { for i in var.lb4int.specific_forwarding_rules : i.name => i }
  project               = var.lb4int.project
  description           = lookup(each.value, "description", "Managed By Terraform")
  name                  = each.value.name
  region                = var.lb4int.region
  network               = local.network_id
  subnetwork            = local.subnetwork_id
  ip_address            = lookup(each.value, "ip_address", try(var.ips_id[lookup(each.value, "address_name", "")], ""))
  allow_global_access   = lookup(var.lb4int, "allow_global_access", false)
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend_service.id
  ip_protocol           = "TCP"
  all_ports             = lookup(var.lb4int, "all_ports", false)
  ports                 = lookup(var.lb4int, "ports", [])
  service_label         = lookup(each.value, "service_label", null)
}

resource "google_compute_region_backend_service" "backend_service" {
  project                         = var.lb4int.project
  name                            = var.lb4int.backend.name
  region                          = var.lb4int.region
  network                         = local.network_id
  protocol                        = "TCP"
  session_affinity                = "NONE"
  connection_draining_timeout_sec = lookup(var.lb4int.backend, "connection_draining_timeout_sec", 0)
  backend {
    group = var.migs[var.lb4int.backend.group]
  }
  # Can be (health_checks_tcp,health_checks_http)
  health_checks = [var.health_checks[var.lb4int.health_check.name]]
}



