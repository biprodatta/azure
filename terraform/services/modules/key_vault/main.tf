data "azurerm_resource_group" "test-rg" {
  name = "test-rg"
}

data "azurerm_subnet" "example" {
  name                 = "default"
  virtual_network_name = "bipro_vnet"
  resource_group_name  = "test-rg"
}

data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "my-kv" {
  name                        = "testkeyvault"
  location                    = data.azurerm_resource_group.test-rg.location
  resource_group_name         = data.azurerm_resource_group.test-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
