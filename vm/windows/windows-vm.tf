resource "azurerm_public_ip" "pub-ip" {
  name                = "acceptanceTestPublicIp1"
  location            = var.location
  resource_group_name = var.rg-name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}
resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub-ip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "example-machine"
  resource_group_name = var.rg-name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.userName
  admin_password      = var.password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "Custom-Extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
      "fileUris"        : ["https://raw.githubusercontent.com/shimulhumayun/customscript/master/postdeployment.ps1"],
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File postdeployment.ps1",
      "managedIdentity" : {}
    }
SETTINGS


  tags = {
    environment = "Production"
  }
}