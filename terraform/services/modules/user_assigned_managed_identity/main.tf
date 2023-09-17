data "azurerm_resource_group" "rg" {
  name = var.rg_name
}


# data "azurerm_storage_container" "example" {
#   name                 = "dattacontainer"
#   storage_account_name = "datta123"
# }

data "azurerm_storage_account" "example" {
  name                = "datta123"
  resource_group_name = "test-sandeep2"
}

resource "azurerm_user_assigned_identity" "datta_usi" {
  name                = "datta_user_identity"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

# the role assignment at storage account level to this identity 
resource "azurerm_role_assignment" "blob_roll_asnmt" {
  # scope              = data.azurerm_storage_container.example.resource_manager_id
  scope = data.azurerm_storage_account.example.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = azurerm_user_assigned_identity.datta_usi.principal_id
}