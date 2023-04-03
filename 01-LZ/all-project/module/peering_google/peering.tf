module "peering" {
  source                     = "terraform-google-modules/network/google//modules/network-peering"
  for_each                   = var.peering
  local_network              = var.vpc_id[each.value.local_network_peering]
  peer_network               = var.vpc_id[each.value.peer_network_peering]
  export_local_custom_routes = each.value.export_local_custom_routes
}
