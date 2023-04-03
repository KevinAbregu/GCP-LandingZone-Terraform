module "disks" {
  source       = "./module/disks"
  for_each     = local.combine_disks
  disks = each.value
  depends_on = [
    module.projects
  ]
}
