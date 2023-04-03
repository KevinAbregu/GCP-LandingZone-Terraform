locals {
  outputs_tcp          = var.health_check.type == "tcp" && var.health_check.global == false ? google_compute_region_health_check.health_check_tcp[0].self_link : ""
  outputs_http         = var.health_check.type == "http" && var.health_check.global == false ? google_compute_region_health_check.health_check_http[0].self_link : ""
  outputs_https        = var.health_check.type == "https" && var.health_check.global == false ? google_compute_region_health_check.health_check_https[0].self_link : ""
  outputs_https_global = var.health_check.type == "https" && var.health_check.global == true ? google_compute_health_check.health_check_https_global[0].self_link : ""
  outputs_http_global  = var.health_check.type == "http" && var.health_check.global == true ? google_compute_health_check.health_check_http_global[0].self_link : ""
  outputs_tcp_global          = var.health_check.type == "tcp" && var.health_check.global == true ? google_compute_health_check.health_check_tcp_global[0].self_link : ""

}


resource "google_compute_region_health_check" "health_check_tcp" {
  count   = var.health_check.type == "tcp" && var.health_check.global == false ? 1 : 0
  project = var.health_check.project
  name    = var.health_check.name
  region  = var.health_check.region
  tcp_health_check {
    port = var.health_check.port
  }
  log_config {
    enable = lookup(var.health_check, "log_enable", false)
  }
}

resource "google_compute_health_check" "health_check_tcp_global" {
  count   = var.health_check.type == "tcp" && var.health_check.global == true ? 1 : 0
  name               = var.health_check.name
  project            = var.health_check.project
  description = lookup(var.health_check, "description", "Managed by Terraform")
  check_interval_sec = lookup(var.health_check, "check_interval_sec", 5)
  tcp_health_check {
    port = var.health_check.port
  }
}

resource "google_compute_region_health_check" "health_check_http" {
  count              = var.health_check.type == "http" && var.health_check.global == false ? 1 : 0
  name               = var.health_check.name
  region             = var.health_check.region
  project            = var.health_check.project
  check_interval_sec = lookup(var.health_check, "check_interval_sec", 5)
  http_health_check {
    port_specification = lookup(var.health_check, "port_specification", null)
    port               = lookup(var.health_check, "port", null)
  }
}

resource "google_compute_region_health_check" "health_check_https" {
  count              = var.health_check.type == "https" && var.health_check.global == false ? 1 : 0
  name               = var.health_check.name
  region             = var.health_check.region
  project            = var.health_check.project
  check_interval_sec = lookup(var.health_check, "check_interval_sec", 5)
  https_health_check {
    port_specification = lookup(var.health_check, "port_specification", null)
    port               = lookup(var.health_check, "port", null)
  }
}

resource "google_compute_health_check" "health_check_https_global" {
  count              = var.health_check.type == "https" && var.health_check.global == true ? 1 : 0
  name               = var.health_check.name
  project            = var.health_check.project
  check_interval_sec = lookup(var.health_check, "check_interval_sec", 5)
  https_health_check {
    port_specification = lookup(var.health_check, "port_specification", null)
    port               = lookup(var.health_check, "port", null)
  }
}

resource "google_compute_health_check" "health_check_http_global" {
  count              = var.health_check.type == "http" && var.health_check.global == true ? 1 : 0
  name               = var.health_check.name
  project            = var.health_check.project
  check_interval_sec = lookup(var.health_check, "check_interval_sec", 5)
  https_health_check {
    port_specification = lookup(var.health_check, "port_specification", null)
    port               = lookup(var.health_check, "port", null)
  }
}
