
##### HTTPS #####
locals {
  address_id = var.address_id[var.lb7_int.address_name]
}

resource "google_compute_forwarding_rule" "forwarding_rule_https" {
  count                 = lookup(var.lb7_int, "https", {}) != {} ? 1 : 0
  name                  = var.lb7_int.https.forwarding_rule_name
  project               = var.lb7_int.project
  region                = var.lb7_int.region
  ip_protocol           = var.lb7_int.ip_protocol
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.lb7_int.https.port_range
  target                = google_compute_region_target_https_proxy.https_proxy[0].id
  network               = var.lb7_int.network
  subnetwork            = var.lb7_int.subnetwork
  ip_address            = local.address_id
  network_tier          = "PREMIUM"
}

resource "google_compute_region_target_https_proxy" "https_proxy" {
  count            = lookup(var.lb7_int, "https", {}) != {} ? 1 : 0
  region           = var.lb7_int.region
  name             = var.lb7_int.https.proxy_name
  project          = var.lb7_int.project
  url_map          = google_compute_region_url_map.url_map.id
  ssl_certificates = [for i in var.lb7_int.ssl : var.ssl_certificates[i]]
}


##### HTTP #####

resource "google_compute_forwarding_rule" "forwarding_rule_http" {
  count                 = lookup(var.lb7_int, "http", {}) != {} ? 1 : 0
  name                  = var.lb7_int.http.forwarding_rule_name
  project               = var.lb7_int.project
  region                = var.lb7_int.region
  ip_protocol           = var.lb7_int.ip_protocol
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.lb7_int.http.port_range
  target                = google_compute_region_target_http_proxy.http_proxy[0].id
  network               = var.lb7_int.network
  subnetwork            = var.lb7_int.subnetwork
  ip_address            = local.address_id
  network_tier          = "PREMIUM"
}

resource "google_compute_region_target_http_proxy" "http_proxy" {
  count   = lookup(var.lb7_int, "http", {}) != {} ? 1 : 0
  region  = var.lb7_int.region
  name    = var.lb7_int.http.proxy_name
  project = var.lb7_int.project
  url_map = google_compute_region_url_map.url_map.id
}



#### URL MAP

resource "google_compute_region_url_map" "url_map" {
  region          = var.lb7_int.region
  project         = var.lb7_int.project
  name            = var.lb7_int.url_map_name
  description     = ""
  default_service = module.backend[var.lb7_int.default_backend].bakends.id

  dynamic "host_rule" {
    for_each = { for i in var.lb7_int.host_rule : i.name => i }
    content {
      hosts        = host_rule.value.host
      path_matcher = host_rule.value.name
    }
  }

  dynamic "path_matcher" {
    for_each = { for i in var.lb7_int.host_rule : i.name => i }
    content {
      name            = path_matcher.value.name
      default_service = module.backend[path_matcher.value.name].bakends.id
    }
  }
  depends_on = [
    module.backend
  ]
}

module "backend" {
  for_each = { for i in var.lb7_int.backends : i.name => i }
  source   = "./backends_service"
  backend_service = {
    project                         = var.lb7_int.project
    name                            = each.value.name
    region                          = var.lb7_int.region
    protocol                        = each.value.protocol
    load_balancing_scheme           = "INTERNAL_MANAGED"
    health_checks                   = [var.health_check[lookup(each.value, "health_check_name", var.lb7_int.health_check_name)]]
    port_name                       = each.value.port_name
    locality_lb_policy              = var.lb7_int.locality_lb_policy
    timeout_sec                     = lookup(each.value, "timeout_sec", lookup(var.lb7_int, "backend_timeout_sec", 30))
    connection_draining_timeout_sec = lookup(each.value, "connection_draining_timeout_sec", 0)
    backend = {
      group           = var.umig[each.value.umig]
      balancing_mode  = var.lb7_int.balancing_mode
      max_rate        = var.lb7_int.max_rate
      capacity_scaler = var.lb7_int.capacity_scaler
    }
  }
}


