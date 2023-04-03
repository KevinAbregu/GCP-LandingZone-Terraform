module "nat" {
  source   = "./module/nat"
  for_each = local.combine_cloud_nat
  nat      = each.value
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets,
    module.address
  ]
}
