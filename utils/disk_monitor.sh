#!/bin/bash
#
# Description: Checks disk usage and warns if it exceeds a threshold.
# Usage: ./disk_monitor.sh [threshold_percentage] (default 90)

set -euo pipefail

main() {
  local threshold="${1:-90}"

  if ! [[ "${threshold}" =~ ^[0-9]+$ ]]; then
    echo "Error: Threshold must be an integer." >&2
    exit 1
  fi

  echo "Checking disk usage (Threshold: ${threshold}%)..."
  
  # Parse df output for root filesystem /
  # df output line 2: Filesystem Size Used Avail Use% Mounted
  local usage
  usage=$(df / --output=pcent | awk 'NR==2 {print $1}' | tr -d '%')

  if [[ "${usage}" -ge "${threshold}" ]]; then
    echo "WARNING: Disk usage is high: ${usage}%"
    exit 1
  else
    echo "OK: Disk usage is normal: ${usage}%"
  fi
}

main "$@"
