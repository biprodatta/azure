variable "rg_name" {
  description = "resource group name"
  type = string
}

variable "display_name" {
  description = "display name of the workbook"
}

variable "workbook_data_json" {
  description = "json formatted workbook file"
}

variable "uai_principal_id" {
  description = "user assigned principal id"
  
}
/*
variable "tags" {
  type = list(object({
    name = string,
    env  = string
  }))
}
*/