# Create a namespace for Kasten K10
resource "kubernetes_namespace" "kasten" {
  metadata {
    name = "kasten-io"
  }
}

# Deploy Kasten K10 using a Helm chart
resource "helm_release" "kasten_k10" {
  name       = "kasten-k10"
  namespace  = kubernetes_namespace.kasten.metadata[0].name
  chart      = "k10"
  repository = "https://charts.kasten.io/"
  version    = var.kasten_version

  values = [
    <<EOF
global:
  k10:
    ingress:
      enabled: true
      host: "${var.kasten_hostname}"
  prometheus:
    monitoring: true
EOF
  ]

  set {
    name  = "global.persistence.storageClass"
    value = var.storage_class
  }

  set {
    name  = "auth.tokenAuth.enabled"
    value = "true"
  }

  depends_on = [azurerm_kubernetes_cluster.aks]
}

# Output the Kasten K10 hostname
output "kasten_hostname" {
  description = "The hostname for accessing the Kasten K10 dashboard"
  value       = var.kasten_hostname
}
