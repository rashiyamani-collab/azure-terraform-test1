terraform {
  backend "azurerm" {
    resource_group_name  = "azureterraformtest"
    storage_account_name = "terraformrashiyastate"
    container_name       = "statefilecontainer"
    key                  = "test"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider > 2.x.
  version = ">= 3.50.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "rgsa" {
  name     = "azureterraformtest"
  location = "eastus2"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "rgsa0102-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rgsa.name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rgsa.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.1.0/24"
}
