# Output the name of the resource group
output "resource_group_name" {
  description = "The name of the created Azure resource group"
  value       = azurerm_resource_group.main.name
}

# Output the name of the virtual network
output "virtual_network_name" {
  description = "The name of the created Azure virtual network"
  value       = azurerm_virtual_network.main.name
}

# Output the name of the subnet
output "subnet_name" {
  description = "The name of the created Azure subnet"
  value       = azurerm_subnet.main.name
}
