locals {
  description = lookup(var.address,"description","Manage by Terraform")
}


resource "google_compute_address" "address_ext" {
    count        = var.address.address_type == "EXTERNAL" && !lookup(var.address,"global",false) ? 1 : 0
    name         = var.address.name_address
    description  = local.description
    project      = var.address.project
    address_type = "EXTERNAL"
    region       = var.address.region
    prefix_length = 0
}

resource "google_compute_address" "address_int" {
    count        = var.address.address_type == "INTERNAL" && !lookup(var.address,"global",false) ? 1 : 0
    name         = var.address.name_address
    project      = var.address.project
    description  = local.description
    subnetwork   = lookup(var.subnets_id,var.address.name_subnetwork,"")
    address_type = "INTERNAL"
    address      = var.address.ip_address
    region       = var.address.region
    purpose      = lookup(var.address,"purpose","")  
    prefix_length = 0
}

resource "google_compute_global_address" "address_ext" {
    count        = var.address.address_type == "EXTERNAL" && lookup(var.address,"global",false) ? 1 : 0
    name         = var.address.name_address
    project      = var.address.project
    description  = local.description
    address_type = "EXTERNAL"
    prefix_length = 0
}