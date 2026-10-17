#!/bin/sh

# Get the directory where this script is located, resolving symlinks so the
# script works when invoked through a symlink on PATH
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# Navigate to the script directory
cd "$SCRIPT_DIR"

# Define paths
PACK_SCRIPT="../../build/pack.js"
ASAR_FILE="../../build/default_app.asar"
RESOURCES_DIR="./resources"
KUMI_EXECUTABLE="./kumi"

# Check if kumi executable exists
if [ ! -f "$KUMI_EXECUTABLE" ]; then
    echo "Error: kumi executable not found at $KUMI_EXECUTABLE"
    exit 1
fi

# Check if pack.js exists
if [ ! -f "$PACK_SCRIPT" ]; then
    echo "Error: pack.js not found at $PACK_SCRIPT"
    exit 1
fi

# Run the pack.js script using kumi
echo "Running pack.js to create default_app.asar..."
"$KUMI_EXECUTABLE" "$PACK_SCRIPT"

# Check if the asar file was created
if [ ! -f "$ASAR_FILE" ]; then
    echo "Error: default_app.asar was not created"
    exit 1
fi

# Ensure Resources directory exists
if [ ! -d "$RESOURCES_DIR" ]; then
    echo "Error: Resources directory not found at $RESOURCES_DIR"
    exit 1
fi

# Copy the asar file to resources directory
cp "$ASAR_FILE" "$RESOURCES_DIR/default_app.asar"

if [ $? -eq 0 ]; then
    echo "Repacking complete. default_app.asar copied to resources directory."
else
    echo "Error: Failed to copy default_app.asar to resources directory"
    exit 1
fi
