locals {
  router = "projects/${var.interconnect.project}/regions/${var.interconnect.region}/routers/${var.interconnect.name_router}"

}

resource "google_compute_interconnect_attachment" "interconnect" {
    name                    = var.interconnect.vlan_1.name
    project                 = var.interconnect.project
    region                  = var.interconnect.region
    type                    = var.interconnect.type
    router                  = local.router
}

resource "google_compute_interconnect_attachment" "interconnect_2" {
    name                    = var.interconnect.vlan_2.name
    project                 = var.interconnect.project
    region                  = var.interconnect.region
    type                    = var.interconnect.type
    router                  = local.router
}