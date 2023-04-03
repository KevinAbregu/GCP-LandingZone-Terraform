

data "google_compute_default_service_account" "compute_engine" {
  project     = var.instance_template["project_id"]
}



module "instace_template" {
  source                = "terraform-google-modules/vm/google//modules/instance_template"
  version               = "~> 7.4"
  name_prefix           = contains(keys(var.instance_template), "name_prefix") ? var.instance_template["name_prefix"] : "default-instance-template"
  machine_type          = contains(keys(var.instance_template), "machine_type") ? var.instance_template["machine_type"] : "n1-standard-1"
  project_id            = var.instance_template["project_id"]
  tags                  = contains(keys(var.instance_template), "tags") ? var.instance_template["tags"] : []
  labels                = contains(keys(var.instance_template), "labels") ? var.instance_template["labels"] : {}
  startup_script        = contains(keys(var.instance_template), "startup_script") ? var.instance_template["startup_script"] : ""
  metadata              = contains(keys(var.instance_template), "metadata") ? var.instance_template["metadata"] : {}
  network               = contains(keys(var.instance_template), "network") ? var.instance_template["network"] : ""
  subnetwork            = contains(keys(var.instance_template), "subnetwork") ? var.instance_template["subnetwork"] : ""
  subnetwork_project    = contains(keys(var.instance_template), "subnetwork_project") ? var.instance_template["subnetwork_project"] : ""
  can_ip_forward        = contains(keys(var.instance_template), "can_ip_forward") ? var.instance_template["can_ip_forward"] : "false"
  source_image          = contains(keys(var.instance_template), "source_image") ? var.instance_template["source_image"] : ""
  source_image_family   = contains(keys(var.instance_template), "source_image_family") ? var.instance_template["source_image_family"] : "centos-7"
  source_image_project  = contains(keys(var.instance_template), "source_image_project") ? var.instance_template["source_image_project"] : "centos-cloud"
  disk_size_gb          = contains(keys(var.instance_template), "disk_size_gb") ? var.instance_template["disk_size_gb"] : "100"
  disk_type             = contains(keys(var.instance_template), "disk_type") ? var.instance_template["disk_type"] : "pd-standard"
  auto_delete           = contains(keys(var.instance_template), "auto_delete") ? var.instance_template["auto_delete"] : "true"
  additional_disks      = contains(keys(var.instance_template), "additional_disks") ? var.instance_template["additional_disks"] : []
  service_account       = { 
        email =  data.google_compute_default_service_account.compute_engine.email
        scopes = ["https://www.googleapis.com/auth/servicecontrol"]
      }

  additional_networks   = contains(keys(var.instance_template), "additional_networks") ? var.instance_template["additional_networks"] : []
}