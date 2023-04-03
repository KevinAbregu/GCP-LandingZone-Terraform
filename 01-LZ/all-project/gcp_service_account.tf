module "service-account" {
  source   = "./module/service-account"
  for_each = local.combine_sa
  sa    = each.value
  depends_on = [
    module.projects
  ]
}
