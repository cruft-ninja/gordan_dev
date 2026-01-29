#!/bin/bash
#
# Description: Recursively fixes permissions in a directory (Files: 644, Dirs: 755).
# Usage: ./fix_perms.sh <directory>

set -euo pipefail

usage() {
  echo "Usage: $0 <directory>"
  exit 1
}

main() {
  if [[ $# -ne 1 ]]; then
    usage
  fi

  local target_dir="$1"

  if [[ ! -d "${target_dir}" ]]; then
    echo "Error: Directory '${target_dir}' does not exist." >&2
    exit 1
  fi

  echo "Fixing permissions in '${target_dir}'..."
  echo "Directories -> 755"
  find "${target_dir}" -type d -exec chmod 755 {} +
  
  echo "Files -> 644"
  find "${target_dir}" -type f -exec chmod 644 {} +
  
  echo "Done."
}

main "$@"
