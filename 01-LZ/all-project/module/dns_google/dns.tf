

module "google_dns_managed_zone" {
    source = "terraform-google-modules/cloud-dns/google"
    version = "4.1.0"
    project_id                             = var.dns.project_id
    type                                   = var.dns.type
    name                                   = var.dns.name
    domain                                 = var.dns.domain
    description                            = lookup(var.dns, "description", "Managed by Terraform")
    private_visibility_config_networks     = lookup(var.dns, "private_visibility_config_networks", [])
    labels                                 = lookup(var.dns, "labels", {})
    dnssec_config                          = lookup(var.dns, "dnssec_config", {})
    default_key_specs_key                  = lookup(var.dns, "default_key_specs_key", {})
    default_key_specs_zone                 = lookup(var.dns, "default_key_specs_zone", {})
    force_destroy                          = lookup(var.dns, "force_destroy", false)
    //for peering
    target_network                         = lookup(var.dns, "target_network", "Peering network.")
    //for forwarding                      
    target_name_server_addresses           = lookup(var.dns, "target_name_server_addresses", [])
    //for private and public
    recordsets                             = lookup(var.dns, "recordsets", [])
}