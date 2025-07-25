#!/bin/bash
echo "Simulating deployment to staging..."
docker run -d -p 3000:3000 yourdockerhubusername/ci-cd-nodejs-app:latest
