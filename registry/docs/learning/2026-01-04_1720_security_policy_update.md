---
title: Security Policy Update
date: 2026-01-04
tags: [security, policy, log]
---

# User Query
Update `gemini.md` to explicitly state that the agent has **read-only** permissions for all files in `~/dev`, ensuring no ambiguity.

# Technical Deep Dive
## Defining Safe Boundaries in System Prompts
Ambiguity in file system permissions can lead to "agent drift," where an AI might modify adjacent projects thinking they are part of the current context.

To solve this, we implemented a **Negative Constraint with Explicit Exception** pattern in the system prompt (`gemini.md`):

1.  **The Broad Rule:** `~/dev` is Read-Only. This acts as a firewall protecting the user's broader development environment.
2.  **The Narrow Exception:** The *Current Working Directory* is writable. This allows the agent to function (create logs, code) without endangering neighboring repos.

## Updated Policy in `gemini.md`
```markdown
# Security & Constraints
*   **File Permissions:** You have **STRICT READ-ONLY** access to the `~/dev` directory and all its subdirectories.
*   **Exception:** You are permitted to create and modify files *only* within the current working directory (the active project).
*   **Ambiguity Clause:** Any request to modify files in `~/dev` outside the active project root is strictly prohibited.
```

This phrasing removes the vague "unless specifically directed" loophole, replacing it with a hard boundary.

# Tool Usage
*   `read_file`: Used to retrieve the current content of `gemini.md` to identify the correct target string for replacement.
*   `replace`: Used to atomically swap the old security section with the new, stricter policy.
