locals {

  # Template to build up provider file
  _tpl_providers         = "${path.module}/templates/providers.tf.tpl"

  # provider_london = merge({
  #   "[PROVIDER_FILENAME]" : templatefile(local._tpl_providers, {
  #     bucket = module.bucket["g-bkt-[XXX]"].bucket.name
  #     sa = module.service-account["g-sa-[XXX]"].sa.email
  #   })
  # })

  # # tfvars file with information.
  # tfvars = {
  #     projects_id              = try(local.dependence_projects, null) 
  #     folders_id               = try(local.dependence_folder, null)
  #     vpcs_id                  = try(local.dependence_vpc, null)
  #     vms_id                   = try(local.dependence_vm, null)
  #     subnets_id               = try(local.dependence_subnet, null)
  #     umigs_id                 = try(local.dependence_umig, null)
  #     ips_id                   = try(local.dependence_ips, null)
  #     ips_cidr_id              = try(local.dependence_ips_cidr, null)
  #     hcs_id                   = try(local.dependence_hc, null)
  #     ssls_id                  = try(local.dependence_ssl, null)
  #     lbs_id                   = try(local.dependence_lbs, null)
  #     sas_id                   = try(local.dependence_sas, null)
  #     buckets_id               = try(local.dependence_buckets, null)

  # }


}

