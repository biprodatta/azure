locals {
  tags = {
    env     = "dev"
    appname     = "app1"
  }
}



data "azurerm_resource_group" "example" {
  name = var.rg_name
}

resource "azurerm_application_insights_workbook" "example" {
  name                = uuid()
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  display_name        = var.display_name
  data_json           = var.workbook_data_json
  tags                = local.tags
}