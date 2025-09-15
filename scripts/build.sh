#!/bin/bash
set -e

IMAGE_NAME="cketcham/fantasy-football-mcp-server"
TAG="${1:-latest}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -t "${IMAGE_NAME}:${TAG}" .

echo "Build completed successfully!"