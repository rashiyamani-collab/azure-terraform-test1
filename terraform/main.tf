terraform {
  required_version = ">= 1.5.7"
  backend "azurerm" {
    resource_group_name  = "azureterraformtest"
    storage_account_name = "terraformrashiyastate"
    container_name       = "statefilecontainer"
    key                  = "statefilecontainer.tfstate"
  }
}


provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "azureterraformtest3" {
  name     = "statefilecontainer"
  location = "eastus2"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "tamops-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.azureterraformtest3.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.azureterraformtest3.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}
