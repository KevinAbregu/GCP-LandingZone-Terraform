module "dns" {
  source   = "./module/dns_google"
  for_each = local.combine_dns
  dns      = each.value
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets,
  module.address]
}
