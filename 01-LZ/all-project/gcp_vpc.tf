module "vpc" {
  source   = "./module/vpc_google"
  for_each = local.combine_vpc
  vpc      = each.value
  # Comentar cada módulo si no se ejecuta en el proyecto de terraform
  depends_on = [
    module.projects
  ]
}
