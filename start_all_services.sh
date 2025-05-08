#!/bin/bash

# Define the script directory
SCRIPT_DIR="/Users/fk/handoff/dev-server-scripts"

# Function to check if a script exists
check_script() {
    if [ ! -f "$1" ]; then
        echo "Error: Script $1 does not exist."
        exit 1
    fi
}

# Check if all required scripts exist
check_script "$SCRIPT_DIR/start_cement_tilt.sh"
check_script "$SCRIPT_DIR/start_cement_dev.sh"
check_script "$SCRIPT_DIR/start_flatbed.sh"
check_script "$SCRIPT_DIR/start_langgraph.sh"

# Make sure all scripts are executable
chmod +x "$SCRIPT_DIR/start_cement_tilt.sh"
chmod +x "$SCRIPT_DIR/start_cement_dev.sh"
chmod +x "$SCRIPT_DIR/start_flatbed.sh"
chmod +x "$SCRIPT_DIR/start_langgraph.sh"

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed. Please install it using 'brew install tmux'."
    exit 1
fi

# Kill any existing tmux session with the same name
tmux kill-session -t dev-services 2>/dev/null || true

# Start a new tmux session with a single window
tmux new-session -d -s dev-services -n "Services"

# Create a 2x2 grid layout for the services
# Start with Flatbed in the top-left pane
tmux send-keys -t dev-services "echo 'Starting Flatbed...' && $SCRIPT_DIR/start_flatbed.sh" Enter

# Create top-right pane for LangGraph
tmux split-window -h
tmux send-keys "echo 'Starting LangGraph...' && $SCRIPT_DIR/start_langgraph.sh" Enter

# Create bottom-left pane for Cement Tilt (split from top-left)
tmux select-pane -t 0
tmux split-window -v
tmux send-keys "echo 'Starting Cement Tilt...' && $SCRIPT_DIR/start_cement_tilt.sh" Enter

# Create bottom-right pane for Cement Dev (split from top-right)
tmux select-pane -t 1
tmux split-window -v
tmux send-keys "echo 'Waiting for other services to initialize...' && sleep 10 && echo 'Starting Cement Dev (last service)...' && $SCRIPT_DIR/start_cement_dev.sh" Enter

# Attach to the tmux session
tmux attach-session -t dev-services

echo "All services started in tmux session 'dev-services'."
