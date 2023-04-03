output "health_checks_tcp" {
  value = local.outputs_tcp
}
output "health_checks_http" {
  value = local.outputs_http
}
output "health_checks_https" {
  value = local.outputs_https
}
output "health_checks_https_global" {
  value = local.outputs_https_global
}
output "health_checks_http_global" {
  value = local.outputs_http_global
}

output "health_checks_tcp_global" {
  value = local.outputs_tcp_global
}

output "health_checks_tcp_total" {
  value = google_compute_region_health_check.health_check_http
}

output "health_checks_http_total" {
  value = google_compute_region_health_check.health_check_https
}

output "health_checks_https_total" {
  value = google_compute_region_health_check.health_check_tcp
}

output "health_checks_https_global_total" {
  value = google_compute_health_check.health_check_https_global
}

output "health_checks_http_global_total" {
  value = google_compute_health_check.health_check_http_global
}
