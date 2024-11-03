#!/bin/bash

# Exit script on any error
set -e

# Define variables
RESOURCE_GROUP="my-azure-resource-group"
AKS_CLUSTER_NAME="my-aks-cluster"
ANSIBLE_PLAYBOOK_PATH="../ansible/playbook.yml"

# Step 1: Initialize and apply Terraform configuration
echo "Initializing Terraform..."
cd ../terraform
terraform init

echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Step 2: Retrieve AKS credentials
echo "Retrieving AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --overwrite-existing

# Step 3: Run Ansible playbook to configure Kubernetes and deploy the app
echo "Running Ansible playbook..."
cd ../ansible
ansible-playbook $ANSIBLE_PLAYBOOK_PATH

# Step 4: Deploy additional services using Helm
echo "Deploying additional services with Helm..."
helm repo update
# Add any Helm deployment commands here, if needed

echo "Deployment completed successfully!"
