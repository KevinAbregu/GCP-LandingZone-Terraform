module "vpn-prod-internal" {
  source  = "./terraform-google-vpn-master"

  project_id                = var.vpn.project_id
  network                   = var.vpn.network
  region                    = var.vpn.region
  peer_ips                  = var.vpn.peer_ips
  gateway_name              = contains(keys(var.vpn), "gateway_name") ? var.vpn["gateway_name"] : "test-vpn"
  tunnel_count              = contains(keys(var.vpn), "tunnel_count") ? var.vpn["tunnel_count"] : 1
  tunnel_name_prefix        = contains(keys(var.vpn), "tunnel_name_prefix") ? var.vpn["tunnel_name_prefix"] : ""
  shared_secret             = contains(keys(var.vpn), "shared_secret") ? var.vpn["shared_secret"] : ""
  local_traffic_selector    = lookup(var.vpn, "local_traffic_selector", {}) 
  remote_traffic_selector   = contains(keys(var.vpn), "remote_traffic_selector") ? var.vpn["remote_traffic_selector"] : []
  remote_subnet             = contains(keys(var.vpn), "remote_subnet") ? var.vpn["remote_subnet"] : []
  remote_subnet_map         = contains(keys(var.vpn), "remote_subnet_map") ? var.vpn["remote_subnet_map"] : {}
  route_priority            = contains(keys(var.vpn), "route_priority") ? var.vpn["route_priority"] : 1000 

  # Optional Cloud Route for BGP
  cr_name                   = contains(keys(var.vpn), "cr_name") ? var.vpn["cr_name"] : ""
  cr_enabled                = contains(keys(var.vpn), "cr_enabled") ? var.vpn["cr_enabled"] : false 
  peer_asn                  = contains(keys(var.vpn), "peer_asn") ? var.vpn["peer_asn"] : ["65101"]
  bgp_cr_session_range      = contains(keys(var.vpn), "bgp_cr_session_range") ? var.vpn["bgp_cr_session_range"] : ["169.254.1.1/30", "169.254.1.5/30"]
  bgp_remote_session_range  = contains(keys(var.vpn), "bgp_remote_session_range") ? var.vpn["bgp_remote_session_range"] : ["169.254.1.2", "169.254.1.6"]

  advertised_route_priority = contains(keys(var.vpn), "advertised_route_priority") ? var.vpn["advertised_route_priority"] : 100
  ike_version               = contains(keys(var.vpn), "ike_version") ? var.vpn["ike_version"] : 2
  vpn_gw_ip                 = contains(keys(var.vpn), "vpn_gw_ip") ? var.vpn["vpn_gw_ip"] : ""
  route_tags                = contains(keys(var.vpn), "route_tags") ? var.vpn["route_tags"] : []
}