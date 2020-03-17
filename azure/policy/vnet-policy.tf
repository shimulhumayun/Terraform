resource "azurerm_policy_definition" "definition" {
  name         = "my-policy-definition"
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.definition_display_name

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Network/VirtualNetworks"
          },
          {
            "not": {
              "field": "Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]",
              "equals": "10.0.0.0/24"
            }
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
POLICY_RULE
}


resource "azurerm_policy_assignment" "assignment" {
  name                 = var.policy_name
  scope                = var.rg-name
  policy_definition_id = azurerm_policy_definition.definition.id
  description          = "Policy Assignment"
  display_name         = "My Policy Assignment"

}

output "id" {
  value = azurerm_policy_assignment.assignment.id
}