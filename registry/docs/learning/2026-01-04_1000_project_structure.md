---
title: Project Structure Overview
date: 2026-01-04
tags: [architecture, workflow, log]
---

The file `bash/lib/gemini_functions.sh` is indeed gone.

To help you with "comprehending how 'all the things' work" in this **Gnarly Workflow Encabulator** project, here is a breakdown of the key moving parts based on your file structure:

### 1. The Core Logic (`bash/`)
This directory contains the automation machinery.
*   **`main.py`**: Likely the central orchestrator script (Python) for the project's automation tasks.
*   **`scripts/`**: Contains shell scripts for setup (`setup_project.sh`) and maintenance (`recreate_venvs.sh`).
*   **`templates/`**: Holds configuration files (`Makefile`, `ci.yml`, `.editorconfig`) that get copied into new projects or environments.
*   **`config/project_aliases`**: Defines shortcuts (aliases) to make running these tools easier.

### 2. The Application (`my_py_app/`)
This represents the actual software product you are building or managing with the workflow.
*   It has its own standard Python structure: `pyproject.toml` (dependencies), `.venv/` (virtual environment), and `main.py` (application code).
*   The **Gnarly Workflow** likely exists to spin up, test, and manage this specific application (or others like it).

### 3. Documentation (`docs/`)
*   **`cheatsheets/`**: A collection of quick references for the tools involved (Git, UV, Ruff, Make, etc.). This is your "knowledge base."
*   **`workflow_automation.md`**: Explains the specific automation logic of this project.

### 4. Integration (`test_project_ci/`, `README.md`)
*   **`test_project_ci/`**: Likely a sandbox or dummy project used to test the CI/CD pipelines or the workflow scripts themselves.
*   **`gemini.md`**: The project-specific context file for the AI assistant, explaining the project's conventions and rules.

**In essence:**
You have a **meta-project** (the "Encabulator" in `bash/`) designed to automate the lifecycle of a **target application** (`my_py_app/`), documented in `docs/` and tested in `test_project_ci/`.
