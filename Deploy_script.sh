#!/bin/bash

set -e                           # Exit immediately if a command exits with a non-zero status

echo " ------------------Deployment to staging...---------------------------------"

# Stop existing container if running
docker stop nodejs-container || true
docker rm nodejs-container || true

# Run the new container
docker run -d --rm -p 3000:3000 --name nodejs-app $1

echo "App deployed and running at http://localhost:3000"
