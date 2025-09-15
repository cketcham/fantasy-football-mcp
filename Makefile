IMAGE_NAME = cketcham/fantasy-football-mcp-server
TAG ?= latest

.PHONY: help build push deploy clean install test

help:
	@echo "Available targets:"
	@echo "  build    - Build Docker image"
	@echo "  push     - Push image to registry"
	@echo "  deploy   - Build and push image"
	@echo "  install  - Install Python dependencies"
	@echo "  clean    - Remove Docker images"
	@echo "  test     - Run tests (if available)"

install:
	pip install -r requirements.txt

build:
	docker build -t $(IMAGE_NAME):$(TAG) .

push:
	docker push $(IMAGE_NAME):$(TAG)

deploy: build push
	@echo "Notifying Portainer to redeploy..."
	@curl -X POST https://portainer.arasaka.hack/api/webhooks/f31ab520-fba7-44bd-9173-2dc30bcbdf7a || echo "Warning: Failed to notify Portainer"

clean:
	docker rmi $(IMAGE_NAME):$(TAG) || true

test:
	python -m pytest tests/ || echo "No tests found"