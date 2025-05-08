#!/bin/bash

# Step 1: Navigate to the project directory
cd ~/handoff/cement || {
    echo "Directory ~/handoff/cement does not exist."
    exit 1
}

# Step 2: Pull latest changes
git pull
npm install

# Step 3: Generate resources and run migrations
echo "Generating resources and running migrations..."
npm run generate && npm run migrate:dev

# Step 4: Start the app
echo "Starting the app..."
npm run dev
