
terraform {
  required_version = ">0.12"
  
}

#azure provider
provider "azurerm" {
  version         = "=2.81.0"
  features {}
}




locals {
  tags = {
    BusinessView = var.BusinessView
    Environment  = var.Environment
    AppOwner     = var.AppOwner
    CreatedBy    = var.CreatedBy
    CreatedOn    = var.CreatedOn
  }

}

data "azurerm_resource_group" "synapse_rg" {
  name = var.rg_name
}

resource "azurerm_storage_account" "synapse_sa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
 }

resource "azurerm_storage_data_lake_gen2_filesystem" "fs_1" {
  name               = var.datalake_fs_name
  # storage_account_id = data.azstracc001.id 
  storage_account_id = azurerm_storage_account.synapse_sa.id
}


resource "azurerm_synapse_workspace" "synapse_workspace_name" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = var.rg_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.fs_1.id
  sql_administrator_login              = var.sqladmin_user
  sql_administrator_login_password     = var.sqladmin_pwd

  aad_admin {
    login     = "AAD DC Administrators"
    object_id = var.object_id
    tenant_id = var.tenant_id
  }

#  identity {
#    type = "SystemAssigned"
#  }

  tags = local.tags
}
