module "lb7_int" {
  source           = "./module/lb7_int"
  for_each         = local.combine_lb7_int
  lb7_int          = each.value
  ssl_certificates = local.dependence_ssl
  address_id       = local.dependence_ips
  health_check     = local.dependence_hc
  umig             = local.dependence_umig
  depends_on = [
    module.projects,
    module.health_check,
    module.address,
    module.umigs,
    module.ssl
  ]
}
