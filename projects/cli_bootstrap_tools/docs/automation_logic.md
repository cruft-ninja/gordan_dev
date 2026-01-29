# Bash Automation Tools

This directory contains the automation logic and templates for the workflow.

## Key Scripts

### `scripts/setup_project.sh`
Initializes a new project directory with Git, a Python virtual environment (via `uv`), and standard configuration files.
Can be run from the root via the `./SETUP` symlink.

**Usage:**
```bash
./SETUP [project_name] [--no-git] [--no-python] [--no-dev] [--no-shell] [--copy-scripts]
```

### `scripts/ops/recreate_venvs.sh`
Refreshes all project virtual environments. Essential after renaming the root directory or moving the project.

**Usage:**
```bash
./SETUP refresh
```

### `aliases.sh`
Loads project-specific shortcuts. It sources `lib/utils.sh` and `config/my_aliases`.

**Usage:**
```bash
source bash/aliases.sh
```

## Shortcuts (from `config/my_aliases`)

| Alias | Command |
| :--- | :--- |
| `work` | Jump to project root |
| `docs` | Jump to documentation |
| `setup` | Run `./SETUP` |
| `check` | Run `make check` |
| `gs` / `gd` / `gl` | Git Shortcuts |

## Directory Layout

- `lib/utils.sh`: Logging and dependency checking functions.
- `config/my_aliases`: Dynamic alias definitions.
- `templates/`: Boilerplate files (Makefile, .editorconfig, ci.yml, .pre-commit-config.yaml).
