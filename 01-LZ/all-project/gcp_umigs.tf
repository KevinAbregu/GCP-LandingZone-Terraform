module "umigs" {
  source    = "./module/umig"
  for_each  = local.combine_umig
  umig      = each.value
  instances = local.dependence_vm
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets,
    module.vm
  ]
}
