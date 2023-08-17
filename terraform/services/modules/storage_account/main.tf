data "azurerm_resource_group" "test-rg" {
  name = "test-rg"
}

data "azurerm_subnet" "example" {
  name                 = "default"
  virtual_network_name = "bipro_vnet"
  resource_group_name  = "test-rg"
}

data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "test" {
  name                = "mytestsa1992"
  resource_group_name = data.azurerm_resource_group.test-rg.name

  location                 = data.azurerm_resource_group.test-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [data.azurerm_subnet.example.id]
  }

  tags = {
    environment = "dev"
  }
}
