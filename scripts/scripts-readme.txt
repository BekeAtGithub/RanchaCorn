deploy.sh

set -e: Ensures that the script exits immediately if any command fails.
RESOURCE_GROUP and AKS_CLUSTER_NAME: Variables for your Azure resource group and AKS cluster name. Update these values as needed.
Terraform: The script initializes and applies the Terraform configuration to set up Azure resources.
AKS Credentials: Uses az aks get-credentials to configure kubectl for your AKS cluster.
Ansible Playbook: Runs the Ansible playbook to configure Kubernetes and deploy the application.
Helm: Updates Helm repositories and can include additional Helm deployment commands.

How to use:
Make the script executable:
chmod +x deploy.sh

Run the script:
./deploy.sh


RESOURCE_GROUP and AKS_CLUSTER_NAME: Customize these variables based on your environment.
Helm Commands: Add any additional Helm commands for deploying other services or configuring monitoring, backups, etc.

build-image.sh
set -e: Ensures that the script exits immediately if any command fails.
IMAGE_NAME: The name of your Docker image. Customize this value as needed.
PACKER_TEMPLATE_PATH: Path to your Packer template file that defines how to build the Docker image.
Packer: The script validates the Packer template and then builds the Docker image.
Docker Tagging: Tags the built image with the current date and time for versioning.
How to use: 
chmod +x build-image.sh
./build-image.sh

IMAGE_NAME: Update this to match the name of your Docker image.
Packer Template: Ensure the path to the Packer template is correct.


scripts/configure-ask.sh
set -e: Ensures that the script exits immediately if any command fails.
RESOURCE_GROUP and AKS_CLUSTER_NAME: Variables for your Azure resource group and AKS cluster name. Update these values to match your setup.
az login: Logs in to your Azure account. --use-device-code is used for interactive login.
az aks get-credentials: Retrieves the credentials for your AKS cluster and configures kubectl to use them.
kubectl get nodes: Verifies that kubectl is correctly configured and can connect to your AKS cluster.
usage:
chmod +x configure-aks.sh
./configure-aks.sh

RESOURCE_GROUP and AKS_CLUSTER_NAME: Customize these variables with your Azure resource group and AKS cluster name.
Azure Subscription: If you need to set a specific Azure subscription, uncomment and set the SUBSCRIPTION_ID section.


scripts/setup-argocd.sh
set -e: Ensures that the script exits immediately if any command fails.
NAMESPACE: The namespace where ArgoCD will be installed (argocd by default).
kubectl create namespace: Creates the argocd namespace, or outputs a message if it already exists.
kubectl apply: Installs ArgoCD using the official manifest from the ArgoCD GitHub repository.
kubectl wait: Waits for the ArgoCD server deployment to become available, with a timeout of 300 seconds.
kubectl get secret: Retrieves and decodes the initial admin password for ArgoCD.
kubectl port-forward: Forwards the ArgoCD server port to localhost:8080 so you can access it from your local machine.
how to use:
chmod +x setup-argocd.sh
./setup-argocd.sh

NAMESPACE: If you want to install ArgoCD in a different namespace, update the NAMESPACE variable.
Port Forwarding: You can change the port forwarding settings if necessary.

scripts/setup-monitoring.sh
set -e: Ensures the script exits immediately if any command fails.
NAMESPACE: The namespace used for deploying Prometheus and Grafana (monitoring by default).
kubectl create namespace: Creates the namespace for monitoring, or outputs a message if it already exists.
helm repo add & update: Adds the Prometheus and Grafana Helm repositories and updates them.
helm install: Installs Prometheus and Grafana in the monitoring namespace using Helm, setting the Grafana admin credentials and enabling persistence.
kubectl rollout status: Waits for the Prometheus and Grafana deployments to be ready, with a timeout of 300 seconds.
Retrieving LoadBalancer IPs: Retrieves and prints the LoadBalancer IP addresses for accessing Grafana and Prometheus.
how to use:
chmod +x setup-monitoring.sh
./setup-monitoring.sh

Grafana Credentials: Update the admin username and password to secure values.
Storage Class: Customize the storageClassName if your AKS cluster uses a specific storage class.
LoadBalancer: If your environment does not support LoadBalancer services, you may need to adjust the service type.












