
locals {
  ips = [for i in var.nat.nat_ips: "projects/${var.nat.project}/regions/${var.nat.region}/addresses/${i}" ]
  subnetworks = var.nat.source_subnetwork_ip_ranges_to_nat == "LIST_OF_SUBNETWORKS" ?  [for i in range(length(var.nat.subnetworks)): {
    name = "projects/${var.nat.project}/regions/${var.nat.region}/subnetworks/${var.nat.subnetworks[i].name}"
    source_ip_ranges_to_nat = var.nat.subnetworks[i].source_ip_ranges_to_nat
    secondary_ip_range_names = var.nat.subnetworks[i].secondary_ip_range_names
  }] : []
}

module "cloud_nat" {
  source      = "terraform-google-modules/cloud-nat/google"
  version     = "~> 2.1.0"
  project_id  = var.nat.project
  region      = var.nat.region
  name        = var.nat.name
  # Name of router
  router      = var.nat.router
  router_asn                          = lookup(var.nat,"router_asn","64514")
  source_subnetwork_ip_ranges_to_nat  = lookup(var.nat,"source_subnetwork_ip_ranges_to_nat","ALL_SUBNETWORKS_ALL_IP_RANGES")
  subnetworks                         = length(local.subnetworks) > 0 ?  local.subnetworks : []

  tcp_established_idle_timeout_sec    = lookup(var.nat,"tcp_established_idle_timeout_sec","1200")
  tcp_transitory_idle_timeout_sec     = lookup(var.nat,"tcp_transitory_idle_timeout_sec","30")
  udp_idle_timeout_sec                = lookup(var.nat,"udp_idle_timeout_sec","30")
  icmp_idle_timeout_sec               = lookup(var.nat,"icmp_idle_timeout_sec","30")
  min_ports_per_vm                    = lookup(var.nat,"min_ports_per_vm","32")
  nat_ip_allocate_option              = lookup(var.nat,"nat_ip_allocate_option",false)
  nat_ips                             = length(local.ips) > 0 ?  local.ips : []
  log_config_enable                   = lookup(var.nat,"log_config_enable",false)
  log_config_filter                   = lookup(var.nat,"log_config_filter","")
  enable_endpoint_independent_mapping = lookup(var.nat,"enable_endpoint_independent_mapping",null)
  
  # if create compute router
  create_router               = lookup(var.nat,"create_router",false)
  network                     = lookup(var.nat,"network",[])

}