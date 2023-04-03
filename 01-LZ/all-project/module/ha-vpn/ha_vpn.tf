
module "vpn_ha" {
    source = "./vpn_ha"
    project_id                  = var.ha_vpn.project
    region                      = var.ha_vpn.region
    network                     = "projects/${var.ha_vpn.project}/global/networks/${var.ha_vpn.network}"
    name                        = var.ha_vpn.name
    description                 = lookup(var.ha_vpn,"description","Manage by Terraform")
    router_name                 = var.ha_vpn.router_name
    router_asn                  = var.ha_vpn.router_asn  
    router_advertise_config     = var.ha_vpn.router_advertise_config
    peer_external_gateway       = var.ha_vpn.peer_external_gateway
    tunnels                     = var.ha_vpn.tunnels
}