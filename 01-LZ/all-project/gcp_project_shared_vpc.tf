module "project_shared_vpc" {
  source   = "./module/project_shared_vpc"
  for_each = local.combine_projects_shared_vpc
  project_shared_vpc      = each.value
  subnetwork_id = local.dependence_subnet

  depends_on = [
    module.folder,
    module.subnets,
    module.projects
  ]
}


