# Configure the Azure Resource Manager provider
provider "azurerm" {
  features {}
}

# Define the required Terraform version
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}


# Configure the backend to store Terraform state in Azure Storage
# Uncomment and configure this section if you want to use Azure Storage for remote state
# backend "azurerm" {
#   resource_group_name  = "my-terraform-state-rg"
#   storage_account_name = "myterraformstate"
#   container_name       = "tfstate"
#   key                  = "terraform.tfstate"
# }
