# Variable for the virtual network name
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

# Variable for the Azure region
variable "location" {
  description = "The Azure region where the virtual network will be created"
  type        = string
}

# Variable for the resource group name
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# Variable for the address space of the virtual network
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"] # You can customize this address space
}

# Variable for the subnet name
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

# Variable for the subnet address prefixes
variable "subnet_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"] # You can customize this subnet prefix
}

# Variable for tags
variable "tags" {
  description = "A map of tags to add to the networking resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
