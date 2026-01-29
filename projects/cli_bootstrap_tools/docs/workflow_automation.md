# Workflow Automation Guide

**Last Updated:** January 4, 2026

This document records the standard procedures and automation scripts established for the project.
The source code (scripts) includes detailed comments explaining the logic and usage of each function.

## 1. The "Master Setup" Script

Location: `bash/scripts/setup_project.sh`
Symlink: `./SETUP` (in project root)

This is the primary entry point for all project initialization and maintenance tasks. It features both a CLI interface and an interactive menu.

### Interactive Mode
Simply run the script without arguments to be guided through the process:
```bash
./SETUP
```

### CLI Commands

| Command | Description |
| :--- | :--- |
| `new [name]` | Initialize a new Python project. |
| `refresh` | Recreate all virtual environments (fix for rename/move). |
| `menu` | Force open the interactive menu. |

### Options for 'new'
- `--no-git`: Skip Git setup.
- `--no-python`: Skip uv/venv setup.
- `--no-dev`: Skip installing Ruff, Pytest, MyPy, and Pre-commit.
- `--no-shell`: Skip entering the virtual environment shell at the end.
- `--copy-scripts`: Copy the automation scripts (bash tools) to the new project.

### Interactive Mode
When running interactively, you will be prompted for these options:
1. Project Name
2. Skip Git?
3. Skip Python?
4. Skip Dev Tools?
5. Copy Automation Scripts?

## 2. Maintenance & Portability

If the project root is renamed, the absolute paths in virtual environments will break. Use the refresh command to fix them:
```bash
./SETUP refresh
```

## 3. Standard Tooling Stack
Integrated tools: **uv**, **Ruff**, **Pytest**, **MyPy**, **Pre-commit**, and **Make**.
Also generates:
- **GitHub Actions CI** (`.github/workflows/ci.yml`)
- **Pre-commit Config** (`.pre-commit-config.yaml`)
