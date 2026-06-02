#!/bin/bash
set -e

# Copy .env if it doesn't exist
if [ ! -f .env ]; then
  echo "Copying .env.example to .env..."
  cp .env.example .env
  
  # Update .env for host-side development
  echo "Configuring .env for localhost services..."
  sed -i '' 's|MONGO_URI=mongodb://127.0.0.1:27017/LibreChat|MONGO_URI=mongodb://localhost:27017/LibreChat|g' .env
  sed -i '' 's|# MEILI_HOST=http://0.0.0.0:7700|MEILI_HOST=http://localhost:7700|g' .env
  sed -i '' 's|# RAG_API_URL=http://rag_api:8000|RAG_API_URL=http://localhost:8000|g' .env
fi

# Create a temporary docker-compose.override.yml for Superset if it doesn't exist
# This ensures ports are mapped so the host-side dev server can reach the containers
if [ ! -f docker-compose.override.yml ]; then
  echo "Creating docker-compose.override.yml for port mapping..."
  cat <<EOF > docker-compose.override.yml
services:
  mongodb:
    ports:
      - "27017:27017"
  meilisearch:
    ports:
      - "7700:7700"
  rag_api:
    ports:
      - "8000:8000"
EOF
fi

# Install dependencies
echo "Installing dependencies with bun..."
bun install

# Start infrastructure
echo "Starting Docker dependencies..."
docker compose up -d mongodb meilisearch vectordb rag_api
