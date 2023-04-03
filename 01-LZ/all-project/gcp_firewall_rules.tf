module "firewall_rules" {
  source       = "./module/firewall_google"
  for_each     = local.combine_firewall
  project_id   = each.value.project_firewall
  network_name = each.value.network_name_firewall
  rules        = each.value.custom_rules
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets
  ]
}
