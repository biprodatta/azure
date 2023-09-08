output "uai_id" {
  value = azurerm_user_assigned_identity.datta_usi.id
}
output "uai_client_id" {
  value = azurerm_user_assigned_identity.datta_usi.client_id
}

output "uai_principal_id" {
  value = azurerm_user_assigned_identity.datta_usi.principal_id
}

output "uai_tenant_id" {
  value = azurerm_user_assigned_identity.datta_usi.tenant_id
}