#!/bin/bash
set -e

IMAGE_NAME="cketcham/fantasy-football-mcp-server"
TAG="${1:-latest}"
PORTAINER_WEBHOOK="https://portainer.arasaka.hack/api/webhooks/f31ab520-fba7-44bd-9173-2dc30bcbdf7a"

echo "Building and deploying: ${IMAGE_NAME}:${TAG}"

# Build the image
./scripts/build.sh "${TAG}"

# Push to registry
echo "Pushing image to registry..."
docker push "${IMAGE_NAME}:${TAG}"

# Notify Portainer to redeploy
echo "Notifying Portainer to redeploy..."
curl -X POST "${PORTAINER_WEBHOOK}" || echo "Warning: Failed to notify Portainer"

echo "Deploy completed successfully!"