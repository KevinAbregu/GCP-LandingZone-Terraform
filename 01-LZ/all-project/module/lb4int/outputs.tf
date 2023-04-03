output "forwardings" {
  value = google_compute_forwarding_rule.forwarding_rule
}

output "backends" {
  value = google_compute_region_backend_service.backend_service
}
