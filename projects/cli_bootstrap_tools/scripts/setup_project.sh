#!/bin/bash

# ==============================================================================
# Script Name: setup_project.sh
# Purpose: Unified entry point for project setup and maintenance.
# Usage: ./setup_project.sh [command] [options]
# Commands:
#   new [name]    Create a new project (default if name provided)
#   refresh       Recreate virtual environments
#   help          Show this help message
# ==============================================================================

set -u # Treat unset variables as an error

# Get the directory where the script is located to correctly source utils
# 'realpath' ensures we have the absolute path, handling symlinks correctly
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${SCRIPT_DIR}/../lib/utils.sh"

# Determine the project root relative to this script location
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/../.." && pwd )"

# --- Functions ---

# Verifies that essential external tools are installed
check_dependencies() {
    local missing=0
    # Git is required for version control
    check_command "git" "Install Git via your package manager (e.g., apt, brew)." || missing=1
    # uv is the chosen python package manager
    check_command "uv" "Install uv via 'curl -LsSf https://astral.sh/uv/install.sh | sh'" || missing=1
    
    if [ $missing -eq 1 ]; then
        log_error "Missing required dependencies. Aborting."
        exit 1
    fi
}

# Displays the interactive welcome screen
show_welcome() {
    clear
    echo "============================================"
    echo "   Gnarly CLI Workflow Encabulator"
    echo "============================================"
    echo ""
    echo "This tool simplifies Python project management:"
    echo ""
    echo "NEW PROJECT: Initializes a clean development"
    echo "environment with Git, virtual environments (uv),"
    echo "Ruff, Pytest, and CI/CD templates."
    echo ""
    echo "REFRESH: Fixes broken virtual environments after"
    echo "moving or renaming your project directory."
    echo ""
    echo "============================================"
    echo ""
    read -p "Press [Enter] to start the interactive menu..."
}

# Displays command-line usage instructions
usage() {
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  new [name]      Initialize a new Python project"
    echo "  refresh         Refresh all virtual environments in the workspace"
    echo "  menu            Open the interactive menu (default if no args)"
    echo "  help            Show this help message"
    echo ""
    echo "Options for 'new':"
    echo "  --no-git        Skip Git initialization"
    echo "  --no-python     Skip Python (uv) setup"
    echo "  --no-dev        Skip installing dev tools"
    echo "  --no-shell      Skip entering the virtual environment shell"
    echo "  --copy-scripts  Copy automation scripts to the new project"
    exit 1
}

# Copies this automation suite into a new project directory
copy_self() {
    local target_dir=$1
    log_info "Copying automation scripts to project..."
    
    # Copy essential directories recursively
    cp -r "${SCRIPT_DIR}/../lib" "${target_dir}/"
    cp -r "${SCRIPT_DIR}/../scripts" "${target_dir}/"
    cp -r "${SCRIPT_DIR}/../templates" "${target_dir}/"
    
    # Create symlink for easy access in the new project root
    # e.g., ./SETUP -> scripts/setup_project.sh
    ln -sf scripts/setup_project.sh "${target_dir}/SETUP"
    
    log_success "Scripts copied and linked in '${target_dir}'."
}

# Initializes the Python environment using 'uv'
setup_python() {
    local project_name=$1
    local skip_dev=$2
    
    log_info "Initializing Python environment with uv..."
    
    # Create pyproject.toml if it doesn't exist
    if [ ! -f "pyproject.toml" ]; then
        uv init
        log_success "Project initialized with 'uv init'."
    else
        log_warn "'pyproject.toml' already exists. Skipping init."
    fi

    log_info "Creating virtual environment..."
    uv venv
    
    log_info "Syncing dependencies..."
    # 'uv sync' ensures the lockfile and venv are consistent with pyproject.toml
    uv sync
    
    if [ "$skip_dev" = false ]; then
        log_info "Installing development tools (ruff, pytest, mypy, pre-commit)..."
        # Add standard development dependencies
        uv add --dev ruff pytest mypy pre-commit
        
        log_info "Copying project templates..."
        if [ -d "${SCRIPT_DIR}/../templates" ]; then
            # Copy configuration files for tools
            cp "${SCRIPT_DIR}/../templates/Makefile" .
            cp "${SCRIPT_DIR}/../templates/.editorconfig" .
            
            if [ -f "${SCRIPT_DIR}/../templates/.pre-commit-config.yaml" ]; then
                cp "${SCRIPT_DIR}/../templates/.pre-commit-config.yaml" .
                log_success ".pre-commit-config.yaml added."
            fi
            
            # Setup GitHub Actions CI
            mkdir -p .github/workflows
            if [ -f "${SCRIPT_DIR}/../templates/ci.yml" ]; then
                cp "${SCRIPT_DIR}/../templates/ci.yml" .github/workflows/ci.yml
                log_success "CI workflow (GitHub Actions) added."
            fi

            log_success "Makefile and .editorconfig added."
        else
            log_warn "Template directory not found."
        fi
    fi
    log_success "Python setup complete."
}

# Initializes the Git repository and commits initial state
setup_git() {
    log_info "Checking Git status..."
    # Check if we are already in a git repo to avoid nesting unintentionally
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        log_warn "Already inside a Git repository. Skipping Git initialization."
        return
    fi

    # Check for Git Identity (user.name/email) to prevent commit failures
    if [ -z "$(git config user.name)" ] || [ -z "$(git config user.email)" ]; then
        log_warn "Git user.name or user.email not configured."
        if ask_yes_no "Configure global Git identity now?" "N"; then
             read -p "Enter Name: " gname
             read -p "Enter Email: " gemail
             git config --global user.name "$gname"
             git config --global user.email "$gemail"
             log_success "Git identity configured."
        else
             log_warn "Commits might fail without Git identity."
        fi
    fi

    log_info "Initializing new Git repository..."
    git init
    
    # Create a sensible default .gitignore if none exists
    if [ ! -f ".gitignore" ]; then
        cat <<GITIGNORE > .gitignore
__pycache__/
.venv/
uv.lock
.ruff_cache/
.pytest_cache/
.mypy_cache/
*.log
.env
GITIGNORE
        log_success ".gitignore created."
    fi

    # Stage and commit all files
    git add .
    git commit -m "Initial commit: Project setup"
    log_success "Initial commit created."
}

# Orchestrates the creation of a new project
run_new_project() {
    local name="${1:-.}"
    local skip_git="${2:-false}"
    local skip_python="${3:-false}"
    local skip_dev="${4:-false}"
    local copy_scripts="${5:-false}"
    local skip_shell="${6:-false}"

    log_info "Starting project setup for: '$name'"

    # Handle script copying logic
    if [ "$copy_scripts" = true ]; then
        if [ "$name" == "." ]; then
             log_warn "Cannot copy scripts to self (current directory). Skipping copy."
        else
             copy_self "$name"
        fi
    fi

    # Create directory if not current
    if [ "$name" != "." ]; then
        mkdir -p "$name"
        cd "$name" || exit 1
    fi

    # Run setup steps based on flags
    [ "$skip_python" = false ] && setup_python "$name" "$skip_dev"
    [ "$skip_git" = false ] && setup_git

    log_success "Project '$name' setup successfully!"
    
    # Automatically drop user into the new shell environment if possible
    if [ "$skip_python" = false ] && [ "$skip_shell" = false ] && [ -f ".venv/bin/activate" ]; then
        log_info "Entering project environment..."
        RC_FILE=$(mktemp)
        # Source user's bashrc then activate the venv
        echo "if [ -f ~/.bashrc ]; then source ~/.bashrc; fi; source .venv/bin/activate; rm -f $RC_FILE" > "$RC_FILE"
        exec bash --rcfile "$RC_FILE"
    fi
}

# Wrapper to call the venv recreation script
run_refresh() {
    log_info "Refreshing virtual environments..."
    if [ -f "${SCRIPT_DIR}/ops/recreate_venvs.sh" ]; then
        bash "${SCRIPT_DIR}/ops/recreate_venvs.sh"
    else
        log_error "recreate_venvs.sh not found in ${SCRIPT_DIR}/ops"
    fi
}

show_detailed_help() {
    clear
    echo "============================================"
    echo "   Detailed Help Information"
    echo "============================================"
    echo "1) Create a New Project"
    echo "   Initializes a professional Python environment:"
    echo "   - Git: Repository init + .gitignore."
    echo "   - Python (uv): Creates pyproject.toml and .venv."
    echo "   - Dev Tools: Ruff (lint), Pytest (test), MyPy (types)."
    echo "   - Automation: GitHub CI and Pre-commit configs."
    echo ""
    echo "   Interactive Options:"
    echo "   - Skip Git: Use if already in a workspace."
    echo "   - Skip Python: Use to only copy templates/docs."
    echo "   - Copy Scripts: Bundles these automation tools"
    echo "     into the new project for standalone use."
    echo ""
    echo "2) Refresh Virtual Environments"
    echo "   Virtual environments contain absolute paths."
    echo "   If you move or rename your project folder,"
    echo "   the python interpreter will break. Run 'refresh'"
    echo "   to delete and recreate all .venv directories."
    echo "============================================"
    read -p "Press [Enter] to return to the menu..."
}

main_menu() {
    while true; do
        clear
        echo "============================================"
        echo "   Gnarly CLI Workflow Encabulator"
        echo "============================================"
        echo "1) Help"
        echo "   - Detailed explanation of all features."
        echo ""
        echo "2) Create a New Project"
        echo "   - Full environment setup with modern tools."
        echo ""
        echo "3) Refresh Virtual Environments"
        echo "   - Fixes broken paths after rename/move."
        echo ""
        echo "4) Exit"
        echo "============================================"
        read -p "Select an option [1-4]: " opt

        case $opt in
            1)
                show_detailed_help
                ;;
            2)
                read -p "Enter project name (default: current dir): " pname
                pname=${pname:-.}
                
                ask_yes_no "Skip Git?" "N" && sgit=true || sgit=false
                ask_yes_no "Skip Python?" "N" && spy=true || spy=false
                ask_yes_no "Skip Dev Tools?" "N" && sdev=true || sdev=false
                ask_yes_no "Copy Automation Scripts?" "N" && scopy=true || scopy=false
                
                run_new_project "$pname" "$sgit" "$spy" "$sdev" "$scopy"
                read -p "Press Enter to continue..."
                ;;
            3)
                run_refresh
                read -p "Press Enter to continue..."
                ;;
            4)
                log_info "Exiting."
                exit 0
                ;;
            *)
                log_error "Invalid option."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}

# --- Argument Parsing ---

check_dependencies

if [ $# -eq 0 ]; then
    show_welcome
    main_menu
    exit 0
fi

case "$1" in
    new)
        shift
        PROJECT_NAME="."
        SKIP_GIT=false
        SKIP_PYTHON=false
        SKIP_DEV=false
        SKIP_SHELL=false
        COPY_SCRIPTS=false
        while [[ $# -gt 0 ]]; do
            case "$1" in
                --no-git) SKIP_GIT=true; shift ;;
                --no-python) SKIP_PYTHON=true; shift ;;
                --no-dev) SKIP_DEV=true; shift ;;
                --no-shell) SKIP_SHELL=true; shift ;;
                --copy-scripts) COPY_SCRIPTS=true; shift ;;
                *) PROJECT_NAME="$1"; shift ;;
            esac
        done
        run_new_project "$PROJECT_NAME" "$SKIP_GIT" "$SKIP_PYTHON" "$SKIP_DEV" "$COPY_SCRIPTS" "$SKIP_SHELL"
        ;;
    refresh)
        run_refresh
        ;;
    help|-h|--help)
        usage
        ;;
    menu)
        main_menu
        ;;
    *)
        # Backward compatibility: assume 'new' if arg doesn't match a command
        run_new_project "$@"
        ;;
esac
