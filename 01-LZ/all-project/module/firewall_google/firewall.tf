module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version       = "~> 4.1"
  project_id   = var.project_id
  network_name = var.network_name
  for_each = {for l in var.rules : l.name => l}
  rules = [{
    name                      = lookup(each.value,"name",null) 
    description               = lookup(each.value,"description","Manage by Terraform") 
    direction                 = lookup(each.value,"direction",null) 
    priority                  = lookup(each.value,"priority",null) 
    ranges                    = lookup(each.value,"ranges",null) 
    source_tags               = lookup(each.value,"source_tags",null) 
    source_service_accounts   = lookup(each.value,"source_service_accounts",null) 
    target_tags               = lookup(each.value,"target_tags",null) 
    target_service_accounts   = lookup(each.value,"target_service_accounts",null) 
    allow                     = lookup(each.value,"allow",[]) 
    deny                      = lookup(each.value,"deny",[]) 
    log_config                = lookup(each.value,"log_config",null) 

  }]
}
