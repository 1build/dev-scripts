# Development Server Scripts

This repository contains scripts for starting and managing development environments for various projects in the Handoff ecosystem.

(https://www.loom.com/share/3946962bad9a40eb94c8eabd237b7602)

## Available Scripts

### `start_all_services.sh`

Starts all services in a tmux session with a 2x2 grid layout:

- **Top-Left**: Flatbed
- **Top-Right**: LangGraph
- **Bottom-Left**: Cement Tilt (infrastructure)
- **Bottom-Right**: Cement Dev

```bash
./start_all_services.sh
```

### Individual Service Scripts

#### `start_cement_dev.sh`

Starts the Cement development server:

- Navigates to the Cement directory
- Pulls latest changes
- Installs dependencies
- Generates resources and runs migrations
- Starts the development server

```bash
./start_cement_dev.sh
```

#### `start_cement_tilt.sh`

Starts the Cement infrastructure using Tilt:

- Navigates to the Cement directory
- Pulls latest changes
- Starts Postgres and Redis using Tilt

```bash
./start_cement_tilt.sh
```

#### `start_flatbed.sh`

Starts the Flatbed service:

- Navigates to the Flatbed directory
- Sets Python version to 3.10
- Creates and activates a virtual environment if needed
- Runs the main script

```bash
./start_flatbed.sh
```

#### `start_langgraph.sh`

Starts the LangGraph service:

- Navigates to the LangGraph directory
- Pulls latest changes
- Sets Python version to 3.13
- Creates and activates a virtual environment if needed
- Runs the LangGraph development server
- Automatically sets up assistants after LangGraph starts

```bash
./start_langgraph.sh
```

#### `setup_assistants.sh`

Sets up LangGraph assistants after LangGraph starts:

- Waits for LangGraph to be ready
- Creates estimate assistants with IDs:
  - `3834d1b5-238a-4cdf-88f9-0e11e3b4ee45`
  - `ee691075-582e-4871-b84f-0d9be5c9efd5`
- Creates org assistants with IDs:
  - `9adc14f4-26cc-44ca-af32-bc5c96dc8603`
  - `ee691075-582e-4871-b84f-0d9be5c9efd5`

This script is automatically called by `start_langgraph.sh` but can also be run manually:

```bash
# Make sure ACCESS_TOKEN environment variable is set
export ACCESS_TOKEN="your_access_token_here"
./setup_assistants.sh
```

#### `mk_est_assistant.sh` and `mk_org_assistant.sh`

Individual assistant creation scripts that can accept custom assistant IDs:

```bash
# Make sure ACCESS_TOKEN environment variable is set
export ACCESS_TOKEN="your_access_token_here"
./mk_est_assistant.sh [assistant_id]
./mk_org_assistant.sh [assistant_id]
```

**Note**: All assistant scripts require the `ACCESS_TOKEN` environment variable to be set with your Handoff access token.

## Project Directory Structure

All projects are expected to be in the following locations:

- Cement: `~/handoff/cement`
- Flatbed: `~/handoff/flatbed`
- LangGraph: `~/handoff/langgraph`

## tmux Commands

When using the `start_all_services.sh` script, you'll be in a tmux session. Here are some useful tmux commands:

- **Switch between panes**: `Ctrl+B` then arrow keys
- **Detach from session**: `Ctrl+B` then `d`
- **Reattach to session**: `tmux attach -t dev-services`
- **Kill session**: `tmux kill-session -t dev-services`
- **Scroll in a pane**: `Ctrl+B` then `[` (use arrow keys to scroll, `q` to exit scroll mode)

## Troubleshooting

### Cement Dev Restarting

If you experience issues with Cement Dev restarting when pressing certain key combinations (like Ctrl+V), the script now sets `NODE_NO_READLINE=1` to prevent this behavior.

### Missing Dependencies

Ensure you have the following installed:

- tmux: `brew install tmux`
- tilt: For Cement infrastructure
- pyenv: For Python version management
- Node.js: For Cement development
