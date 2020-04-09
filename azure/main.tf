# Configure the Azure Provider
provider "azurerm" {
  version = "=2.0.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location
}

/* module "policy" {
  source ="../policy"
  rg-name   =azurerm_resource_group.rg.id
  definition_display_name= "test-defination1"
  policy_name = "tera-form2"
} */

module "vnet" {
  source = "./vnet"
  vnet-name =var.vnet-name
  rg-name   =azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}
module "subnet" {
  rg-name   =azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
  source = "./subnet"
  vnet-name =module.vnet.get-name
  subnetName=var.subnetName
  subnetPrefix=var.subnetPrefix #"10.0.0.0/24"
  #"/subscriptions/e149621b-2d3e-499e-af12-b73b3ae66bdb/resourceGroups/storage-mod2/providers/Microsoft.Network/networkSecurityGroups/test"
  nsg-id=var.nsg-id
  vnet-id=module.vnet.get-name
}



/* module "storage" {
  source = "./storage"
  storage_account_name ="terraformstoragemod"
  rg-name         =azurerm_resource_group.rg.name
  location        = azurerm_resource_group.rg.location
  container_name  = "terraformmodaccountcont"
} 

 module "vm" {
    source= "./vm/windows"
    rg-name         =azurerm_resource_group.rg.name
    location        = azurerm_resource_group.rg.location
    subnet-id       = module.vnet.subnet-id
    userName        =var.userName
    password        =var.password
} 
 */
