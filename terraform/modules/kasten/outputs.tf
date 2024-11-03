# Output the hostname for accessing the Kasten K10 dashboard
output "kasten_hostname" {
  description = "The hostname to access the Kasten K10 dashboard"
  value       = var.kasten_hostname
}

# Output the namespace where Kasten K10 is deployed
output "kasten_namespace" {
  description = "The namespace where Kasten K10 is deployed"
  value       = kubernetes_namespace.kasten.metadata[0].name
}

# Output the Helm release status for Kasten K10
output "kasten_release_status" {
  description = "The status of the Kasten K10 Helm release"
  value       = helm_release.kasten_k10.status
}
