provider "azurerm" {
 subscription_id = "${var.sub_id}"
/* root provider alias :  1st SPN for TF authenticate again Azure to retrieve key valut SPN  
 client_id       = "??" 
 client_secret   = "??" 
 tenant_id       = "??" */
 alias           = "root"
}

data "azurerm_key_vault_secret" "npnpid" {
provider     = "azurerm.root"
    name = "tf-npnp-id"
    key_vault_id = "/subscriptions/965c8882-db32-486f-83af-1265fc20af06/resourceGroups/Kan-Tst/providers/Microsoft.KeyVault/vaults/Tst19080801"
}
output "secret_value_id" {
  value = "${data.azurerm_key_vault_secret.npnpid.value}"
}

data "azurerm_key_vault_secret" "npnppwd" {
    provider     = "azurerm.root"
    name = "tf-npnp-pwd"
    key_vault_id = "/subscriptions/965c8882-db32-486f-83af-1265fc20af06/resourceGroups/Kan-Tst/providers/Microsoft.KeyVault/vaults/Tst19080801"
}

output "secret_value_pwd" {
  value = "${data.azurerm_key_vault_secret.npnppwd.value}"
}



provider "azurerm" {
 subscription_id = "${var.sub_id}"
 client_id       = "${data.azurerm_key_vault_secret.npnpid.value}" # Secret comes from Azure Keyvault
 client_secret   = "${data.azurerm_key_vault_secret.npnppwd.value}" # Secret comes from Azure Keyvault
 tenant_id       = "${var.tenant_id}"
}
#Create a resource group by thru Key Vault SPN
resource "azurerm_resource_group" "myrg" {
 name     = "${var.resource_group_name}"
 location = "${var.location_name}"
}

