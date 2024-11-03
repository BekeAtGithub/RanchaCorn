# Output the LoadBalancer IP address for Grafana
output "grafana_load_balancer_ip" {
  description = "The LoadBalancer IP address for accessing Grafana"
  value       = helm_release.grafana.status[0].load_balancer.ingress[0].ip
}

# Output the LoadBalancer IP address for Prometheus
output "prometheus_load_balancer_ip" {
  description = "The LoadBalancer IP address for accessing Prometheus"
  value       = helm_release.prometheus.status[0].load_balancer.ingress[0].ip
}

# Output the namespace where monitoring resources are deployed
output "monitoring_namespace" {
  description = "The namespace where Prometheus and Grafana are deployed"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}

# Output the status of the Prometheus Helm release
output "prometheus_release_status" {
  description = "The status of the Prometheus Helm release"
  value       = helm_release.prometheus.status
}

# Output the status of the Grafana Helm release
output "grafana_release_status" {
  description = "The status of the Grafana Helm release"
  value       = helm_release.grafana.status
}
