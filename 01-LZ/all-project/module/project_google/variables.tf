variable "parent_id" {
  description = "(Required) Mapa con los identificadores de todas las carpetas"
  type        = map(string)
}

variable "projects" {
  description = "org_id"
  type        = any
}

variable "organizations_id" {
  description = "org_id"
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "org_id"
  type        = string
  default     = ""
}



