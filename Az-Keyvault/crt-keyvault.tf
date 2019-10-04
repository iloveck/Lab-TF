resource "azurerm_resource_group" "test" {
  name     = "kanrg0814"
  location = "West US2"
}

resource "azurerm_key_vault" "test-keyvlt" {
  name                        = "kankv0814"
  location                    = "${azurerm_resource_group.test.location}"
  resource_group_name         = "${azurerm_resource_group.test.name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "7cacbdfd-ebad-46c0-8d1e-b7058ce44173"

  sku_name = "standard"

  access_policy {
    tenant_id = "7cacbdfd-ebad-46c0-8d1e-b7058ce44173"
    object_id = "1be59c1b-96be-4c67-bb4a-fa22e4ec10e1"

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    environment = "Kan"
  }
 
 }

output "key_vault_id" {
    value       = "${azurerm_key_vault.test-keyvlt.id}"
}
  output "key_vault_url" {
    value     = "${azurerm_key_vault.test-keyvlt.vault_uri}"
}


