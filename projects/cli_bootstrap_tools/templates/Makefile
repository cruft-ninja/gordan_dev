.PHONY: all format lint test type-check check clean

# Default target
all: check

# Fix styling automatically
# 'ruff check --select I --fix' sorts imports
# 'ruff format' fixes code style (Black-compatible)
format:
	uv run ruff check --select I --fix .
	uv run ruff format .

# Check for issues (read-only)
lint:
	uv run ruff check .
	uv run ruff format --check .

# Run static type checking
type-check:
	uv run mypy .

# Run tests
test:
	uv run pytest

# Run all checks (Format -> Lint -> Type Check -> Test)
check: format lint type-check test

# Clean up cache files
clean:
	rm -rf .ruff_cache .pytest_cache .mypy_cache __pycache__
