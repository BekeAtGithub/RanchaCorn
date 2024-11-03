#!/bin/bash

# Exit script on any error
set -e

# Define variables
NAMESPACE="argocd"

# Step 1: Create the ArgoCD namespace
echo "Creating ArgoCD namespace..."
kubectl create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists"

# Step 2: Install ArgoCD using the official manifest
echo "Installing ArgoCD..."
kubectl apply -n $NAMESPACE -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 3: Wait for ArgoCD server to be ready
echo "Waiting for ArgoCD server to be ready..."
kubectl wait --namespace $NAMESPACE --for=condition=available deployment/argocd-server --timeout=300s

# Step 4: Retrieve the ArgoCD initial admin password
echo "Retrieving ArgoCD initial admin password..."
kubectl get secret argocd-initial-admin-secret -n $NAMESPACE -o jsonpath="{.data.password}" | base64 --decode; echo

# Step 5: Forward the ArgoCD server port for local access
echo "Forwarding ArgoCD server port..."
kubectl port-forward svc/argocd-server -n $NAMESPACE 8080:443 &

echo "ArgoCD setup completed successfully!"
echo "Access ArgoCD at https://localhost:8080"
echo "Use the initial admin password retrieved above to log in."
