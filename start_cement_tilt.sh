#!/bin/bash

# Step 1: Navigate to the project directory
cd ~/handoff/cement || {
    echo "Directory ~/handoff/cement does not exist."
    exit 1
}

# Step 2: Pull latest changes
git pull

# Step 3: Start infra (Postgres and Redis)
echo "Starting infra (Postgres and Redis) with Tilt..."
echo "This will block the terminal. Open a new terminal for the next steps."
tilt up -- --infra-only