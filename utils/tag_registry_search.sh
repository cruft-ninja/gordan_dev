#!/bin/bash
# Usage: tag_registry_search [tag]

TAG="$1"
# Resolve the registry directory relative to this script (../registry)
REGISTRY_DIR="$(dirname "$(realpath "$0")")/../registry"

if [ -z "$TAG" ]; then
    echo "Usage: $0 [tag_name]"
    exit 1
fi

echo "Searching registry for tag: '$TAG'..."
# Grep regex explanation:
# ^tags:  -> Start of line must be 'tags:'
# .*      -> Followed by anything
# $TAG    -> The tag we are looking for
# -r      -> Recursive
# -l      -> List filenames only
# -i      -> Ignore case
grep -irl "^tags:.*$TAG" "$REGISTRY_DIR"
