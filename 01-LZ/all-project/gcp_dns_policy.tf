module "dns_policy" {
  source     = "./module/dns_policy"
  for_each   = local.combine_dns_policy
  dns_policy = each.value
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets,
  module.address]
}
