# Variable for the Kasten K10 version to deploy
variable "kasten_version" {
  description = "The version of Kasten K10 to deploy using the Helm chart"
  type        = string
  default     = "5.0.0" # Update this to the desired Kasten version
}

# Variable for the hostname to access the Kasten K10 dashboard
variable "kasten_hostname" {
  description = "The fully qualified domain name (FQDN) to access the Kasten K10 dashboard"
  type        = string
}

# Variable for the storage class to be used by Kasten K10
variable "storage_class" {
  description = "The storage class for persistent volumes used by Kasten K10"
  type        = string
  default     = "default" # Update this to the appropriate storage class in your AKS cluster
}

# Variable for tags
variable "tags" {
  description = "A map of tags to add to the Kasten K10 resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
