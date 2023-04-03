locals {
  combine_folder              = merge(/*local.import_yaml_folder*/)
  combine_folder_lon          = merge(/*local.import_yaml_folder_lon*/)
  combine_projects            = merge(/*local.import_yaml_projects*/)
  combine_bucket              = merge(/*local.import_yaml_bucket*/)
  combine_sa                  = merge(/*local.import_yaml_sa*/)
  combine_iam                 = merge(/*local.import_yaml_iam*/)
  
  combine_vpc                 = merge(/*local.import_yaml_vpc*/)
  combine_subnet              = merge(/*local.import_yaml_subnet*/) 
  combine_firewall            = merge(/*local.import_yaml_firewall*/)
  combine_peering             = merge(/*local.import_yaml_peering*/)
  combine_projects_shared_vpc = merge(/*local.import_yaml_projects_shared_vpc*/)
  combine_address             = merge(/*local.import_yaml_address*/)
  combine_cloud_nat           = merge(/*local.import_yaml_cloud_nat*/)
  combine_route               = merge(/*local.import_yaml_route*/)
  combine_vpn                 = merge(/*local.import_yaml_vpn*/) 

  combine_disks               = merge(/*local.import_yaml_disks*/)
  combine_vm_instances        = merge(/*local.import_yaml_vm_instances*/)

  combine_health_check        = merge(/*local.import_yaml_health_check*/) #
  combine_umig                = merge(/*local.import_yaml_umig*/) #
  combine_lb4_internal        = merge(/*local.import_yaml_lb4_int*/) #
  combine_lb4_external        = merge(/*local.import_yaml_lb4_ext*/)
  combine_lb7_int             = merge(/*local.import_yaml_lb7_int*/)
  combine_lb7_ext             = merge(/*local.import_yaml_lb7_ext*/)
  
  combine_ssl                 = merge(/*local.import_yaml_ssl*/)
  combine_dns_policy          = merge(/*local.import_yaml_dns_policy*/)
  combine_dns                 = merge(/*local.import_yaml_dns*/)
  
  combine_ha_vpn              = merge(/*local.import_yaml_ha_vpn*/)
  combine_interconnect        = merge(/*local.import_yaml_interconnect*/)

  
  
  
  
  
}
