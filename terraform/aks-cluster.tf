# Create an Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.resource_group_name}-aks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.resource_group_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/16"
  }

  tags = {
    Environment = var.environment
  }
}

