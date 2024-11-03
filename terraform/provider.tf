# Configure the Azure Resource Manager provider
provider "azurerm" {
  features {}
}

# Configure the backend to store Terraform state in Azure Storage
# Uncomment and configure this section if you want to use Azure Storage for remote state
# backend "azurerm" {
#   resource_group_name  = "my-terraform-state-rg"
#   storage_account_name = "myterraformstate"
#   container_name       = "tfstate"
#   key                  = "terraform.tfstate"
# }
