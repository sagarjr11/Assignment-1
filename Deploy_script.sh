#!/bin/bash

set -e                           # Exit immediately if a command exits with a non-zero status

echo " ------------------Deployment to staging...---------------------------------"

# Stop existing container if running

EXISTING_CONTAINER=$(docker ps -q --filter "ancestor=yourdockerhubusername/ci-cd-nodejs-app:latest")
if [ -n "$EXISTING_CONTAINER" ]; then
    echo "Stopping existing container..."
    docker stop $EXISTING_CONTAINER
fi

# Run the new container
docker run -d --rm -p 3000:3000 --name nodejs-app yourdockerhubusername/ci-cd-nodejs-app:latest

echo "App deployed and running at http://localhost:3000"
