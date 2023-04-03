locals{
  map_level1 = {for k,v in module.leveluno.folders_map: v.display_name => v.name}  
  map_level2 = {
      for list in flatten([
        for k1,v1 in module.leveldos :[
            for k2,v2 in v1.folders_map: v2]]): list.display_name => list.name} 
  parent_folder = split("/",var.parent_id)[0] == "folders" ? {for i in data.google_folder.folder : i.display_name => i.name} : {}
}

data "google_folder" "folder" {
  count = split("/",var.parent_id)[0] == "folders" ? 1:0
  folder = var.parent_id
}


module "leveluno" {
  source  = "terraform-google-modules/folders/google"
  version = "3.0.0"
  parent  = var.parent_id
  names = var.folder_leveluno
}

module "leveldos" {
  for_each = var.folder_leveldos
  source  = "terraform-google-modules/folders/google"
  version = "3.0.0"
  parent  = module.leveluno.folders_map[each.key].name
  names = each.value
}

