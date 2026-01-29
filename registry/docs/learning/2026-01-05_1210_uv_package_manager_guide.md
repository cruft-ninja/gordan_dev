---
title: uv Package Manager Guide
date: 2026-01-05
tags: [python, uv, guide]
---

# uv Package Manager Guide
Yes, uv can be a better option than venv and pip for many users, especially if you're prioritizing speed, simplicity, and an all-in-one tool for managing Python environments, packages, and projects on your Linux Mint setup. It's written in Rust, making it 10-100x faster for tasks like package installation and dependency resolution compared to traditional pip. uv effectively replaces both venv (for virtual environments) and pip (for package management), while adding features like automatic Python version management, lockfiles for reproducibility, and script handling—without needing separate tools like poetry or pyenv.

That said, venv and pip are standard Python tools (built into Python itself), so they're always available without extra installation and have no learning curve if you're already familiar with them. uv requires using virtual environments by default (unlike pip alone), which is a good practice anyway, but it might feel opinionated if you prefer minimalism. If your projects are simple and you don't mind slower installs, venv + pip could suffice. However, given your environment notes that you have "no proper environments for python etc." and limited experience with advanced utilities, uv's efficiency and unified approach make it a strong starting point for reproducible workflows.

To help you evaluate or adopt uv, here's a simple, reproducible bash-based workflow tailored to your Linux Mint 21.3 setup. This assumes you have curl installed (standard on Mint; check with `curl --version`). We'll install uv, set up a sample Python project, and integrate Gemini CLI for any AI-assisted code generation.

### Step 1: Prerequisites Check

Run these in your bash terminal to verify basics:

```bash
#!/bin/bash

# Check for curl (for uv installation)
if ! command -v curl &> /dev/null; then
    echo "curl not found. Install it with: sudo apt update && sudo apt install curl -y"
    exit 1
fi

# Check for git (for version control)
if ! command -v git &> /dev/null; then
    echo "git not found. Install it with: sudo apt update && sudo apt install git -y"
    exit 1
fi

# Optional: Check Gemini CLI (for AI integration)
if ! command -v gemini &> /dev/null; then
    echo "Gemini CLI not found. Consider installing it if needed for code generation."
fi

echo "Prerequisites OK."
```

Save this as `check_prereqs.sh`, make it executable (`chmod +x check_prereqs.sh`), and run `./check_prereqs.sh`. If anything is missing, follow the prompts—uses your apt package manager.

### Step 2: Install uv

uv installs via a single curl command, adding it to your PATH (it'll modify ~/.cargo/bin or similar; safe and reversible). Create a bash script for this:

```bash
#!/bin/bash

# Install uv securely
curl -LsSf https://astral.sh/uv/install.sh | sh

# Add to PATH if needed (usually automatic, but verify)
if ! command -v uv &> /dev/null; then
    echo "Adding uv to PATH. Add this to ~/.bashrc: export PATH=\"$HOME/.cargo/bin:$PATH\""
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Log success or error
if [ $? -eq 0 ]; then
    echo "uv installed successfully. Version: $(uv --version)"
else
    echo "Installation failed. Check logs or try manually from https://docs.astral.sh/uv/"
    exit 1
fi
```

Save as `install_uv.sh`, `chmod +x install_uv.sh`, run `./install_uv.sh`. This handles errors and logs output. Restart your terminal or source ~/.bashrc after.

### Step 3: Set Up a Sample Python Project with uv

uv simplifies creating environments and installing packages. Here's a script to bootstrap a project (e.g., a simple script using requests for API calls):

```bash
#!/bin/bash

# Usage: ./setup_project.sh <project_name>
# Example: ./setup_project.sh my_api_project

PROJECT_NAME="${1:-my_project}"
PROJECT_DIR="$HOME/dev/$PROJECT_NAME"  # Standard layout under ~/dev

# Create directory structure
mkdir -p "$PROJECT_DIR/src"

# Initialize uv project (creates pyproject.toml and virtual env)
cd "$PROJECT_DIR" || exit 1
uv init --python 3.12  # Installs Python 3.12 if needed; uv manages versions

# Add a dependency
uv add requests  # Faster than pip install

# Generate sample code with Gemini CLI integration
gemini query "Generate a simple Python script using requests to fetch data from a public API, e.g., JSON placeholder" > src/main.py

# Log and usage
echo "Project setup in $PROJECT_DIR."
echo "To run: cd $PROJECT_DIR && uv run src/main.py"
echo "For reproducibility: uv lock  # Generates uv.lock file"
```

Save as `setup_project.sh`, make executable, and run it. Edit `src/main.py` in nano for quick tweaks or VS Code (`code src/main.py`) for more features—leverages your editors and extensions like Bash Debug.

### Step 4: Testing and Validation

- Run your script: `cd ~/dev/my_project && uv run src/main.py`. uv activates the env automatically.
- Compare speeds: Time a pip install in a manual venv vs. uv add (e.g., `time uv add numpy`—expect significant speedup on your Intel i7 with 32GB RAM).
- Error handling: uv scripts include logging; check ~/.uv/logs for issues.

### Step 5: Best Practices for Version Control and Sharing

- Initialize Git: `cd ~/dev/my_project && git init && git add . && git commit -m "Initial uv project setup"`.
- Share: Push to GitHub using your git 2.34.1. Include uv.lock for reproducible installs (`uv sync` on clone).
- Security: Avoid running untrusted scripts; validate inputs in your Python code (e.g., via argparse). Use uv in user mode—no sudo needed.

This workflow keeps things self-contained and minimal, avoiding assumptions about unavailable tools. If you run into compatibility issues on your setup (e.g., with your PATH aliases), let me know for tweaks.
