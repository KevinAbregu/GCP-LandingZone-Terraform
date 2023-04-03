locals {
  # Folder
  _dependence_folder = merge(try(local.output_folder.map_id_folder, {}))
  # Folder_lon
  _dependence_folder_lon = merge(try(local.output_folder_lon.map_id_folder, {}))
  dependence_folder      = merge(local._dependence_folder, local._dependence_folder_lon)
  # VM
  local_vm_id = { for k, v in local.combine_vm_instances :
  k => "https://www.googleapis.com/compute/v1/projects/${v.project}/zones/${v.zone}/instances/${v.name}" }
  dependence_vm = merge(try(local.local_vm_id, {}))

  # VPC
  local_vpc_id = { for k, v in local.combine_vpc :
  k => "projects/${v.project_vpc}/global/networks/${v.network_name_vpc}" }
  dependence_vpc = merge(try(local.output_vpc_id, {}))
  # SUBNET
  local_subnet_id = {
    for i in flatten([
      for k, v in local.combine_subnet : [
        for i in v.subnet_info :
    merge(i, zipmap(["project"], [v.project_vpc]))]]) :
  i.subnet_name => "projects/${i.project}/regions/${i.subnet_region}/subnetworks/${i.subnet_name}" }
  dependence_subnet = merge(try(local.output_subnet_id, {}))

  # UMIG
  local_umig_id = { for k, v in local.combine_umig :
  k => "projects/${v.project_id}/zones/${v.zone}/instanceGroups/${v.name}" }
  dependence_umig = merge(try(local.local_umig_id, {}))

  # IPS
  local_ip_id = { for k, v in local.combine_address :
    k => lookup(v, "global", false) ?
    "projects/${v.project}/global/addresses/${v.name_address}" :
  "projects/${v.project}/regions/${v.region}/addresses/${v.name_address}" }
  dependence_ips = merge(try(local.local_ip_id, {}))

  dependence_ips_cidr = merge(try(local.output_address_ip, {}))


  # HC
  local_hc_id = { for k, v in local.combine_health_check : k => v.global ?
    "projects/${v.project}/global/healthChecks/${v.name}" :
  "projects/${v.project}/regions/${v.region}/healthChecks/${v.name}" }
  dependence_hc = merge(try(local.local_hc_id, {}))

  # SSL
  local_ssl_id   = {}
  dependence_ssl = merge(try(local.local_ssl_id, {}))

  # projects
  local_projects_id   = { for k, v in local.output_projects : k => v.project.project_id }
  dependence_projects = merge(try(local.local_projects_id, {}))

  # lb7 int
  local_lb7_id = { for k, v in local.output_lb4_int : k => {
    backend_id : v.backends.id,
    forwarding_rules_id : v.forwardings[k].id
    }
  }
  dependence_lbs = merge(try(local.local_lb7_id, {}))

  #sa
  local_sa_id = { for k, v in local.output_sa : k => {
    id : v.sa.id,
    email : v.sa.email,
    iam_email : v.sa.iam_email
    }
  }
  dependence_sas = merge(try(local.local_sa_id, {}))

  #bucket
  local_bucket_id = { for k, v in local.output_bucket : k => {
    url : v.bucket.url,
    self_link : v.bucket.bucket.self_link
    }
  }
  dependence_buckets = merge(try(local.local_bucket_id, {}))

  dependence_disks = {
    for k, v in local.output_disks : k => v.disks.id 
  }

}
