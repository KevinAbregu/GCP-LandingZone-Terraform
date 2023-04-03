# output "google_compute_disk" { value = google_compute_disk.disk_boot }
output "google_compute_instance" {
  value = google_compute_instance.instance.id
}
