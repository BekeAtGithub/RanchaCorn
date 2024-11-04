***###*** WELCOME ***###***
# EACH DIRECTORY HAS ITS OWN SEPARATE README FOR MORE SPECIFIC INFO ON EACH COMPONENT
```
/project-root
│
├── /app
│   ├── app.py                      # Your FastAPI app
│   ├── requirements.txt            # Python dependencies
│   ├── Dockerfile                  # Dockerfile to containerize the app
│   ├── /tests                      # Directory for unit and integration tests
│       ├── test_app.py             # Example test file
│
├── /terraform
│   ├── main.tf                     # Main Terraform configuration
│   ├── variables.tf                # Variable definitions
│   ├── outputs.tf                  # Output definitions
│   ├── provider.tf                 # Cloud provider configuration
│   ├── aks-cluster.tf              # AKS cluster configuration
│   ├── rancher-setup.tf            # Rancher setup configuration
│   ├── kasten-backup.tf            # Veeam Kasten backup setup
│   ├── monitoring.tf               # Prometheus and Grafana setup
│   ├── /modules                    # Directory for reusable Terraform modules
│       ├── /networking             # Networking module
│           ├── main.tf             # Networking setup (VNet, subnets, etc.)
│           ├── variables.tf        # Variables for networking
│           ├── outputs.tf          # Outputs for networking
│       ├── /aks                    # AKS module
│           ├── main.tf             # AKS-specific configuration
│           ├── variables.tf        # Variables for AKS
│           ├── outputs.tf          # Outputs for AKS
│       ├── /rancher                # Rancher setup module
│           ├── main.tf             # Rancher-specific configuration
│           ├── variables.tf        # Variables for Rancher
│           ├── outputs.tf          # Outputs for Rancher
│       ├── /kasten                 # Veeam Kasten module
│           ├── main.tf             # Kasten-specific configuration
│           ├── variables.tf        # Variables for Kasten
│           ├── outputs.tf          # Outputs for Kasten
│       ├── /monitoring             # Monitoring setup module
│           ├── main.tf             # Prometheus and Grafana configuration
│           ├── variables.tf        # Variables for monitoring
│           ├── outputs.tf          # Outputs for monitoring
│
├── /packer
│   ├── app-image.json              # Packer template to build the app image
│   ├── /scripts                    # Directory for build scripts
│       ├── install-dependencies.sh # Script to install dependencies
│       ├── setup-app.sh            # Script to setup the app
│
├── /ansible
│   ├── playbook.yml                # Ansible playbook for configuration
│   ├── /roles                      # Directory for Ansible roles
│       ├── /app-deployment         # Role for app deployment
│           ├── tasks               # Tasks for app deployment
│               ├── main.yml        # Main task file for app deployment
│           ├── templates           # Templates for configuration files
│               ├── app-config.j2   # Example Jinja2 template
│           ├── handlers            # Handlers for app deployment
│               ├── main.yml        # Handlers for notifications
│       ├── /k8s-configuration      # Role for Kubernetes configuration
│           ├── tasks               # Tasks for Kubernetes configuration
│               ├── main.yml        # Main task file for K8s configuration
│           ├── files               # Static files for configuration
│           ├── templates           # Templates for K8s manifests
│       ├── /kasten-setup           # Role for setting up Veeam Kasten
│           ├── tasks               # Tasks for Kasten setup
│               ├── main.yml        # Main task file for Kasten setup
│           ├── templates           # Templates for Kasten configuration
│       ├── /monitoring-setup       # Role for Prometheus and Grafana setup
│           ├── tasks               # Tasks for monitoring setup
│               ├── main.yml        # Main task file for monitoring
│           ├── templates           # Templates for monitoring configuration
│
├── /scripts
│   ├── deploy.sh                   # Shell script to orchestrate deployment
│   ├── build-image.sh              # Shell script to build Docker image using Packer
│   ├── configure-aks.sh            # Script to configure AKS cluster
│   ├── setup-argocd.sh             # Script to setup ArgoCD
│   ├── setup-monitoring.sh         # Script to setup Prometheus and Grafana
│
├── /rancher
│   ├── rancher-config.yml          # Rancher configuration file
│   ├── cluster-setup.sh            # Script to set up Rancher and AKS
│
├── /k8s
│   ├── deployment.yml              # Kubernetes Deployment manifest
│   ├── service.yml                 # Kubernetes Service manifest
│   ├── ingress.yml                 # Kubernetes Ingress manifest
│   ├── kasten-backup.yml           # Veeam Kasten backup configuration
│   ├── prometheus.yml              # Prometheus configuration
│   ├── grafana.yml                 # Grafana configuration
│
├── /helm
│   ├── Chart.yaml                  # Helm chart configuration
│   ├── values.yaml                 # Default values for Helm chart
│   ├── /templates                  # Helm templates for Kubernetes resources
│       ├── deployment.yaml         # Helm template for Deployment
│       ├── service.yaml            # Helm template for Service
│       ├── ingress.yaml            # Helm template for Ingress
│
├── /argocd
│   ├── app-config.yml              # ArgoCD application configuration
│   ├── project-config.yml          # ArgoCD project configuration
│
├── /monitoring
│   ├── prometheus-config.yml       # Prometheus custom configuration
│   ├── grafana-dashboards/         # Directory for Grafana dashboards
│       ├── dashboard1.json         # Sample Grafana dashboard JSON
│       ├── dashboard2.json         # Another Grafana dashboard JSON
│
├── .gitignore                      # Git ignore file
├── README.md                       # Documentation for the project
├── terraform.tfvars                # Terraform variables file
└── ansible.cfg                     # Ansible configuration file
```


# FastAPI Application on AKS

This repository contains a FastAPI application deployed on Azure Kubernetes Service (AKS). It includes configurations for infrastructure provisioning using Terraform, application deployment with Ansible, and monitoring with Prometheus and Grafana.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Monitoring](#monitoring)
- [Backup](#backup)
- [License](#license)

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed
- [Helm](https://helm.sh/docs/intro/install/) installed
- [Terraform](https://www.terraform.io/downloads.html) installed
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed
- A GitHub account and a repository for your application

## Installation

1. **Clone the repository**:
   ```
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

2. **Configure Azure resources**:
   - Update the Terraform configuration files in the `/terraform` directory with your Azure credentials and desired resource configurations.
   - Run the following command to initialize and apply the Terraform configuration:
     ```
     cd terraform
     terraform init
     terraform apply
     ```

3. **Deploy the FastAPI application**:
   - Set up your AKS credentials:
     ```
     az aks get-credentials --resource-group your-resource-group --name your-aks-cluster
     ```
   - Use Ansible to deploy the application:
     ```
     cd ansible
     ansible-playbook playbook.yml
     ```

4. **Install Prometheus and Grafana for monitoring**:
   - Use the provided scripts in the `/scripts` directory to set up monitoring:
     ```
     ./scripts/setup-monitoring.sh
     ```

## Usage

- Access the FastAPI application using the LoadBalancer IP assigned by the Kubernetes Service:
  ```
  http://<LOAD_BALANCER_IP>
  ```
- Access the Grafana dashboard using the LoadBalancer IP assigned to the Grafana Service:
  ```
  http://<GRAFANA_LOAD_BALANCER_IP>
  ```

## Configuration

- Modify the configuration files in the `/helm` directory to customize the Helm chart settings (e.g., image repository, service type).
- Update values in the `values.yaml` file to customize application settings, resource limits, and environment variables.

## Monitoring

- Prometheus is set up to scrape metrics from Kubernetes components. Modify the Prometheus configuration in the `/monitoring/prometheus-config.yml` file if needed.
- Grafana dashboards can be found in the `/monitoring/grafana-dashboards` directory. Import these JSON files into Grafana for visualization.

## Backup

- Veeam Kasten K10 is configured for backups. Check the `/k8s/kasten-backup.yml` file for details on backup profiles and policies.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

### Customization:
- Replace placeholders like `your-username`, `your-repo`, `your-resource-group`, and `your-aks-cluster` with actual values relevant to your setup.
- Modify sections as needed to fit your project's specific requirements and additional features.


