module "bucket" {
  source          = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version         = "3.4.1"
  project_id      = var.bucket.bucket_project
  name            = var.bucket.bucket_name
  location        = var.bucket.bucket_location
  iam_members     = var.bucket.bucket_iam_members
  versioning      = var.bucket.bucket_versioning
  lifecycle_rules = lookup(var.bucket, "bucket_life", [])
}
