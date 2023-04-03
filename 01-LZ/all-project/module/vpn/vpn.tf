locals {
  # Dependences
  network    = "projects/${var.vpn.project}/global/networks/${var.vpn.network}"
  ip_address = "projects/${var.vpn.project}/regions/${var.vpn.region}/addresses/${var.vpn.name_address}"
}

# VPN Gateways
resource "google_compute_vpn_gateway" "vpn_gateway" {
  name    = var.vpn.name
  network = local.network
  region  = var.vpn.region
  project = var.vpn.project
}


resource "google_compute_forwarding_rule" "vpn_esp" {
  name        = "${google_compute_vpn_gateway.vpn_gateway.name}-esp"
  ip_protocol = "ESP"
  ip_address  = local.ip_address
  target      = google_compute_vpn_gateway.vpn_gateway.self_link
  project     = var.vpn.project
  region      = var.vpn.region
}

resource "google_compute_forwarding_rule" "vpn_udp500" {
  name        = "${google_compute_vpn_gateway.vpn_gateway.name}-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = local.ip_address
  target      = google_compute_vpn_gateway.vpn_gateway.self_link
  project     = var.vpn.project
  region      = var.vpn.region
}

resource "google_compute_forwarding_rule" "vpn_udp4500" {
  name        = "${google_compute_vpn_gateway.vpn_gateway.name}-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = local.ip_address
  target      = google_compute_vpn_gateway.vpn_gateway.self_link
  project     = var.vpn.project
  region      = var.vpn.region
}

module "tunnel" {
  source   = "./tunnel"
  for_each = var.vpn.tunnel
  tunnel   = each.value
  gateway  = google_compute_vpn_gateway.vpn_gateway.self_link
  region   = var.vpn.region
  project  = var.vpn.project
  network  = local.network
  depends_on = [
    google_compute_forwarding_rule.vpn_esp,
    google_compute_forwarding_rule.vpn_udp500,
    google_compute_forwarding_rule.vpn_udp4500,
    google_compute_vpn_gateway.vpn_gateway
  ]
}
