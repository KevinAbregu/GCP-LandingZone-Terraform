# Dependencies on other modules 
locals {
  folder = var.iam.type == "folder" ? var.folder[var.iam.folder] : ""
}

# Service Account

resource "google_folder_iam_binding" "folder" {
  count   = var.iam.type == "folder" ? 1 : 0
  folder  = local.folder
  role    = var.iam.role
  members = var.iam.members
}

resource "google_project_iam_binding" "project" {
  count   = var.iam.type == "project" ? 1 : 0
  project = var.iam.project
  role    = var.iam.role
  members = var.iam.members
}
