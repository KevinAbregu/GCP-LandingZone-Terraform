

resource "google_dns_policy" "dns_policy" {
  name    = var.dns_policy.name
  project = var.dns_policy.project
  description = lookup(var.dns_policy,"description","Managed by Terraform")
  enable_inbound_forwarding = var.dns_policy.enable_inbound_forwarding
  enable_logging = var.dns_policy.enable_logging
  networks {
    network_url = var.dns_policy.network_url
  }

}