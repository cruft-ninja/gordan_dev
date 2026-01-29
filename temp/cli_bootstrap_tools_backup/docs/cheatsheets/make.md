# Make Cheatsheet (Task Automation)

Make is used to run common tasks easily without remembering long commands.
The commands are defined in the `Makefile` at the project root.

## 1. Standard Targets
| Command | What it does |
| :--- | :--- |
| `make` | Runs the default target (usually `check`). |
| `make check` | **Full CI Run**. Runs Format, Lint, Type Check, and Tests. |
| `make format` | **Fix Code**. Sorts imports and formats code using Ruff. |
| `make lint` | **Read-only Check**. Checks style without changing files. |
| `make type-check` | Runs `mypy` static type checking. |
| `make test` | Runs `pytest`. |
| `make clean` | Removes cache files (`__pycache__`, `.ruff_cache`, etc). |

## 2. How it works
Make simply runs shell commands for you.
Example from our `Makefile`:
```makefile
test:
    uv run pytest
```
When you type `make test`, it executes `uv run pytest`.
