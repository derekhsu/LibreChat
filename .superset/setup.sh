#!/bin/bash
set -e

# Copy .env if it doesn't exist
if [ ! -f .env ]; then
  echo "Copying .env.example to .env..."
  cp .env.example .env
fi

# Install dependencies
echo "Installing dependencies with bun..."
bun install

# Start infrastructure
echo "Starting Docker dependencies..."
# We only start the necessary services, excluding the 'api' itself if we want to run it locally
docker compose up -d mongodb meilisearch vectordb rag_api
