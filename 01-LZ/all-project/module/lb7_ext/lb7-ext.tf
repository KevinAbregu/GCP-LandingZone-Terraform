

locals {
  address = var.ips[var.xlb7.address.address_name]
}

##### HTTPS #####
resource "google_compute_global_forwarding_rule" "forwarding_rule_https" {
  count                 = lookup(var.xlb7, "https", {}) != {} ? 1 : 0
  name                  = var.xlb7.https.forwarding_rule_name
  project               = var.xlb7.project
  load_balancing_scheme = "EXTERNAL"
  port_range            = var.xlb7.https.port_range
  target                = google_compute_target_https_proxy.https_proxy[0].id
  ip_address            = local.address
}

resource "google_compute_target_https_proxy" "https_proxy" {
  count            = lookup(var.xlb7, "https", {}) != {} ? 1 : 0
  name             = var.xlb7.https.proxy_name
  project          = var.xlb7.project
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [for i in var.xlb7.ssl : var.ssl_certificates[i]]
}

##### HTTP #####
resource "google_compute_global_forwarding_rule" "forwarding_rule_http" {
  count                 = lookup(var.xlb7, "http", {}) != {} ? 1 : 0
  name                  = var.xlb7.http.forwarding_rule_name
  project               = var.xlb7.project
  load_balancing_scheme = "EXTERNAL"
  port_range            = var.xlb7.http.port_range
  target                = google_compute_target_http_proxy.http_proxy[0].id
  ip_address            = local.address
}

resource "google_compute_target_http_proxy" "http_proxy" {
  count   = lookup(var.xlb7, "http", {}) != {} ? 1 : 0
  name    = var.xlb7.http.proxy_name
  project = var.xlb7.project
  url_map = google_compute_url_map.url_map.id
}

#### URL MAP

resource "google_compute_url_map" "url_map" {
  project         = var.xlb7.project
  name            = var.xlb7.url_map_name
  description     = ""
  default_service = google_compute_backend_service.backend_service[var.xlb7.default_backend].id

  dynamic "host_rule" {
    for_each = { for i in var.xlb7.host_rule : i.name => i }
    content {
      hosts        = host_rule.value.host
      path_matcher = host_rule.value.name
    }
  }

  dynamic "path_matcher" {
    for_each = { for i in var.xlb7.host_rule : i.name => i }
    content {
      name            = path_matcher.value.name
      default_service = google_compute_backend_service.backend_service[path_matcher.value.name].id
    }
  }
  depends_on = [
    google_compute_backend_service.backend_service
  ]
}



resource "google_compute_backend_service" "backend_service" {
  for_each                        = { for i in var.xlb7.backends : i.name => i }
  project                         = var.xlb7.project
  name                            = each.value.name
  protocol                        = each.value.protocol
  timeout_sec                     = lookup(each.value, "timeout_sec", lookup(var.xlb7, "timeout_sec", 30))
  load_balancing_scheme           = "EXTERNAL"
  health_checks                   = [var.health_checks[each.value.health_check]]
  port_name                       = each.value.port_name
  connection_draining_timeout_sec = lookup(each.value, "connection_draining_timeout_sec", 0)
  backend {
    group           = var.umig[each.value.umig]
    balancing_mode  = var.xlb7.balancing_mode
    max_rate        = var.xlb7.max_rate
    capacity_scaler = var.xlb7.capacity_scaler
  }
}


