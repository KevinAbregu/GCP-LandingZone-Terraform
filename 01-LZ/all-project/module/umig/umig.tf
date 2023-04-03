################################ UMIG #################################
locals {
  name      = google_compute_instance_group.umig.name
  self_link = google_compute_instance_group.umig.self_link
  instance = "https://www.googleapis.com/compute/v1/projects/${var.umig.project_id}/zones/${var.umig.zone}/instances/"
}


resource "google_compute_instance_group" "umig" {
  name        = var.umig.name
  description = var.umig.description
  zone        = var.umig.zone
  # instances = [for v in var.umig.instances: "${local.instance}${v}"]
  instances   = [for v in var.umig.instances : try(var.instances[v], "${local.instance}${v}")]
  project     = var.umig.project_id
  network     = lookup(var.umig, "network", "")
  dynamic "named_port" {
    for_each = { for l in var.umig.named_port : l.name => l }
    content {
      name = named_port.value["name"]
      port = named_port.value["port"]
    }
  }
}