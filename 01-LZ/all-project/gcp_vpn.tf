module "vpns" {
  source   = "./module/vpn"
  for_each = local.combine_vpn
  vpn      = each.value
  depends_on = [
    module.projects,
    module.vpc,
    module.address
  ]
}
