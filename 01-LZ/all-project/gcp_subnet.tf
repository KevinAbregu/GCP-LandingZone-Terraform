module "subnets" {
  source = "./module/subnet_google"
  subnet = local.combine_subnet
  # Comentar cada módulo si no se ejecuta en el proyecto de terraform
  depends_on = [
    module.projects,
    module.vpc
  ]
}
