#!/bin/bash

# Script to set up all assistants after LangGraph starts
# This script runs the assistant creation scripts with the specified IDs

SCRIPT_DIR="/Users/fk/handoff/dev-server-scripts"

echo "Setting up assistants..."

# Wait a bit for LangGraph to be fully ready
echo "Waiting for LangGraph to be ready..."
sleep 5

# Check if LangGraph is responding
echo "Checking if LangGraph is ready..."
for i in {1..30}; do
    # Check if LangGraph server is responding (any response means it's up)
    if curl -s --max-time 3 ${LANGGRAPH_URL:-http://localhost:2024}/ > /dev/null 2>&1; then
        echo "LangGraph is ready!"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "Warning: LangGraph may not be ready yet, proceeding anyway..."
        break
    fi
    echo "Waiting for LangGraph... (attempt $i/30)"
    sleep 2
done

echo "Creating estimate assistants..."

# Run mk_est_assistant.sh with the two required assistant IDs
echo "Creating estimate assistant with ID: 3834d1b5-238a-4cdf-88f9-0e11e3b4ee45"
"$SCRIPT_DIR/mk_est_assistant.sh" "3834d1b5-238a-4cdf-88f9-0e11e3b4ee45"

echo "Creating estimate assistant with ID: ee691075-582e-4871-b84f-0d9be5c9efd5"
"$SCRIPT_DIR/mk_est_assistant.sh" "ee691075-582e-4871-b84f-0d9be5c9efd5"

echo "Creating estimate assistant with ID: b9b455fe-b3d7-5ee0-b7c9-ab30756644ed"
"$SCRIPT_DIR/mk_est_assistant.sh" "b9b455fe-b3d7-5ee0-b7c9-ab30756644ed"

echo "Creating org assistants..."

# Run mk_org_assistant.sh with the two required assistant IDs
echo "Creating org assistant with ID: 9adc14f4-26cc-44ca-af32-bc5c96dc8603"
"$SCRIPT_DIR/mk_org_assistant.sh" "9adc14f4-26cc-44ca-af32-bc5c96dc8603"

echo "Creating org assistant with ID: ee691075-582e-4871-b84f-0d9be5c9efd5"
"$SCRIPT_DIR/mk_org_assistant.sh" "ee691075-582e-4871-b84f-0d9be5c9efd5"

echo "Creating org assistant with ID: b9b455fe-b3d7-5ee0-b7c9-ab30756644ed"
"$SCRIPT_DIR/mk_org_assistant.sh" "b9b455fe-b3d7-5ee0-b7c9-ab30756644ed"

echo "All assistants have been set up!"

# --- PATCH step for each assistant ---
echo "Patching all assistants with config..."

ASSISTANT_IDS=(
    "ee691075-582e-4871-b84f-0d9be5c9efd5"
    "b9b455fe-b3d7-5ee0-b7c9-ab30756644ed"
    "9adc14f4-26cc-44ca-af32-bc5c96dc8603"
)

for ID in "${ASSISTANT_IDS[@]}"; do
    echo "Patching assistant $ID..."
    curl "http://localhost:2024/assistants/$ID" \
        --request PATCH \
        --header 'Content-Type: application/json' \
        --data '{
          "config": {"configurable": {}}
        }'
    echo # newline for readability
done

echo "All assistants have been patched!"