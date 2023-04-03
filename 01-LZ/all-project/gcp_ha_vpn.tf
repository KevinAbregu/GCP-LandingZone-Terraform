module "ha_vpn" {
  source   = "./module/ha-vpn"
  for_each = local.combine_ha_vpn
  ha_vpn   = each.value
  depends_on = [
    module.projects,
    module.vpc
  ]
}
