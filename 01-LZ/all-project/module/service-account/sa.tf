
module "service-account" {
  source     = "./module-cloud-foundation-fabric"
  project_id = var.sa.project
  name       = var.sa.name
  display_name = lookup(var.sa, "display_name", var.sa.name)
  iam_additive = try({for k, v in var.sa.iam_additive: k => v}, {})
  iam_project_roles = try({for k, v in var.sa.iam_project_roles: k => v}, {})
}