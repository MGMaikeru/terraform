provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "vm_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "vm" {
  source              = "./modules/vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_password      = var.admin_password
  subnet_id          = module.network.subnet_id
}

module "network" {
  source              = "./modules/network"
  location            = var.location
  resource_group_name = var.resource_group_name
}