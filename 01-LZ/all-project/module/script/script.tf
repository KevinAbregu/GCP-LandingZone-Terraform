module "script" {
  source = "terraform-google-modules/gcloud/google"
  version = "~> 3.1"

  platform              = "linux"
  create_cmd_entrypoint  = "${path.module}/scripts/${var.sh}.sh ${join(" " , var.args)}"
  create_cmd_body        = "enable ${var.project_id}"
  destroy_cmd_entrypoint = "${path.module}/scripts/${var.sh}.sh ${join(" " , var.args)}"
  destroy_cmd_body       = "disable ${var.project_id}"

}