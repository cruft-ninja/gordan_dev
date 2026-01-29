#!/bin/bash
#
# Description: Checks if a website is reachable via HTTP/HTTPS.
# Usage: ./check_site.sh <url>

set -euo pipefail

usage() {
  echo "Usage: $0 <url>"
  exit 1
}

main() {
  if [[ $# -ne 1 ]]; then
    usage
  fi

  local url="$1"
  local status_code

  echo "Checking ${url}..."
  
  # Use curl to fetch only the status code
  status_code=$(curl -o /dev/null -s -w "% {http_code}\n" "${url}")

  if [[ "${status_code}" -ge 200 && "${status_code}" -lt 400 ]]; then
    echo "OK: ${url} is up (Status: ${status_code})."
  else
    echo "FAIL: ${url} returned status ${status_code}."
    exit 1
  fi
}

main "$@"
