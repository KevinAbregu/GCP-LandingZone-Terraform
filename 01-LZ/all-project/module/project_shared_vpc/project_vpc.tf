locals {
  subnetwork_ids = contains(keys(var.project_shared_vpc), "subnetworks") ? [for i in var.project_shared_vpc.subnetworks: var.subnetwork_id[i]] : []
}


resource "google_compute_shared_vpc_service_project" "shared_vpc_attachment" {
  provider = google-beta
  host_project    = var.project_shared_vpc.shared_vpc
  service_project = var.project_shared_vpc.project_id
}


module "shared_vpc_access" {
  count        = contains(keys(var.project_shared_vpc), "subnetworks") ? 1 : 0
  source              = "terraform-google-modules/project-factory/google//modules/shared_vpc_access"
  version                 = "~> 13.0"
  host_project_id     = var.project_shared_vpc.shared_vpc
  service_project_id  = var.project_shared_vpc.project_id
  enable_shared_vpc_service_project = true
  shared_vpc_subnets    = local.subnetwork_ids
}