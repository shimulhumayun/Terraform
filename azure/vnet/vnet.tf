resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg-name
}

resource "azurerm_subnet" "vnet-subnet" {
  name                 = join("",[var.vnet-name,"-subnet"])
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.2.0/24"
}

output "subnet-id" {
   value = azurerm_subnet.vnet-subnet.id 
}

