variable "folder_leveluno"{
    description = "org_id"
    type = list(string)
}

variable "folder_leveldos"{
    description = "org_id"
    type = map(list(string))
}

variable "parent_id"{
    type = string
}


