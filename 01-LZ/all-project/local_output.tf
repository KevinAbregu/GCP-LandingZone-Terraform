locals {
  output_address_ip     = { for k, v in module.address : k => flatten([v.address_ext, v.address_ext_global, v.address_int])[0].address }
  output_address        = { for k, v in module.address : k => flatten([v.address_ext, v.address_ext_global, v.address_int])[0].id }
  output_bucket         = module.bucket
  output_dns_policy     = module.dns_policy
  output_dns            = module.dns
  output_firewall_rules = module.firewall_rules
  output_folder         = module.folder
  output_folder_lon     = module.folder_lon
  output_ha_vpn         = module.ha_vpn
  output_health_check = { for k, v in module.health_check :
    k => join("",
      [v.health_checks_http,
        v.health_checks_https,
        v.health_checks_https_global,
        v.health_checks_http_global,
        v.health_checks_tcp_global,
  v.health_checks_tcp]) }
  output_interconnect = module.interconnect
  output_lb4_int      = module.lb4_int
  output_lb4_ext      = module.lb4_ext
  output_lb7_int      = module.lb7_int
  output_lb7_ext      = module.lb7_ext
  output_nat          = module.nat
  output_peering      = module.peering
  output_projects     = module.projects
  #  output_sa_id          = { for k, v in module.projects : v.project.service_account_email => v.project.service_account_name }
  output_route          = module.route
  output_sa             = module.service-account
  output_ssl            = module.ssl
  output_subnet         = module.subnets
  output_subnet_id      = { for i in flatten([for k, v in module.subnets.subnets : [for k1, v1 in v.subnets : v1]]) : i.name => i.id }
  output_umig           = module.umigs
  output_umig_self_link = { for k, v in module.umigs : k => v.self_link }
  output_vm_instances   = { for k, v in module.vm : k => v.google_compute_instance }
  output_vpc_all        = module.vpc
  output_vpc_id         = { for k, v in module.vpc : k => v.vpc.network_id }
  output_vpn            = module.vpns
  output_disks          = module.disks
}
