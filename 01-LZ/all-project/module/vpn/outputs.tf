output "vpn_gateway" { value = google_compute_vpn_gateway.vpn_gateway}
output "vpn_esp" { value = google_compute_forwarding_rule.vpn_esp}
output "vpn_udp500" { value = google_compute_forwarding_rule.vpn_udp500}
output "vpn_udp4500" { value = google_compute_forwarding_rule.vpn_udp4500}
output "tunnel" { value = module.tunnel}
