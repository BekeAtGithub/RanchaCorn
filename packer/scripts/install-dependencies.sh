#!/bin/bash

# Update the package list
apt-get update

# Install essential build tools
apt-get install -y --no-install-recommends build-essential

# Clean up to reduce the image size
apt-get clean
rm -rf /var/lib/apt/lists/*
