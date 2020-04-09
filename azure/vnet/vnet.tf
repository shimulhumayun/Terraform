resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg-name
}


/* resource "azurerm_subnet" "vnet-subnet" {
  name                 = join("",[var.vnet-name,"-subnet"])
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.2.0/24"
}

data "azurerm_network_security_group" "example" {
  name                = "test"
  resource_group_name = "storage-mod2"
}


resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.vnet-subnet.id
  network_security_group_id = data.azurerm_network_security_group.example.id
} 
 */

output "get-name" {
   value = azurerm_virtual_network.vnet.name
}

