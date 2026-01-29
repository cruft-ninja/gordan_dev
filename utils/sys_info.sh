#!/bin/bash
#
# Description: Displays basic system information (Kernel, Uptime, Memory, Disk).
# Usage: ./sys_info.sh

set -euo pipefail

main() {
  echo "=== System Information ==="
  echo "Date: $(date)"
  echo "Kernel: $(uname -r)"
  echo "Uptime: $(uptime -p)"
  echo ""
  echo "--- Memory Usage ---"
  free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2*100}'
  echo ""
  echo "--- Disk Usage (/) ---"
  df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s)\n", $3, $2, $5}'
}

main "$@"
