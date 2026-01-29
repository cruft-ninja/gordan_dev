#!/bin/bash
#
# Captures current CPU load and alerts if it exceeds a threshold.
#
# Usage: ./check_cpu.sh [threshold]

set -euo pipefail

usage() {
  echo "Usage: $0 [threshold]"
  echo "  threshold: Optional CPU % limit for warning (default: 90)"
}

main() {
  local threshold="${1:-90}"
  local cpu_idle
  local cpu_load

  if ! command -v top &> /dev/null; then
    echo "Error: 'top' command not found." >&2
    exit 1
  fi

  # Run top twice (-n2) because the first iteration often reports boot-time averages.
  # We take the second iteration for live data.
  # Parsing logic:
  # 1. Get lines with "Cpu(s)"
  # 2. Take the last one (the second iteration)
  # 3. Extract the idle time (8th field in many standard `top` outputs, 
  #    but 'id' position varies. Safer to rely on regex or specific column if standard).
  #    Standard procps-ng top: "%Cpu(s):  1.0 us,  0.5 sy,  0.0 ni, 98.5 id..."
  
  # Using awk to find the field ending with "id" is robust against column shifts.
  cpu_idle=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{for(i=1;i<=NF;i++) if($i=="id") print $(i-1)}')

  if [[ -z "$cpu_idle" ]]; then
     echo "Error: Could not parse CPU idle time." >&2
     exit 1
  fi

  # Calculate load (100 - idle)
  cpu_load=$(awk -v idle="$cpu_idle" 'BEGIN {print 100 - idle}')

  echo "Current CPU Load: ${cpu_load}%"

  # Float comparison using awk
  if awk -v load="$cpu_load" -v limit="$threshold" 'BEGIN {exit !(load > limit)}'; then
    echo "WARNING: High CPU usage detected! (> ${threshold}%)" >&2
    exit 1
  fi
}

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
  usage
  exit 0
fi

main "$@"
