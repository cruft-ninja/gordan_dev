# uv Cheatsheet (Modern Python Tooling)

`uv` is a super-fast replacement for `pip`, `pip-tools`, and `virtualenv`.

## 1. Project Setup
| Command | What it does |
| :--- | :--- |
| `uv init` | Initializes a new project (creates `pyproject.toml`). |
| `uv venv` | Creates a virtual environment in `.venv`. |

## 2. Managing Dependencies
| Command | What it does |
| :--- | :--- |
| `uv add <package>` | Installs a package and adds it to `pyproject.toml`. |
| `uv add --dev <package>` | Installs a development-only package (e.g., `pytest`). |
| `uv remove <package>` | Uninstalls a package and removes it from config. |
| `uv sync` | Syncs the environment with `pyproject.toml` (installs missing deps). |

## 3. Running Commands
| Command | What it does |
| :--- | :--- |
| `uv run <script.py>` | Runs a script inside the virtual environment automatically. |
| `uv run pytest` | Runs a tool (like pytest) inside the venv. |

## 4. Maintenance
| Command | What it does |
| :--- | :--- |
| `uv cache clean` | Clears the internal cache if things get stuck. |
| `uv pip install -r requirements.txt` | Legacy support for installing from requirements files. |
