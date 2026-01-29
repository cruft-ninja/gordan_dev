#!/bin/bash
#
# Description: Archives a directory into a tar.gz file with a timestamp.
# Usage: ./backup_dir.sh <source_dir> <backup_dest>

set -euo pipefail

usage() {
  echo "Usage: $0 <source_dir> <backup_dest>"
  exit 1
}

main() {
  if [[ $# -ne 2 ]]; then
    usage
  fi

  local src="$1"
  local dest="$2"
  local timestamp
  timestamp=$(date +%Y%m%d_%H%M%S)
  local archive_name
  archive_name="$(basename "${src}")_${timestamp}.tar.gz"
  local archive_path="${dest}/${archive_name}"

  if [[ ! -d "${src}" ]]; then
    echo "Error: Source directory '${src}' does not exist." >&2
    exit 1
  fi

  if [[ ! -d "${dest}" ]]; then
    echo "Creating destination directory '${dest}'..."
    mkdir -p "${dest}"
  fi

  echo "Backing up '${src}' to '${archive_path}'..."
  tar -czf "${archive_path}" -C "$(dirname "${src}")" "$(basename "${src}")"
  echo "Backup complete."
}

main "$@"
