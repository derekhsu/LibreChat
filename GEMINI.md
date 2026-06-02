# LibreChat Workspace Instructions

This repository is configured for development using **Superset** and **Bun**.

## Workspace Lifecycle

The following scripts in `.superset/` manage the workspace state:

- **Setup**: `bash .superset/setup.sh`
  - Initializes `.env` for local development.
  - Automatically maps Docker ports (27017, 7700, 8000) to host via `docker-compose.override.yml`.
  - Installs dependencies with `bun install`.
  - Starts core infrastructure (MongoDB, Meilisearch, RAG API) via Docker Compose.
- **Run**: `bash .superset/run.sh`
  - Starts backend and frontend development servers in parallel.
- **Teardown**: `docker compose down`
  - Cleans up all Docker resources.

## Development Stack

- **Runtime**: [Bun](https://bun.sh/) (preferred over npm/yarn).
- **Monorepo**: [Turborepo](https://turbo.build/).
- **Infrastructure**: Docker Compose (MongoDB, Meilisearch, pgvector).
- **Frontend**: React + Vite + Tailwind CSS.
- **Backend**: Node.js (Express).

## Key Commands

- `bun install`: Install all dependencies.
- `bun run b:api:dev`: Start backend in dev mode.
- `bun run b:client:dev`: Start frontend in dev mode.
- `docker compose up -d`: Start all services.
