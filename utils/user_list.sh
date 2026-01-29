#!/bin/bash
#
# Description: Lists human users (UID >= 1000) and their default shells.
# Usage: ./user_list.sh

set -euo pipefail

main() {
  echo "=== System Users (UID >= 1000) ==="
  echo "Username | UID | Shell"
  echo "---------------------------"
  
  # Parse /etc/passwd
  # Fields: username:x:uid:gid:comment:home:shell
  awk -F: '$3 >= 1000 && $1 != "nobody" {printf "% -10s | % -4s | %s\n", $1, $3, $7}' /etc/passwd
}

main "$@"
