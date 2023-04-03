module "iam_folder" {
  source   = "./module/iam"
  for_each = local.combine_iam
  iam      = each.value
  folder   = local.dependence_folder
  depends_on = [
    module.folder,
    module.folder_lon,
    module.projects,
    module.service-account
  ]
}

