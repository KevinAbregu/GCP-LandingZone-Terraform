
module "folder" {
  source          = "./module/folder_google"
  parent_id       = local.combine_folder.parent_id
  folder_leveluno = local.combine_folder.folder_leveluno
  folder_leveldos = local.combine_folder.folder_leveldos
}

module "folder_lon" {
  source          = "./module/folder_google"
  parent_id       = local.combine_folder_lon.parent_id
  folder_leveluno = local.combine_folder_lon.folder_leveluno
  folder_leveldos = local.combine_folder_lon.folder_leveldos
}