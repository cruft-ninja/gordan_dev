---
title: Tag List Reference
date: 2026-01-13
tags: [audit, registry, taxonomy, reference, log]
---

# User Query
The user requested a complete list of unique tags currently in use within the Registry.

# Technical Deep Dive
## Taxonomy Listing
Executed a refined search to strictly extract YAML list items from the `tags:` header.

**Command:**
```bash
grep -rIh "^tags:" registry --include="*.md" | \
 sed 's/tags: \[//;s/\]//' | \
 tr ',' '\n' | \
 sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | \
 grep -v "^$" | sort | uniq -c | sort -nr
```

**Full Taxonomy (Frequency Order):**
*   20 `log`
*   16 `gemini`
*   8 `workflow`
*   8 `prompt_engineering`
*   8 `guide`
*   6 `reference`
*   6 `meta`
*   5 `cli`
*   4 `troubleshooting`
*   4 `security`
*   4 `architecture`
*   3 `memory`
*   3 `context`
*   3 `comparison`
*   2 `session`
*   2 `registry`
*   2 `policy`
*   2 `model`
*   2 `grok`
*   2 `bash`
*   2 `audit`
*   2 `ai`
*   1 `vscode`
*   1 `uv`
*   1 `system_prompt`
*   1 `summary`
*   1 `stats`
*   1 `python`
*   1 `protocol`
*   1 `principles`
*   1 `planning`
*   1 `performance`
*   1 `metadata`
*   1 `media`
*   1 `map`
*   1 `integration`
*   1 `index`
*   1 `ide`
*   1 `glossary`
*   1 `config`
*   1 `collaboration`

**Total Unique Tags:** 41

# Tool Usage
*   `run_shell_command`: Used to extract and clean the tag list.
*   `write_file`: Logged this list for future consistency checks.
