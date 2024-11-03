# Create a namespace for Rancher
resource "kubernetes_namespace" "rancher" {
  metadata {
    name = "cattle-system"
  }
}

# Deploy Rancher using a Helm chart
resource "helm_release" "rancher" {
  name       = "rancher"
  namespace  = kubernetes_namespace.rancher.metadata[0].name
  chart      = "rancher"
  repository = "https://releases.rancher.com/server-charts/stable"
  version    = var.rancher_version

  values = [
    <<EOF
replicas: 3
hostname: "${var.rancher_hostname}"
ingress:
  tls:
    source: "letsEncrypt"
    letsEncrypt:
      email: "${var.letsencrypt_email}"
      environment: "production"
EOF
  ]

  set {
    name  = "replicas"
    value = "3"
  }

  set {
    name  = "hostname"
    value = var.rancher_hostname
  }

  depends_on = [azurerm_kubernetes_cluster.aks]
}

