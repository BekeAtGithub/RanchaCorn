#!/bin/bash

# Exit script on any error
set -e

# Define variables
RESOURCE_GROUP="my-azure-resource-group"
AKS_CLUSTER_NAME="my-aks-cluster"

# Step 1: Log in to Azure
echo "Logging in to Azure..."
az login --use-device-code

# Step 2: Set the Azure subscription (if needed)
# Uncomment and set your subscription ID if required
# SUBSCRIPTION_ID="your-subscription-id"
# az account set --subscription $SUBSCRIPTION_ID

# Step 3: Retrieve AKS credentials
echo "Retrieving AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --overwrite-existing

# Step 4: Verify the AKS connection
echo "Verifying AKS connection..."
kubectl get nodes

echo "AKS cluster configuration completed successfully!"
