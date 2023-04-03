module "vpc" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "~> 5.1"
  project_id                             = var.vpc.project_vpc
  network_name                           = var.vpc.network_name_vpc
  description                            = lookup(var.vpc, "description", "Manage by Terraform")
  routing_mode                           = lookup(var.vpc, "routing_mode", "GLOBAL")
  shared_vpc_host                        = lookup(var.vpc, "shared_vpc_host", false)
  delete_default_internet_gateway_routes = lookup(var.vpc, "del_def_int", true)
  auto_create_subnetworks                = lookup(var.vpc, "auto_create_subnetworks", false)
  mtu                                    = lookup(var.vpc, "mtu", 0)
  # Module especifico
  subnets          = []
  secondary_ranges = {}
  routes           = []
  firewall_rules   = []

}
