#!/bin/bash
# Usage: ./utils/tag_stats.sh
# Description: Generates a frequency-sorted list of all unique tags in the registry.

# Resolve the registry directory relative to this script (../registry)
REGISTRY_DIR="$(dirname "$(realpath "$0")")/../registry"

if [ ! -d "$REGISTRY_DIR" ]; then
    echo "Error: Registry directory not found at $REGISTRY_DIR"
    exit 1
fi

echo "Generating tag statistics for: $REGISTRY_DIR"
echo "------------------------------------------------"

# The extraction pipeline
grep -rIh "^tags:" "$REGISTRY_DIR" --include="*.md" | sed 's/tags: \[//;s/\]//' | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v "^$" | sort | uniq -c | sort -nr

echo "------------------------------------------------"
echo "Done."