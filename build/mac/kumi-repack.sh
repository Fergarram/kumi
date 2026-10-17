#!/bin/sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Navigate to the script directory
cd "$SCRIPT_DIR"

# Define paths
PACK_SCRIPT="../../../../build/pack.js"
ASAR_FILE="../../../../build/default_app.asar"
RESOURCES_DIR="../Resources"
KUMI_EXECUTABLE="./Kumi"

# Check if Kumi executable exists
if [ ! -f "$KUMI_EXECUTABLE" ]; then
    echo "Error: Kumi executable not found at $KUMI_EXECUTABLE"
    exit 1
fi

# Check if pack.js exists
if [ ! -f "$PACK_SCRIPT" ]; then
    echo "Error: pack.js not found at $PACK_SCRIPT"
    exit 1
fi

# Run the pack.js script using Kumi
echo "Running pack.js to create default_app.asar..."
"$KUMI_EXECUTABLE" "$PACK_SCRIPT"

# Check if the asar file was created
if [ ! -f "$ASAR_FILE" ]; then
    echo "Error: default_app.asar was not created"
    exit 1
fi

# Ensure Resources directory exists
mkdir -p "$RESOURCES_DIR"

# Copy the asar file to Resources directory
cp "$ASAR_FILE" "$RESOURCES_DIR/default_app.asar"

if [ $? -eq 0 ]; then
    echo "Repacking complete. default_app.asar copied to Resources directory."
else
    echo "Error: Failed to copy default_app.asar to Resources directory"
    exit 1
fi
