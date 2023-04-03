# resource "google_compute_disk" "disk_boot" {
#   project  = var.vm_instances.project
#   name     = var.vm_instances.disk.name
#   size     = var.vm_instances.disk.size
#   zone     = var.vm_instances.disk.zone
#   type     = var.vm_instances.disk.type
#   snapshot = lookup(var.vm_instances.disk, "snapshot", null)
#   image    = lookup(var.vm_instances.disk, "image", null)
# }

resource "google_compute_instance" "instance" {
  name           = var.vm_instances.name
  project        = var.vm_instances.project
  machine_type   = var.vm_instances.machine_type
  zone           = var.vm_instances.zone
  hostname       = lookup(var.vm_instances, "hostname", null)
  can_ip_forward = lookup(var.vm_instances, "can_ip_forward", false)
  tags           = lookup(var.vm_instances, "tags", null)
  metadata       = lookup(var.vm_instances, "metadata", null)
  enable_display = lookup(var.vm_instances, "enable_display", true)
  boot_disk {
    source = var.disks_id[var.vm_instances.boot_disk]
  }
  dynamic "network_interface" {
    for_each = { for i in var.vm_instances.network_interface : i.address_name => i }
    content {
      network    = var.vpc_id[network_interface.value.network]
      subnetwork = var.subnets_id[network_interface.value.subnetwork]
      network_ip = network_interface.value.address_name
      nic_type   = lookup(network_interface.value, "nic_type", null)
      dynamic "alias_ip_range" {
        for_each = { for i in lookup(network_interface.value, "alias_ip_range", []) : i => i }
        content {
          ip_cidr_range = alias_ip_range.value
        }
      }
    }
  }
  dynamic "service_account" {
    for_each = { for i in var.vm_instances.service_account : var.vm_instances.name => i }
    content {
      scopes = service_account.value.scopes
    }
  }

  dynamic attached_disk {
    for_each = try(var.vm_instances.attached_disk, [])
    content {
      source = var.disks_id[attached_disk.value]
    }
  }
  # depends_on = [
  #   google_compute_disk.disk_boot
  # ]
}
