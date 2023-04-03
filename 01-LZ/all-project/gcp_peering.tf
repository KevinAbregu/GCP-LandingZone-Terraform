module "peering" {
  source  = "./module/peering_google"
  peering = local.combine_peering
  vpc_id  = local.dependence_vpc
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets
  ]
}
