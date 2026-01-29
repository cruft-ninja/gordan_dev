---
title: Registry File Audit
date: 2026-01-13
tags: [audit, registry, stats, log]
---

# User Query
The user requested a recursive count of all markup (`.md`) files within the `@registry/` directory structure.

# Technical Deep Dive
## Registry Content Audit
Executed a standard `find` operation to inventory the `registry/` tree.

**Command:**
```bash
find registry -type f -name "*.md" | wc -l
```

**Results:**
*   **Total MD Files:** 46
*   **Primary Concentration:** `registry/docs/learning/` (34 files) contains the bulk of session logs and knowledge base articles.
*   **Governance:** `registry/docs/protocol/` (3 files) holds the core laws.
*   **Meta:** `registry/` root holds the `INDEX.md` and `collab_notes.md`.

## Implication
The centralized documentation structure is populated and active. The high count in `learning/` suggests the "Automatic Logging" protocol is effectively capturing knowledge.

# Tool Usage
*   `run_shell_command`: Used `find` and `wc -l` for the count, and `find` again for the breakdown.
*   `write_file`: Updated `registry/collab_notes.md` with the session turn.
