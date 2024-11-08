# Variable for the Azure resource group name
variable "resource_group_name" {
  description = "The name of the resource group to create"
  type        = string
  default     = "my-azure-resource-group" # You can change this to a more meaningful name
}

# Variable for the Azure region
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US" # You can adjust this to your preferred Azure region
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
  default     = 3 # Set a default value if applicable
}

variable "node_vm_size" {
  description = "The size of the virtual machine for the AKS nodes"
  type        = string
  default     = "Standard_DS2_v2" # Set a default value if applicable
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, production)"
  type        = string
  default     = "dev" # Optional: Set a default value if applicable
}

variable "kasten_version" {
  description = "The version of Veeam Kasten K10 to deploy"
  type        = string
  default     = "latest" # Optional: Set a default value if applicable
}

variable "kasten_hostname" {
  description = "The hostname for Veeam Kasten K10 deployment"
  type        = string
  default     = "kasten.example.com" # Optional: Set a default value if applicable
}

variable "storage_class" {
  description = "The storage class to be used for persistent volumes"
  type        = string
  default     = "standard" # Optional: Set a default value if applicable
}

variable "prometheus_version" {
  description = "The version of Prometheus to deploy"
  type        = string
  default     = "latest" # Optional: Set a default value if applicable
}

variable "grafana_version" {
  description = "The version of Grafana to deploy"
  type        = string
  default     = "latest" # Optional: Set a default value if applicable
}

variable "grafana_admin_user" {
  description = "The admin username for Grafana"
  type        = string
  default     = "admin" # Optional: Set a default value if applicable
}

variable "grafana_admin_password" {
  description = "The admin password for Grafana"
  type        = string
  sensitive   = true # Marking as sensitive to avoid logging the password
}

variable "rancher_version" {
  description = "The version of Rancher to deploy"
  type        = string
  default     = "latest" # Optional: Set a default value if applicable
}

variable "rancher_hostname" {
  description = "The hostname for the Rancher deployment"
  type        = string
  default     = "rancher.example.com" # Optional: Set a default value if applicable
}

variable "letsencrypt_email" {
  description = "The email address used for Let's Encrypt certificate notifications"
  type        = string
  default     = "your-email@example.com" # Optional: Set a default value if applicable
}
