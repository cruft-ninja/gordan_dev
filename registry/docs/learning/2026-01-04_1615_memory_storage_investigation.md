---
title: Memory Storage Investigation
date: 2026-01-04
tags: [gemini, memory, troubleshooting, log]
---

# User Query
The user requested to save the output of the `/memory show` command (typed as `/memory shoo`) to a file for examination.

# Technical Deep Dive: Gemini CLI Memory Storage

### Investigation
To fulfill the request, I attempted to locate the underlying storage mechanism for the Gemini CLI's memory features.
1.  **Target Directory:** `~/.gemini/`
2.  **Findings:**
    *   `settings.json`: Configuration (editor, model, etc.).
    *   `state.json`: UI state (banner impressions).
    *   `oauth_creds.json`: Authentication tokens.
    *   `extensions/`: Contains `screenshare` and `vision` extensions.
    *   **Missing:** There is no visible `memory/` directory, `memory.json`, or `memory.db` file in the root configuration folder.

### Conclusion
The memory backend for the Gemini CLI is not exposed as a simple user-accessible file in the standard `~/.gemini` path. It is likely:
*   Stored in a system-specific path (though standard XDG paths were empty).
*   Managed internally within a binary-specific storage that isn't easily "dumped" by a file read.
*   Or, no memories have been saved yet, so the file has not been initialized.

### Limitation
As an AI Agent, I cannot execute "Slash Commands" (like `/memory`, `/help`, `/clear`) directly. These are handled by the CLI wrapper *before* the prompt reaches the LLM.

### Solution
The user must execute the command manually and redirect stdout to a file:
```bash
/memory show > memory_dump.txt
```

# Tool Usage
*   `run_shell_command("ls -F ~/.gemini/")`: To list config files.
*   `run_shell_command("cat ~/.gemini/state.json")`: To inspect potential storage files.
*   `run_shell_command("ls -alt ~/.gemini/")`: To check for recently modified files.
