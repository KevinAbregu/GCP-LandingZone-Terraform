module "lb4_int" {
  source        = "./module/lb4int"
  for_each      = local.combine_lb4_internal
  lb4int        = each.value
  migs          = local.dependence_umig
  health_checks = local.dependence_hc
  subnetwork_id = local.dependence_subnet
  network_id    = local.dependence_vpc
  ips_id        = local.dependence_ips_cidr
  depends_on = [
    module.umigs,
    module.health_check,
    module.subnets,
    module.vpc,
  module.address]
}
