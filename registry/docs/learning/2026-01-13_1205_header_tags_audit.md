---
title: Header Tags Audit
date: 2026-01-13
tags: [audit, registry, metadata, log]
---

# User Query
The user requested a count of files containing "header tags" (YAML frontmatter `tags: [...]`).

# Technical Deep Dive
## Metadata Compliance Check
I searched the `registry/` directory for files containing the specific string `tags:`, which is the standard key for taxonomy in our YAML frontmatter.

**Command:**
```bash
grep -r "tags:" registry --include="*.md" | wc -l
```

**Results:**
*   **Total Tagged Files:** 38
*   **Total Files in Registry:** 46 (from previous turn)
*   **Compliance Rate:** ~83%

## Analysis
The difference (8 files) suggests some files—likely templates (`task_template.md`), raw drafts (`task_template_proposal.md`), or older logs—might be missing the standard header. This is acceptable for drafts but should be monitored for official documentation.

# Tool Usage
*   `run_shell_command`: `grep` provided a fast, reliable text search across the directory tree.
*   `write_file`: Updated the persistent `collab_notes.md` log.
