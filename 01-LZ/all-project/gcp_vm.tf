module "vm" {
  source       = "./module/vm"
  for_each     = local.combine_vm_instances
  vm_instances = each.value
  vpc_id       = local.dependence_vpc
  subnets_id   = local.dependence_subnet
  disks_id     = local.dependence_disks
  depends_on = [
    module.projects,
    module.vpc,
    module.subnets,
    module.address,
    module.disks
  ]
}
