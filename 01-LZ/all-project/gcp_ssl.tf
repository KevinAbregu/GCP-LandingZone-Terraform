module "ssl" {
  source   = "./module/ssl"
  for_each = local.combine_ssl
  ssl      = each.value
  depends_on = [
    module.projects
  ]
}
