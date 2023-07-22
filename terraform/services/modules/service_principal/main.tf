resource "azurerm_azuread_application" "test" {
  name = var.application_name
}

resource "azurerm_azuread_service_principal" "test" {
  application_id = azurerm_azuread_application.test.application_id
}
