# Dependencies on other modules 
locals {
  parent_id = lookup(var.projects, "parent_id", "") == "" ? "" : var.parent_id[var.projects.parent_id]
}

// Creamos el proyecto para el host
module "project_factory" {
  source                         = "terraform-google-modules/project-factory/google"
  version                        = "~> 11.3"
  name                           = var.projects.name
  folder_id                      = local.parent_id
  random_project_id              = lookup(var.projects, "random_project_id", false)
  org_id                         = lookup(var.projects, "organizations_id", var.organizations_id)
  billing_account                = lookup(var.projects, "billing_account", var.billing_account)
  group_name                     = lookup(var.projects, "group_name", "")
  group_role                     = lookup(var.projects, "group_role", "roles/editor")
  create_project_sa              = lookup(var.projects, "create_project_sa", false)
  project_sa_name                = lookup(var.projects, "project_sa_name", "project-service-account")
  sa_role                        = lookup(var.projects, "sa_role", "")
  activate_apis                  = lookup(var.projects, "activate_apis", [""])
  labels                         = lookup(var.projects, "labels", {})
  auto_create_network            = lookup(var.projects, "auto_create_network", false)
  lien                           = lookup(var.projects, "lien", false)
  default_service_account        = lookup(var.projects, "default_service_account", "disable")
  enable_shared_vpc_host_project = lookup(var.projects, "enable_shared_vpc_host_project", false)
}
