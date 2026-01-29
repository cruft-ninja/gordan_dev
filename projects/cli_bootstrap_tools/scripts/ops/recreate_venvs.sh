#!/bin/bash

# ==============================================================================
# Script Name: recreate_venvs.sh
# Purpose: Deletes and recreates virtual environments for the project.
#          Useful after renaming the project root or moving the directory.
# ==============================================================================

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_DIR}/../../lib/utils.sh"

PROJECT_ROOT="$( cd "${SCRIPT_DIR}/../../.." && pwd )"

# Helper function to delete and recreate a virtual environment
recreate_venv() {
    local dir=$1
    local name=$2
    
    log_info "Recreating virtual environment in: $dir ($name)"
    
    # 1. Remove existing .venv directory if it exists
    if [ -d "$dir/.venv" ]; then
        rm -rf "$dir/.venv"
        log_success "Removed existing .venv in $name"
    fi

    # 2. Enter directory and create new venv
    cd "$dir"
    if uv venv; then
        log_success "Created new .venv for $name"
        
        # 3. Re-install dependencies if pyproject.toml exists
        # This ensures the environment is usable immediately
        if [ -f "pyproject.toml" ]; then
            log_info "Installing dependencies for $name..."
            uv pip install -e . &> /dev/null
            log_success "Dependencies installed for $name"
        fi
    else
        log_error "Failed to create .venv for $name"
    fi
    
    # Return to project root for next iteration
    cd "$PROJECT_ROOT"
}

# 1. Recreate VENV for Bash Automation Tools
recreate_venv "${PROJECT_ROOT}/bash" "Bash Tools"

# 2. Recreate VENV for the Application
# Only check if the specific app directory exists
if [ -d "${PROJECT_ROOT}/my_py_app" ]; then
    recreate_venv "${PROJECT_ROOT}/my_py_app" "my_py_app"
fi

log_success "All virtual environments have been refreshed."
