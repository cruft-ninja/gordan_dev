#!/bin/bash
#
# Description: Lists the top N processes by memory usage.
# Usage: ./mem_hogs.sh [count] (default count is 5)

set -euo pipefail

main() {
  local count="${1:-5}"

  if ! [[ "${count}" =~ ^[0-9]+$ ]]; then
    echo "Error: Count must be a positive integer." >&2
    exit 1
  fi

  echo "Top ${count} Processes by Memory Usage:"
  echo "---------------------------------------"
  # ps options: -e (all processes), -o (output format)
  # --sort=-%mem sorts by memory descending
  ps -e -o pid,ppid,user,%mem,%cpu,comm --sort=-%mem | head -n "$((count + 1))"
}

main "$@"
