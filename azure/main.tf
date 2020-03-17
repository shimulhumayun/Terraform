# Configure the Azure Provider
provider "azurerm" {
  version = "=2.0.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

variable "userName" {
}

variable "password" {
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-mod2"
  location = "East US"
}

/* module "policy" {
  source ="../policy"
  rg-name   =azurerm_resource_group.rg.id
  definition_display_name= "test-defination1"
  policy_name = "tera-form2"
} */

module "vnet" {
  source = "../vnet"
  vnet-name ="vnet-mod"
  rg-name   =azurerm_resource_group.rg.name
}

module "storage" {
  source = "../storage"
  storage_account_name ="terraformstoragemod"
  rg-name         =azurerm_resource_group.rg.name
  location        = azurerm_resource_group.rg.location
  container_name  = "terraformmodaccountcont"
} 

 module "vm" {
    source= "../vm/windows"
    rg-name         =azurerm_resource_group.rg.name
    location        = azurerm_resource_group.rg.location
    subnet-id       = module.vnet.subnet-id
    userName        =var.userName
    password        =var.password
} 

