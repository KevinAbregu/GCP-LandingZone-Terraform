module "address" {
  source     = "./module/address"
  for_each   = local.combine_address
  address    = each.value
  subnets_id = local.dependence_subnet
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets
  ]
}
