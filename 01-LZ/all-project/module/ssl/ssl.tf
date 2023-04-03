resource "google_compute_region_ssl_certificate" "ssl" {
  region      = var.ssl.region
  name        = var.ssl.name
  project     = var.ssl.project
  private_key = file(var.ssl.paht_private_key)
  certificate = file(var.ssl.paht_certificate)
}