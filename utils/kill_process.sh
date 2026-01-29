#!/bin/bash
#
# Description: Safely kills a process by name with user confirmation.
# Usage: ./kill_process.sh <process_name>

set -euo pipefail

usage() {
  echo "Usage: $0 <process_name>"
  exit 1
}

main() {
  if [[ $# -ne 1 ]]; then
    usage
  fi

  local proc_name="$1"
  local pids
  
  # Find pids (exclude the grep process and the script itself)
  pids=$(pgrep -f "${proc_name}" || true)

  if [[ -z "${pids}" ]]; then
    echo "No processes found matching '${proc_name}'."
    exit 0
  fi

  echo "Found the following processes for '${proc_name}':"
  ps -fp ${pids} # split by space is intended here for multiple pids
  echo ""
  
  read -r -p "Are you sure you want to kill these processes? [y/N] " response
  if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Killing processes..."
    # shellcheck disable=SC2086
    kill ${pids}
    echo "Signal sent."
  else
    echo "Operation cancelled."
  fi
}

main "$@"
