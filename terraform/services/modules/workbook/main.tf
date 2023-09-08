locals {
  tags = {
    env     = "dev"
    appname     = "app1"
  }
}



data "azurerm_resource_group" "example" {
  name = var.rg_name
}

data "azurerm_storage_container" "example" {
  name                 = "dattacontainer"
  storage_account_name = "datta123"
}

resource "azurerm_application_insights_workbook" "example" {
  name                = uuid()
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  display_name        = var.display_name
  data_json           = var.workbook_data_json
  storage_container_id = data.azurerm_storage_container.example.resource_manager_id

  identity {
    type = "UserAssigned"
    identity_ids = [var.uai_principal_id]
  }
  
  tags                = local.tags
}