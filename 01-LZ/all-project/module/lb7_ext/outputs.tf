output "lb7_forwarding_rule_https" { value = google_compute_global_forwarding_rule.forwarding_rule_https }
output "lb7_https_proxy" { value = google_compute_target_https_proxy.https_proxy }
output "lb7_url_map" { value = google_compute_url_map.url_map }
output "lb7_backend_service" { value = google_compute_backend_service.backend_service }



