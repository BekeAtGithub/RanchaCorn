# Variable for the Azure resource group name
variable "resource_group_name" {
  description = "The name of the resource group to create"
  type        = string
  default     = "my-azure-resource-group"  # You can change this to a more meaningful name
}

# Variable for the Azure region
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"  # You can adjust this to your preferred Azure region
}
