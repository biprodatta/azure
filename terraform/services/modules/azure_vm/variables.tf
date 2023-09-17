variable "appname" {
  description     = "Name of the application"
  default = "myapp"

}

variable "appid" {
  description     = "unique application id"
  default = "a1"
}

variable "environment" {
  type        = string
  description = "The environment for the resource. Choose between dev, qa, stage and prod"
  default = "dev"
}
variable "resource_group" {
  description = "resource group"
  default = "test-rg"
  
}


variable "vnet" {
  description = "Name of the VNet,where resource needs to deploy"
  type  = string
  default = "bipro_vnet"
}

variable "subnet" {
  description = "The subnet id, where resource needs to deploy"
  type = string
  default = "default"
}

variable "location" {
  description = "The location of the vm"
  type = string
  default = "eastus"
}


variable "vm_size" {
  description = "The size of the vm"
  type = string
  default = "Standard_D4s_v3"
}

variable "machine_count" {
  description = "Number of VMs"
  type = number
  default = 1
}
variable "admin_password" {
    description = "admin password for the VM"
    default = "Test@123456"
  
}