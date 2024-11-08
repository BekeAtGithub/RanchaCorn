# Variable for the Prometheus Helm chart version
variable "prometheus_version" {
  description = "The version of Prometheus to deploy using the Helm chart"
  type        = string
  default     = "15.10.0" # Update to the desired version
}

# Variable for the Grafana Helm chart version
variable "grafana_version" {
  description = "The version of Grafana to deploy using the Helm chart"
  type        = string
  default     = "6.19.0" # Update to the desired version
}

# Variable for the Grafana admin user
variable "grafana_admin_user" {
  description = "The admin username for accessing Grafana"
  type        = string
  default     = "admin" # Change this to a more secure username in production
}

# Variable for the Grafana admin password
variable "grafana_admin_password" {
  description = "The admin password for accessing Grafana"
  type        = string
  sensitive   = true
  default     = "admin123" # Change this to a secure password in production
}

# Variable for the storage class used by Grafana
variable "storage_class" {
  description = "The storage class for persistent volumes used by Grafana"
  type        = string
  default     = "default" # Update to the appropriate storage class in your AKS cluster
}

# Variable for tags
variable "tags" {
  description = "A map of tags to add to the monitoring resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
