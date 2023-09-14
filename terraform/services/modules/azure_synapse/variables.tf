variable "BusinessView" {
  type        = string
  default     = "RCM Infra" 
}

variable "Environment" {
  type        = string
  default     = "Core" 
}

variable "AppOwner" {
  type        = string
  default     = "Joe Martella" 
}

variable "CreatedBy" {
  type        = string
  default     = "Ismael" 
}
variable "CreatedOn" {
  type        = string
  default     = "12/19/2020" 
}

variable "rg_name" {
  description = "resource group name"
  type        = string
  default     = "rg-azure-synapse-002" 
}

variable "sa_name" {
  description = "storage account name"
  type        = string
  default     = "strazuresynapse002" 
}

variable "datalake_fs_name" {
  description = "datalake file system name"
  type        = string
  default     = "datalakefs1"
}

variable "synapse_workspace_name" {
  description = "synapse workspace name"
  type        = string
  default     = "workspace112" 
}

variable "sqladmin_user" {
  description = "sql admin user"
  type        = string
  default     = "sa"
}

variable "sqladmin_pwd" {
  description = "sql admin password"
  type        = string
  default     = "Password123" 
}
variable "location" {
  description = "location of the resource to be created"
  type        = string
  default     = "eastus"
}

variable "object_id" {
  description = "object id of AAD"
  type        = string
  default     = "bd209ecc-8a92-4de1-b219-97231aee05fb"
}

variable "tenant_id" {
  description = "tenant id of AAD"
  type        = string
  default     = "74352aa5-d883-4e4a-8423-7862b342708e"
}
