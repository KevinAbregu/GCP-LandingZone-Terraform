locals {
  //Opcional
  ike_version = lookup(var.tunnel,"ike_version",2)
  local_traffic_selector = lookup(var.tunnel,"local_traffic_selector",[])
  priority  = lookup(var.tunnel,"priority",1000)
  tags  = lookup(var.tunnel,"tags",[])
}


/* Routes */
resource "google_compute_route" "route" {
  count      = length(var.tunnel.remote_subnet) 
  name       = "${var.tunnel.name}-route${count.index + 1}"
  network    = var.network
  project    = var.project
  dest_range = var.tunnel.remote_subnet[count.index]
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-static.self_link

  // Optional
  priority   = local.priority
  tags       = local.tags

  depends_on = [google_compute_vpn_tunnel.tunnel-static]
}


resource "google_compute_vpn_tunnel" "tunnel-static" {
  name          = var.tunnel.name
  region        = var.region
  project       = var.project
  peer_ip       = var.tunnel.peer_ips
  target_vpn_gateway      = var.gateway
  local_traffic_selector  = local.local_traffic_selector
  remote_traffic_selector = var.tunnel.remote_subnet

  shared_secret = var.tunnel.shared_secret
  ike_version = local.ike_version
}