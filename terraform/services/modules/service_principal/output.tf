output "spn_object_id" {
  value = data.azurerm_azuread_service_principal.test.id
}