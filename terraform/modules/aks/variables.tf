# Variable for the AKS cluster name
variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

# Variable for the Azure region
variable "location" {
  description = "The Azure region where the AKS cluster will be created"
  type        = string
}

# Variable for the resource group name
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# Variable for the DNS prefix of the AKS cluster
variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

# Variable for the number of nodes in the default node pool
variable "node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 3 # You can adjust this value as needed
}

# Variable for the VM size of the nodes in the default node pool
variable "node_vm_size" {
  description = "The VM size for the AKS nodes"
  type        = string
  default     = "Standard_DS2_v2" # You can customize this based on your needs
}

# Variable for the subnet ID
variable "subnet_id" {
  description = "The ID of the subnet where the AKS nodes will be deployed"
  type        = string
}

# Variable for the Log Analytics workspace ID
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for monitoring"
  type        = string
}

# Variable for tags
variable "tags" {
  description = "A map of tags to add to the AKS resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
