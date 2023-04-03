module "interconnect" {
  source       = "./module/interconnect"
  for_each     = local.combine_interconnect
  interconnect = each.value
  depends_on = [
    module.projects,
    module.vpc,
    module.ha_vpn
  ]
}
