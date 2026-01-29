# Pytest Cheatsheet (Testing)

Pytest is the framework used for running automated tests in this project.

## 1. Running Tests
| Command | What it does |
| :--- | :--- |
| `uv run pytest` | Runs all tests in the project. |
| `uv run pytest -v` | **Verbose**. Shows each test name as it passes/fails. |
| `uv run pytest -s` | **Show Output**. Prints `print()` statements to the console (normally hidden). |

## 2. Selecting Tests
| Command | What it does |
| :--- | :--- |
| `uv run pytest tests/test_core.py` | Run only tests in a specific file. |
| `uv run pytest -k "login"` | Run tests where the name matches "login". |
| `uv run pytest -x` | Stop immediately after the first failure. |
| `uv run pytest --lf` | **Last Failed**. Only run tests that failed last time. |

## 3. Writing Tests
Tests are Python functions that start with `test_`.
```python
def test_addition():
    assert 1 + 1 == 2

def test_failure_message():
    val = 10
    # Add a custom message if assertion fails
    assert val > 20, f"Value {val} was too small!"
```
