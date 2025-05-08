#!/bin/bash

# Step 1: Navigate to the project directory
cd ~/handoff/flatbed || {
    echo "Directory ~/handoff/flatbed does not exist."
    exit 1
}

# Step 2: Set Python version
pyenv global 3.10

# Step 3: Create virtual environment if it doesn't exist
if [ ! -d "env" ]; then
    python3.10 -m venv env
fi

# Step 4: Activate virtual environment
source env/bin/activate

# Step 5: Run the main script
python3 main.py
