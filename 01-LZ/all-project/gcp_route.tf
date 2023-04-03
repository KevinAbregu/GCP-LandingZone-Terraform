module "route" {
  source   = "./module/route"
  for_each = local.combine_route
  route    = each.value
  depends_on = [
    module.projects
  ]
}
