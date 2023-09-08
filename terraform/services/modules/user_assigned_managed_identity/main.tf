data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_user_assigned_identity" "datta_usi" {
  name                = "datta_user_identity"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

# the role assignment to this identity
resource "azurerm_role_assignment" "roll_asnmt" {
  scope              = data.azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = azurerm_user_assigned_identity.datta_usi.principal_id
}