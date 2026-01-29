---
title: Slash Command Redirection
date: 2026-01-04
tags: [gemini, cli, troubleshooting, log]
---

# User Query
The user reported that running `/memory show > memory_dump.txt` did not create an output file and asked if they need to prefix the command with `!`.

# Technical Deep Dive: Slash Commands vs. Shell Commands

### The Issue
Slash commands in the Gemini CLI (like `/memory`, `/help`, `/clear`) are **internal directives** handled by the REPL (Read-Eval-Print Loop) interface itself. They are *not* system shell commands.

*   **How Shell Redirection Works:** When you type `ls > file.txt`, the shell (Bash/Zsh) handles the `>` operator.
*   **How Gemini REPL Works:** When you type `/memory show > file.txt`, the Gemini REPL parses the entire string `/memory show > file.txt` as arguments to its internal memory handler. It doesn't know how to handle the `>` redirection operator like a shell would.

### The `!` Prefix
The `!` prefix is a common convention (from IPython/Jupyter) to tell a REPL to "pass this command to the system shell."
*   `!ls` -> Executes `ls` in Bash.
*   `!/memory show` -> This would fail because `/memory` is *not* a Bash executable; it's a Gemini internal command.

### The Solution: Copy-Paste
Because the internal slash commands do not support stdout redirection, there is no programmatic way to pipe their output to a file from within the CLI session.
1.  Run `/memory show`.
2.  Manually copy the output from the terminal window.
3.  Paste it into a file.

# Tool Usage
None. This was a conceptual explanation of CLI architecture.
