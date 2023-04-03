module "subnets" {
  source           = "terraform-google-modules/network/google//modules/subnets"
  for_each         = var.subnet
  project_id       = each.value.project_vpc
  network_name     = each.value.network_name_vpc
  subnets          = each.value.subnet_info
  secondary_ranges = lookup(each.value, "secondary_ranges", {})
}
