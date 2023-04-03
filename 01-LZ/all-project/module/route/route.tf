

locals {
  network = "projects/${var.route.project}/global/networks/${var.route.network}"
}
# data "google_compute_network" "network" {
#   name = var.route.network
#   project = var.route.project
# }

# data "google_compute_forwarding_rule" "fw" {
#   count  = var.route.type == "ilb" ? 1 : 0
#   name = var.route.value
#   project = var.route.project
#   region = var.route.region
# }



resource "google_compute_route" "route-ilb" {
  count        = var.route.type == "ilb" ? 1 : 0
  name         = var.route.name
  project      = var.route.project
  dest_range   = var.route.dest_range
  network      = local.network
  next_hop_ilb = "projects/${var.route.project}/regions/${var.route.region}/forwardingRules/${var.route.value}"
  priority     = var.route.priority
}


resource "google_compute_route" "route-gateway" {
  count            = var.route.type == "gateway" ? 1 : 0
  name             = var.route.name
  project          = var.route.project
  dest_range       = var.route.dest_range
  network          = local.network
  next_hop_gateway = "projects/${var.route.project}/global/gateways/default-internet-gateway"
  priority         = var.route.priority
}
