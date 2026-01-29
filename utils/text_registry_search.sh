#!/bin/bash
# Usage: registry_search [tag_or_keyword]

QUERY="$1"
# Resolve the registry directory relative to this script (../registry)
REGISTRY_DIR="$(dirname "$(realpath "$0")")/../registry"

if [ -z "$QUERY" ]; then
    echo "Usage: $0 [search_term]"
    exit 1
fi

echo "Searching registry for '$QUERY'..."
# -r: recursive, -i: ignore case, -l: print filename only
grep -ril "$QUERY" "$REGISTRY_DIR"
