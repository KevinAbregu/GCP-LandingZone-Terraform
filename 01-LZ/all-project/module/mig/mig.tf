
module "instance_template" {
  source = "./instance-template"
  instance_template = var.mig.instance_template
}

module "compute_instance" {
    source              = "./mig"
    project_id                = var.mig.project_id
    region                    = var.mig.region
# Only one of network or subnetwork should be specified.
    network                   = lookup(var.mig, "network", "")
    subnetwork                = lookup(var.mig, "subnetwork", "") 
    subnetwork_project        = lookup(var.mig, "subnetwork_project", "") 

    mig_name                  = contains(keys(var.mig), "hostname") ? var.mig["hostname"] : "default"    
    hostname                  = contains(keys(var.mig), "hostname") ? var.mig["hostname"] : "default"
    target_pools              = contains(keys(var.mig), "target_pools") ? var.mig["target_pools"] : []
    target_size               = contains(keys(var.mig), "target_size") ? var.mig["target_size"] : 1
    distribution_policy_zones = contains(keys(var.mig), "distribution_policy_zones") ? var.mig["distribution_policy_zones"] : []
    stateful_disks            = contains(keys(var.mig), "stateful_disks") ? var.mig["stateful_disks"] : []
    named_ports               = contains(keys(var.mig), "named_ports") ? var.mig["named_ports"] : []
    wait_for_instances        = contains(keys(var.mig), "wait_for_instances") ? var.mig["wait_for_instances"] : "false"
    mig_timeouts              = contains(keys(var.mig), "mig_timeouts") ? var.mig["mig_timeouts"] : {create = "5m", update = "5m", delete = "15m"}

    update_policy            = contains(keys(var.mig), "update_policy") ? var.mig["update_policy"] : []


##############
# Healthcheck

  health_check_name         = lookup(var.mig, "health_check_name", "") 
  health_check              = var.mig.health_check 
  
    
# Autoscaler
    autoscaler_name         = contains(keys(var.mig), "autoscaler_name") ? var.mig["autoscaler_name"] : ""
    autoscaling_enabled         = contains(keys(var.mig), "autoscaling_enabled") ? var.mig["autoscaling_enabled"] : false
    max_replicas         = contains(keys(var.mig), "max_replicas") ? var.mig["max_replicas"] : 10
    min_replicas         = contains(keys(var.mig), "min_replicas") ? var.mig["min_replicas"] : 2
    cooldown_period         = contains(keys(var.mig), "cooldown_period") ? var.mig["cooldown_period"] : 60
    autoscaling_mode         = contains(keys(var.mig), "autoscaling_mode") ? var.mig["autoscaling_mode"] : null
    autoscaling_cpu         = contains(keys(var.mig), "autoscaling_cpu") ? var.mig["autoscaling_cpu"] : []
    autoscaling_metric         = contains(keys(var.mig), "autoscaling_metric") ? var.mig["autoscaling_metric"] : []
    autoscaling_lb         = contains(keys(var.mig), "autoscaling_lb") ? var.mig["autoscaling_lb"] : []
    autoscaling_scale_in_control         = contains(keys(var.mig), "autoscaling_scale_in_control") ? var.mig["autoscaling_scale_in_control"] : {fixed_replicas = null, percent_replicas = null, time_window_sec = null}



    instante_version = lookup(var.mig, "instante_version", "") 
    instance_template   = module.instance_template.instance_template.self_link
    depends_on          = [module.instance_template]
}