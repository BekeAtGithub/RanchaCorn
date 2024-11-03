# Output the ID of the virtual network
output "virtual_network_id" {
  description = "The ID of the created virtual network"
  value       = azurerm_virtual_network.main.id
}

# Output the name of the virtual network
output "virtual_network_name" {
  description = "The name of the created virtual network"
  value       = azurerm_virtual_network.main.name
}

# Output the address space of the virtual network
output "virtual_network_address_space" {
  description = "The address space of the created virtual network"
  value       = azurerm_virtual_network.main.address_space
}

# Output the ID of the subnet
output "subnet_id" {
  description = "The ID of the created subnet"
  value       = azurerm_subnet.main.id
}

# Output the name of the subnet
output "subnet_name" {
  description = "The name of the created subnet"
  value       = azurerm_subnet.main.name
}

# Output the address prefixes of the subnet
output "subnet_address_prefixes" {
  description = "The address prefixes of the created subnet"
  value       = azurerm_subnet.main.address_prefixes
}
