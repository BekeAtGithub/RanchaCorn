# Output the Rancher hostname for accessing the UI
output "rancher_hostname" {
  description = "The hostname to access the Rancher UI"
  value       = var.rancher_hostname
}

# Output the namespace where Rancher is deployed
output "rancher_namespace" {
  description = "The namespace where Rancher is deployed"
  value       = kubernetes_namespace.rancher.metadata[0].name
}

# Output the Helm release status for Rancher
output "rancher_release_status" {
  description = "The status of the Rancher Helm release"
  value       = helm_release.rancher.status
}
