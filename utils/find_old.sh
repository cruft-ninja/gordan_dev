#!/bin/bash
#
# Description: Finds and lists files older than a specified number of days in a directory.
# Usage: ./find_old.sh <directory> <days>

set -euo pipefail

usage() {
  echo "Usage: $0 <directory> <days>"
  exit 1
}

main() {
  if [[ $# -ne 2 ]]; then
    usage
  fi

  local target_dir="$1"
  local days="$2"

  if [[ ! -d "${target_dir}" ]]; then
    echo "Error: Directory '${target_dir}' does not exist." >&2
    exit 1
  fi

  if ! [[ "${days}" =~ ^[0-9]+$ ]]; then
    echo "Error: Days must be a positive integer." >&2
    exit 1
  fi

  echo "Scanning '${target_dir}' for files older than ${days} days..."
  find "${target_dir}" -type f -mtime +"${days}" -print
}

main "$@"
