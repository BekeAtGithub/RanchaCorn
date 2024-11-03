#!/bin/bash

# Exit script on any error
set -e

# Define variables
NAMESPACE="monitoring"

# Step 1: Create the namespace for monitoring
echo "Creating namespace for monitoring..."
kubectl create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists"

# Step 2: Add the Prometheus and Grafana Helm repositories
echo "Adding Prometheus and Grafana Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Step 3: Install Prometheus using Helm
echo "Installing Prometheus..."
helm install prometheus prometheus-community/prometheus --namespace $NAMESPACE --set server.service.type=LoadBalancer

# Step 4: Install Grafana using Helm
echo "Installing Grafana..."
helm install grafana grafana/grafana --namespace $NAMESPACE \
  --set adminUser=admin \
  --set adminPassword=admin123 \
  --set service.type=LoadBalancer \
  --set persistence.enabled=true \
  --set persistence.storageClassName=default \
  --set persistence.size=10Gi

# Step 5: Wait for Prometheus and Grafana to be ready
echo "Waiting for Prometheus and Grafana deployments to be ready..."
kubectl rollout status deployment prometheus-server -n $NAMESPACE --timeout=300s
kubectl rollout status deployment grafana -n $NAMESPACE --timeout=300s

# Step 6: Retrieve Grafana LoadBalancer IP
echo "Retrieving Grafana LoadBalancer IP..."
GRAFANA_IP=$(kubectl get svc grafana -n $NAMESPACE -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo "Grafana is accessible at: http://$GRAFANA_IP (Username: admin, Password: admin123)"

# Step 7: Retrieve Prometheus LoadBalancer IP
echo "Retrieving Prometheus LoadBalancer IP..."
PROMETHEUS_IP=$(kubectl get svc prometheus-server -n $NAMESPACE -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo "Prometheus is accessible at: http://$PROMETHEUS_IP"

echo "Monitoring setup completed successfully!"
