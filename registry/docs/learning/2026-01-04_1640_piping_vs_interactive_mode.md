---
title: Piping vs Interactive Mode
date: 2026-01-04
tags: [bash, cli, log, troubleshooting]
---

# User Query
The user is experiencing two issues:
1.  `/memory show` output is indeed truncated.
2.  **Major Blocker:** They are trying to pipe context into the CLI using `cat gemini.md | gemini`, but the application starts and immediately exits. They are referencing a previous explanation that stated context files "must be explicitly piped in," which seems to contradict the behavior of the `gemini.md` file (which is being auto-loaded).

# Technical Deep Dive: CLI Input Modes (Interactive vs. Piped)

### 1. The Misunderstanding: "Explicit Piping"
There are **two types** of context in the Gemini CLI ecosystem:

*   **Implicit Context (Auto-loaded):**
    *   Files named `GEMINI.md` or `gemini.md` located in the current directory or `~/.gemini/extensions/`.
    *   **Behavior:** The CLI automatically looks for these files on startup and adds them to the System Prompt. You do **not** need to pipe these. This is why our current session works.

*   **Explicit Context (Piped/Flagged):**
    *   Arbitrary files (e.g., `main.py`, `logs.txt`) that you want the LLM to read for a *specific* question.
    *   **Behavior:** These must be passed via arguments (`gemini main.py`) or pipes (`cat logs.txt | gemini`).

### 2. Why `cat gemini.md | gemini` Exits Immediately
When you pipe data into the Gemini CLI (`| gemini`), the CLI enters **Non-Interactive Mode** (One-Shot Mode).

1.  **Read Stdin:** It reads the content of `gemini.md`.
2.  **Wait for Prompt:** It looks for a user prompt (the actual question).
3.  **The Error:** If you didn't provide a prompt argument (e.g., `gemini "Summarize this"`), it might be treating the piped input as the *context* but having no *instruction* to act upon, or it executes the default behavior and exits.

**Correct One-Shot Usage:**
```bash
cat gemini.md | gemini "What does this file say?"
```

**Correct Interactive Usage:**
Just run `gemini`. It will auto-detect `gemini.md` in the folder. You don't need to pipe it.

### 3. Summary of Context Loading
*   `gemini.md` (in current dir) -> **AUTO-LOADED** (Interactive & One-shot).
*   `cat file.txt | gemini` -> **ONE-SHOT** (Reads file, answers, exits).
*   `gemini --context file.txt` -> **INTERACTIVE** (Starts chat with file loaded).

# Tool Usage
None. Explanation of CLI binary behavior.
