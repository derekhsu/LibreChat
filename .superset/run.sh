#!/bin/bash
# Start both API and Client in development mode
echo "Starting backend and frontend..."

# Trap SIGINT and SIGTERM to kill background processes on exit
trap "kill 0" EXIT

bun run b:api:dev &
bun run b:client:dev &

wait
