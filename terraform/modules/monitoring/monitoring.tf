# Create a namespace for Prometheus and Grafana
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Deploy Prometheus using a Helm chart
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = var.prometheus_version

  values = [
    <<EOF
server:
  service:
    type: "LoadBalancer"
EOF
  ]

  depends_on = [azurerm_kubernetes_cluster.main]
}

# Deploy Grafana using a Helm chart
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  version    = var.grafana_version

  values = [
    <<EOF
adminUser: "${var.grafana_admin_user}"
adminPassword: "${var.grafana_admin_password}"
service:
  type: "LoadBalancer"
persistence:
  enabled: true
  storageClassName: "${var.storage_class}"
  size: "10Gi"
EOF
  ]

  set {
    name  = "grafana.ini.security.admin_user"
    value = var.grafana_admin_user
  }

  set {
    name  = "grafana.ini.security.admin_password"
    value = var.grafana_admin_password
  }

  depends_on = [azurerm_kubernetes_cluster.main]
}

# Output the LoadBalancer IP for Grafana
output "grafana_load_balancer_ip" {
  description = "The LoadBalancer IP address for accessing Grafana"
  value       = helm_release.grafana.status[0].load_balancer.ingress[0].ip
}

# Output the LoadBalancer IP for Prometheus
output "prometheus_load_balancer_ip" {
  description = "The LoadBalancer IP address for accessing Prometheus"
  value       = helm_release.prometheus.status[0].load_balancer.ingress[0].ip
}
