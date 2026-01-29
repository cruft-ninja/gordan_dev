#!/bin/bash

# ==============================================================================
# Script Name: utils.sh
# Purpose: Common utility functions for shell scripts.
#          Includes logging and dependency checking.
# ==============================================================================

# Colors for output - ANSI escape codes
# RED: Error messages
RED='\033[0;31m'
# GREEN: Success messages
GREEN='\033[0;32m'
# BLUE: Informational messages
BLUE='\033[0;34m'
# YELLOW: Warnings/Attentions
YELLOW='\033[1;33m'
# NC: Reset color to terminal default
NC='\033[0m'

# Log an informational message (Blue)
# Usage: log_info "Message text"
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Log a success message (Green)
# Usage: log_success "Operation completed successfully"
log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Log a warning message (Yellow)
# Usage: log_warn "Something might be wrong"
log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Log an error message (Red) to stderr
# Usage: log_error "Critical failure"
# Note: Redirects to >&2 (stderr) so it can be separated from standard output
log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if a command exists in the system
# Usage: check_command "command_name" "Optional installation suggestion"
# Returns: 0 if found, 1 if not found
check_command() {
    local cmd="$1"
    local install_msg="${2:-}"
    
    # command -v checks if the command is reachable/executable
    # &> /dev/null suppresses output (we only care about exit code)
    if ! command -v "$cmd" &> /dev/null; then
        log_error "'$cmd' is not installed or not in PATH."
        if [[ -n "$install_msg" ]]; then
            echo "  -> Suggestion: $install_msg"
        fi
        return 1
    fi
}

# Ask a yes/no question. Returns 0 for Yes, 1 for No.
# Usage: ask_yes_no "Question?" "default (Y/n)"
# Interactive function that loops until valid input is received
ask_yes_no() {
    local prompt="$1"
    local default="${2:-Y}"
    local reply

    # Format the prompt to indicate the default choice (uppercase)
    if [[ "$default" =~ ^[Yy] ]]; then
        prompt="$prompt [Y/n]"
    else
        prompt="$prompt [y/N]"
    fi

    # Loop indefinitely until a valid return is triggered
    while true; do
        read -p "$prompt: " reply
        
        # Handle empty input (User just pressed Enter)
        if [[ -z "$reply" ]]; then
            # If default is Yes, return 0 (success/true)
            [[ "$default" =~ ^[Yy] ]] && return 0 || return 1
        fi

        # Case-insensitive matching for various "yes" formats
        case "$reply" in
            [Yy]|[Yy][Ee][Ss]) return 0 ;; # Return success
            [Nn]|[Nn][Oo]) return 1 ;;     # Return failure
            *) echo "Please answer 'y' or 'n'." ;;
        esac
    done
}