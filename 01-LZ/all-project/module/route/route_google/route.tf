module "route" {
  source       = "terraform-google-modules/network/google//modules/routes"
  project_id   = var.route.project
  network_name = var.route.network_name
  route = [{
    ###### Falta por acabarlo ##########
    name             = var.route.name
    description      = lookup(var.route, "description", "Manage by Terraform")
    tags             = lookup(var.route, "tags", "")
    dest_range       = lookup(each.value, "destination_range", null)
    next_hop_gateway = var.route.type == "ilb" ? var.gateway : 0
  }]
}
