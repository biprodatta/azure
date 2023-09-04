/*
variable "application_name" {
  type = "string"
}
*/
variable "rg_name" {
  description = "resource group name"
  type        = string
  default = "test-rg"
}

variable "name_suffix" {
  type    = string
  default = "name_suffix"

}
/*
variable "workbook_mapping" {
  type = list(list(object({
    "operationscausingmosterrors" = {
      display_name = string
      workbook_data_json = string
    }
    "VirtualMachineCPUHeatUp" = {
      display_name = string
      workbook_data_json = string

    }
  }))) 
  default = [ [ {
    "operationscausingmosterrors" = {
      display_name = "operation causing most errors"
      workbook_data_json = "operationscausingmosterrors"
    }
    "VirtualMachineCPUHeatUp" = {
      display_name = "Virtual Machine CPU Heat Up"
      workbook_data_json = "VirtualMachineCPUHeatUp"

    }
  } ] ]
}

variable "tags" {
  type = list(object({
    name = string,
    env  = string
  }))
  default = [{
    name = "workkbook"
    env  = "dev"
  }]
}
*/
