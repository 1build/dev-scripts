#!/bin/bash

# Step 1: Navigate to the project directory
cd ~/handoff/langgraph || {
    echo "Directory ~/handoff/flatbed does not exist."
    exit 1
}

# Step 2: Pull latest changes
git pull

# Step 3: Set Python version
pyenv global 3.13

# Step 4: Create virtual environment if it doesn't exist
if [ ! -d "env" ]; then
    python3.13 -m venv env
fi

# Step 5: Activate virtual environment
source env/bin/activate

# Step 6: Run the main script
langgraph dev
