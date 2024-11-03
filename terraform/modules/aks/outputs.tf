# Output the name of the AKS cluster
output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.name
}

# Output the ID of the AKS cluster
output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.id
}

# Output the Kubernetes version of the AKS cluster
output "aks_kubernetes_version" {
  description = "The Kubernetes version running on the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kubernetes_version
}

# Output the system-assigned managed identity principal ID
output "aks_identity_principal_id" {
  description = "The principal ID of the AKS system-assigned managed identity"
  value       = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

# Output the kubeconfig for the AKS cluster
output "kube_config" {
  description = "The kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}

# Output the FQDN of the AKS API server
output "aks_api_server_fqdn" {
  description = "The fully qualified domain name of the AKS API server"
  value       = azurerm_kubernetes_cluster.main.fqdn
}
