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

# Output the Rancher hostname
output "rancher_hostname" {
  description = "The hostname for accessing the Rancher UI"
  value       = var.rancher_hostname
}

output "grafana_load_balancer_ip" {
  value = length(helm_release.grafana.status) > 0 && length(helm_release.grafana.status[0].load_balancer.ingress) > 0 ? helm_release.grafana.status[0].load_balancer.ingress[0].ip : null
}

output "prometheus_load_balancer_ip" {
  value = length(helm_release.prometheus.status) > 0 && length(helm_release.prometheus.status[0].load_balancer.ingress) > 0 ? helm_release.prometheus.status[0].load_balancer.ingress[0].ip : null
}


# Output the Kasten K10 hostname
output "kasten_hostname" {
  description = "The hostname for accessing the Kasten K10 dashboard"
  value       = var.kasten_hostname
}

# Output the AKS cluster details
output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_kube_config" {
  description = "The Kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}
