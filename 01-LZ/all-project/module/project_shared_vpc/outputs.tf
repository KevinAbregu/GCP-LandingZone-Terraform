output "project_shared_vpc" { value = module.shared_vpc_access }
output "project_shared_vpc_resource" { value = google_compute_shared_vpc_service_project.shared_vpc_attachment}
