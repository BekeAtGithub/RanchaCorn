#!/bin/bash

# Exit script on any error
set -e

# Define variables
IMAGE_NAME="my-fastapi-app"
PACKER_TEMPLATE_PATH="../packer/app-image.json"

# Step 1: Validate the Packer template
echo "Validating Packer template..."
packer validate $PACKER_TEMPLATE_PATH

# Step 2: Build the Docker image using Packer
echo "Building Docker image with Packer..."
packer build $PACKER_TEMPLATE_PATH

# Step 3: Tag the Docker image
echo "Tagging the Docker image..."
docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:$(date +%Y%m%d%H%M)

echo "Docker image built and tagged successfully!"
