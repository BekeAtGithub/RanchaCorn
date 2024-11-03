#!/bin/bash

# Navigate to the app directory
cd /app

# Install Python dependencies from requirements.txt
pip install --no-cache-dir -r requirements.txt

# Make sure the app starts properly
echo "Application setup complete. You can now run the app using Uvicorn."
