# Ruff Cheatsheet (Linter & Formatter)

Ruff is an extremely fast Python linter and code formatter. In this project, it replaces `black`, `flake8`, and `isort`.

## 1. Basic Usage
| Command | What it does |
| :--- | :--- |
| `uv run ruff check .` | **Lint**. Scans code for errors and style violations. |
| `uv run ruff format .` | **Format**. Rewrites code to match the standard style (like Black). |

## 2. Fixing Issues
| Command | What it does |
| :--- | :--- |
| `uv run ruff check --fix .` | Automatically fixes simple linting errors (like unused imports). |
| `uv run ruff check --select I --fix .` | Specifically sorts imports (isort replacement). |

## 3. Configuration
Ruff is configured in `pyproject.toml`.
- **Ignore rules:** Add codes to the `ignore = [...]` list.
- **Line length:** Adjust `line-length = 88`.

## 4. Common Error Codes
- **E**: Error (standard flake8 style)
- **F**: Pyflakes (logic errors)
- **I**: Isort (import sorting)
- **UP**: PyUpgrade (modernizing syntax)
