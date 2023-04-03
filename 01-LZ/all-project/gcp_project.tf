
module "projects" {
  source           = "./module/project_google"
  for_each         = local.combine_projects
  parent_id        = local.dependence_folder
  projects         = each.value
  organizations_id = local.organizations_id
  billing_account  = local.billing_account
  # Comentar cada módulo si no se ejecuta en el proyecto de terraform
  depends_on = [
    module.folder,
    # module.iam_folder  # Solo es necesario para la primera ejecución para dar permisos a la SA creada a mano.
  ]
}




