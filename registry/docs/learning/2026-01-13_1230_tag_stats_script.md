---
title: Tag Stats Script Creation
date: 2026-01-13
tags: [automation, bash, tool, log]
---

# User Query
The user requested a "bash script" to formalize the previously discussed command pipeline.

# Technical Deep Dive
## Script Architecture
I encapsulated the "Tag Stats" logic into a dedicated utility script: `utils/tag_stats.sh`.

**Key Features:**
1.  **Dynamic Path Resolution:** Uses `$(dirname "$(realpath "$0")")` to locate the `registry/` directory regardless of where the script is called from.
2.  **Safety Checks:** Verifies the registry directory exists before running.
3.  **Pipeline:** Executes the exact `grep | sed | tr | sort | uniq` pipeline verified in Turn 25.

**Code:**
```bash
#!/bin/bash
# ... (shebang and logic) ...
grep -rIh "^tags:" "$REGISTRY_DIR" ... | sort -nr
```

## Permissions
Executed `chmod +x utils/tag_stats.sh` to ensure it is immediately runnable.

# Tool Usage
*   `read_file`: Checked existing scripts for style.
*   `write_file`: Created the script.
*   `run_shell_command`: Applied execution permissions.
