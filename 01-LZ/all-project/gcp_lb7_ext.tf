module "lb7_ext" {
  source           = "./module/lb7_ext"
  for_each         = local.combine_lb7_ext
  xlb7             = each.value
  ips              = local.dependence_ips
  ssl_certificates = local.dependence_ssl
  health_checks    = local.dependence_hc
  umig             = local.dependence_umig
  depends_on = [
    module.projects,
    module.umigs,
    module.health_check,
    module.address
  ]
}
