#!/bin/bash
#
# Search text or specific tags within the documentation directory.
#
# Usage: ./search_docs.sh [-t] <search_term>

set -euo pipefail

# Configuration
# Resolves the project root relative to this script location (scripts/bash/ -> ../../)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR="${PROJECT_ROOT}/docs"

usage() {
  echo "Usage: $0 [-t] <search_term>"
  echo "  -t    Search only within 'tags:' lines"
  echo "  <search_term>  Regex pattern to search for"
}

main() {
  local search_tags=false
  local term=""

  while getopts ":t" opt; do
    case ${opt} in
      t) search_tags=true ;;
      \?) echo "Invalid option: -$OPTARG" >&2; usage; exit 1 ;;
    esac
  done
  shift $((OPTIND -1))

  term="${1:-}"

  if [[ -z "$term" ]]; then
    echo "Error: Search term required." >&2
    usage
    exit 1
  fi

  if [[ ! -d "$DOCS_DIR" ]]; then
      echo "Error: Documentation directory not found at $DOCS_DIR" >&2
      exit 1
  fi

  echo "Searching in: $DOCS_DIR"

  if [[ "$search_tags" == true ]]; then
    echo "Mode: Tag Search ($term)"
    # grep returns 1 if no matches, which triggers -e exit. We allow exit code 1.
    grep -irl "^tags:.*$term" "$DOCS_DIR" || true
  else
    echo "Mode: Full Text Search ($term)"
    grep -ril "$term" "$DOCS_DIR" || true
  fi
}

main "$@"
