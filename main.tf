provider "azurerm" {
  features {}
# test change ssh permit
  # Specify the subscription ID
  subscription_id = "ef17a603-a390-49bd-946c-cc18aa67f388"

  # Optionally, specify tenant_id, client_id, and client_secret if not using Azure CLI for authentication
  # tenant_id       = "<your-tenant-id>"
  # client_id       = "<your-client-id>"
  # client_secret   = "<your-client-secret>"
}
resource "azurerm_resource_group" "rg_pocimport" {
  name     = "rg-terraform-pocimport"
  location = "westeurope"
}
resource "azurerm_virtual_network" "vnet-terra" {
  name                = "vnet-terra"
  location            = "westeurope"
  resource_group_name = "rg-terraform-pocimport"
  address_space       = ["10.0.0.0/16"]

  tags = {}
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_virtual_network.vnet-terra.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-terra.name
  address_prefixes     = ["10.0.0.0/24"]

  private_endpoint_network_policies = "Disabled"
  private_link_service_network_policies_enabled = true
}

