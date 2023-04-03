module "lb4_ext" {
  source        = "./module/lb4ext"
  for_each      = local.combine_lb4_external
  lb4ext        = each.value
  migs          = local.dependence_umig
  health_checks = local.dependence_hc
  ips_id        = local.dependence_ips
  depends_on = [
    module.projects,
    module.umigs,
    module.health_check,
  module.address]
}
