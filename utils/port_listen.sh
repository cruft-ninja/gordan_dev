#!/bin/bash
#
# Description: Displays currently listening TCP/UDP ports.
# Usage: ./port_listen.sh

set -euo pipefail

main() {
  echo "=== Listening Ports ==="
  
  if ! command -v ss &> /dev/null; then
    echo "Error: 'ss' command not found." >&2
    exit 1
  fi

  # -t: tcp, -u: udp, -l: listening, -n: numeric
  ss -tuln | awk 'NR==1 || /LISTEN/ || /UNCONN/ {print $0}'
}

main "$@"
