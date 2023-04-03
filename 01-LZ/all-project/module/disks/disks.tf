resource "google_compute_disk" "disks" {
  project  = var.disks.project
  name     = var.disks.name
  size     = var.disks.size
  zone     = var.disks.zone
  type     = var.disks.type
  labels   = lookup(var.disks, "labels", {})
  snapshot = lookup(var.disks, "snapshot", null)
  image    = lookup(var.disks, "image", null)
}