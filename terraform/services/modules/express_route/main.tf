resource "azurerm_resource_group" "er_rg" {
  name     = "expressroutetest"
  location = "West Europe"
}

# Create User Assigned Managed Identity for express route
resource "azurerm_user_assigned_identity" "express_route_uai" {
  resource_group_name = azurerm_resource_group.er_rg.name
  location            = azurerm_resource_group.er_rg.location
  name                = "express_route_uai"
}

# Assign the reader role on the Key vault to the Managed Identity.
resource "azurerm_role_assignment" "role_assignment" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.express_route_uai.id
}

resource "random_password" "ckn" {
  length           = 10
  special          = true
  override_special = "!#$%&*"
}

resource "random_password" "cak" {
  length           = 10
  special          = true
  override_special = "!#$%&*"
}

# Create key vault secret for macsec connectivity association key (CAK)
resource "azurerm_key_vault_secret" "ckn_kv_secret" {
  name         = "ckn_kv_secret"
  value        = random_password.ckn.result
  key_vault_id = azurerm_key_vault.kv.id
}

# Create key vault secret for macsec connectivity association key name (CKN)
resource "azurerm_key_vault_secret" "cak_kv_secret" {
  name         = "cak_kv_secret"
  value        = random_password.cak.result
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_express_route_circuit" "example" {
  name                  = "expressRoute1"
  resource_group_name   = azurerm_resource_group.er_rg.name
  location              = azurerm_resource_group.er_rg.location
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"
  bandwidth_in_mbps     = 50

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  tags = {
    env = "dev"
  }
}

#Create express route custom port
resource "azurerm_express_route_port" "er_port" {
  name                = "port1"
  resource_group_name = azurerm_resource_group.er_rg.name
  location            = azurerm_resource_group.er_rg.location
  peering_location    = "Airtel-Chennai-CLS"
  bandwidth_in_gbps   = 10
  encapsulation       = "Dot1Q"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.express_route_uai.id]
  }
  link {
    admin_enabled                  = "true"
    macsec_cipher                  = "GcmAes128"
    billing_type                   = "MeteredData"
    macsec_ckn_keyvault_secret_id  = azurerm_key_vault_secret.ckn_kv_secret.id
    macsec_cak_keyvault_secret_id  = azurerm_key_vault_secret.cak_kv_secret.id
  }
}
