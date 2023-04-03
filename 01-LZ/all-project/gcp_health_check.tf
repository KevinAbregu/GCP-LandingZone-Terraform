module "health_check" {
  source       = "./module/health_check"
  for_each     = local.combine_health_check
  health_check = each.value
  depends_on = [
    module.projects
  ]
}
