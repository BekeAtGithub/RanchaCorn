# Variable for the Rancher version to deploy
variable "rancher_version" {
  description = "The version of Rancher to deploy using the Helm chart"
  type        = string
  default     = "2.7.0"  # Update this to the desired Rancher version
}

# Variable for the hostname to access the Rancher UI
variable "rancher_hostname" {
  description = "The fully qualified domain name (FQDN) to access the Rancher UI"
  type        = string
}

# Variable for the email address for Let's Encrypt TLS certificates
variable "letsencrypt_email" {
  description = "The email address used for Let's Encrypt TLS certificate generation"
  type        = string
}

# Variable for tags
variable "tags" {
  description = "A map of tags to add to the Rancher resources"
  type        = map(string)
  default     = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
