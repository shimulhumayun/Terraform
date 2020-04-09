resource "azurerm_template_deployment" "subnet" {
  name                = "subnet-01"
  resource_group_name = var.rg-name

  template_body = <<DEPLOY
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "vnetName": {
      "type": "string",
      "defaultValue": "VNet1",
      "metadata": {
        "description": "VNet name"
      }
    },
    "subnetPrefix": {
      "type": "string",
      "defaultValue": "10.0.0.0/24",
      "metadata": {
        "description": "Subnet 1 Prefix"
      }
    },
    "subnetName": {
      "type": "string",
      "defaultValue": "Subnet1",
      "metadata": {
        "description": "Subnet 1 Name"
      }
    },
    "location": {
      "type": "string",
      "metadata": {
        "description": "Location for all resources."
      }
    },
    "nsg-id" :{
        "type":"string"
    }
  },
  "variables": {},
  "resources": [
        {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Network/virtualNetworks/subnets",
      "name": "[concat(parameters('vnetName'), '/', parameters('subnetName'))]",
      "location": "[resourceGroup().location]",
      "properties": {
        "addressPrefix": "[parameters('subnetPrefix')]",
        "networkSecurityGroup":{
            "id":"[parameters('nsg-id')]"
        }
      }
    }
  ],
  "outputs": {
    "subnet-id": {
      "type": "string",
      "value": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('vnetName'), parameters('subnetName'))]"
    }
  }
}
DEPLOY


  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters = {
    "vnetName" = var.vnet-name,
    "subnetName" = var.subnetName,
    "subnetPrefix" = var.subnetPrefix,
    "nsg-id" =var.nsg-id,
    "location" =var.location
  }

  deployment_mode = "Incremental"
}

output "subnet-id" {
  value = azurerm_template_deployment.subnet.outputs["subnet-id"]
}
output "vnet-id" {
  value = var.vnet-id
}