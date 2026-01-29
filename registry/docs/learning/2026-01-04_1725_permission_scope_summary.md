---
title: Permission Scope Summary
date: 2026-01-04
tags: [security, architecture, summary, log]
---

# User Query
Briefly outline the scope of file and directory access permissions.

# Technical Deep Dive
## Permission Scoping Strategy
The agent operates under a "Least Privilege" model reinforced by explicit system prompt constraints.

### 1. The Protected Zone: `~/dev`
*   **Status:** Read-Only.
*   **Purpose:** Allows the agent to use the user's broader codebase as *reference material* (e.g., checking how a utility function is implemented in `~/dev/utils`) without risk of accidental corruption.
*   **Mechanism:** Enforced via the "Security & Constraints" section in `gemini.md`.

### 2. The Active Sandbox: Current Working Directory
*   **Status:** Read/Write.
*   **Purpose:** This is the agent's workspace. All artifacts (logs, code generation, config updates) must be confined here.
*   **Path:** `/home/ninja/dev/gemini_guru`

### 3. Verification
Before executing a `write_file` or `replace` operation, the agent must check:
```python
if target_path.startswith(current_working_dir):
    allow_operation()
else:
    reject_operation("Permission Denied: Outside Active Project")
```
(Note: This logic is internalized in the agent's reasoning loop).

# Tool Usage
*   `read_file`: Accessed `gemini.md` to confirm the exact text of the security policy before summarizing.
