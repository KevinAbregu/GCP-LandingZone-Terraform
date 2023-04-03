locals {
  outputs_location = try("./output-files")
}

resource "local_file" "provider_london" {
  for_each        =  try(local.provider_london, {})
  file_permission = "0644"
  filename        = "${local.outputs_location}/providers/${each.key}-providers.tf"
  content         = try(each.value, null)
}

# resource "local_file" "tfvars" {
#   file_permission = "0644"
#   filename        = "${local.outputs_location}/tfvars/output-variables.auto.tfvars.json"
#   content         = jsonencode(local.tfvars)
# }
