module "bucket" {
  source   = "./module/bucket_google"
  for_each = local.combine_bucket
  bucket   = each.value
  depends_on = [
    module.projects,
    module.iam_folder

  ]
}
