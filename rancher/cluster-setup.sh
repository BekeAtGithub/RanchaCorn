#!/bin/bash

# Exit script on any error
set -e

# Define variables
RANCHER_URL="https://rancher.your-domain.com"  # Replace with your Rancher URL
RANCHER_API_TOKEN="your-rancher-api-token"     # Replace with your Rancher API token
RANCHER_CLUSTER_CONFIG_PATH="./rancher-config.yml"

# Step 1: Log in to Rancher using the API token
echo "Logging in to Rancher..."
curl -s --insecure -H "Authorization: Bearer $RANCHER_API_TOKEN" "$RANCHER_URL/v3" > /dev/null
if [ $? -ne 0 ]; then
  echo "Failed to log in to Rancher. Please check your API token and URL."
  exit 1
fi

# Step 2: Apply the Rancher cluster configuration
echo "Applying Rancher cluster configuration..."
kubectl apply -f $RANCHER_CLUSTER_CONFIG_PATH

# Step 3: Wait for the AKS cluster to be ready in Rancher
echo "Waiting for the AKS cluster to be provisioned in Rancher..."
sleep 10  # Initial wait before polling

for i in {1..30}; do
  STATUS=$(curl -s --insecure -H "Authorization: Bearer $RANCHER_API_TOKEN" "$RANCHER_URL/v3/clusters" | jq -r '.data[] | select(.name=="aks-cluster") | .state')
  
  if [ "$STATUS" == "active" ]; then
    echo "AKS cluster is now active in Rancher!"
    break
  else
    echo "Cluster status: $STATUS. Waiting for it to become active..."
    sleep 30
  fi

  if [ $i -eq 30 ]; then
    echo "Timeout waiting for the AKS cluster to become active."
    exit 1
  fi
done

echo "Rancher AKS cluster setup completed successfully!"
