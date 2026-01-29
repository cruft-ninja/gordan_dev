#!/bin/bash

# ==============================================================================
# Script Name: aliases.sh (The Loader)
# Purpose: Loads the utility library and then imports the project aliases.
# Usage: source bash/aliases.sh
# ==============================================================================

# 1. Locate the script directory
# Uses BASH_SOURCE to find the location of this script, regardless of where it's called from.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 2. Source the utility library (for nice logging)
# Check if utils.sh exists in the relative path before attempting to source it
if [ -f "${SCRIPT_DIR}/../lib/utils.sh" ]; then
    source "${SCRIPT_DIR}/../lib/utils.sh"
fi

# 3. Source the project alias definition file
PROJECT_ALIAS_FILE="${SCRIPT_DIR}/../config/project_aliases"
if [ -f "$PROJECT_ALIAS_FILE" ]; then
    source "$PROJECT_ALIAS_FILE"
fi

# 4. Source the custom user alias definition file
CUSTOM_ALIAS_FILE="${SCRIPT_DIR}/../config/custom_aliases"
if [ -f "$CUSTOM_ALIAS_FILE" ]; then
    source "$CUSTOM_ALIAS_FILE"
fi
