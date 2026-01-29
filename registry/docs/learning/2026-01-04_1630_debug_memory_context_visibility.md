---
title: Debug Memory Context Visibility
date: 2026-01-04
tags: [gemini, context, troubleshooting, log]
---

# User Query
The user observed that `/memory show` displayed "Current memory content from 3 file(s):" but only listed content from the extension `GEMINI.md` files (Screenshare and Vision). They asked why the "rest of the context" (specifically the newly created `gemini.md` in the current directory) was missing.

# Technical Deep Dive: Context Loading Mechanics

### 1. The "3 File" Mystery
The output header "Current memory content from 3 file(s)" is a crucial clue.
*   **File 1:** `~/.gemini/extensions/screenshare/GEMINI.md` (Visible in output)
*   **File 2:** `~/.gemini/extensions/vision/GEMINI.md` (Visible in output)
*   **File 3:** **Where is it?**

It is highly probable that the **third file** *is* the `gemini.md` we just created (`/home/ninja/dev/gnarly_workflow_encabulator/gemini_learning_logs/gemini.md`), but the output was truncated or the user missed it in the scrollback.

### 2. Context Loading Hierarchy
The Gemini CLI constructs its "System Prompt" (Memory) by aggregating text from specific locations. The order of precedence (or concatenation) is typically:
1.  **Global Extensions:** `~/.gemini/extensions/*/GEMINI.md` (Loaded first)
2.  **Project Context:** `./gemini.md` (or `.gemini/GEMINI.md` in the project root).
3.  **User-Saved Facts:** Data stored via `save_memory` / `/memory save` (injected dynamically).

### 3. Why it might appear missing
*   **Truncation:** If the context is very long, the UI might cut it off.
*   **Refresh Timing:** The CLI loads context *at the start of a turn*. If `gemini.md` was created *during* the current session, it's possible the "memory viewer" (which reads the current state) is showing the state *as it was loaded*, or it might need a session restart to pick up the new file in the root.
    *   *Correction:* In this specific interaction, the agent (me) *can* see the instructions from `gemini.md` (because I am following them right now!), so the file **is** loaded.

### 4. Verification
The fact that I am writing this log file in this specific format proves that `gemini.md` **is active**. The `/memory show` command might simply be displaying the "static" memory sources (extensions) differently than the "local" context file, or listing them in an order where the local file was at the very bottom.

# Tool Usage
`grep` was used to search the temporary chat logs to see exactly what the system "saw" in previous turns. The grep results confirmed the presence of the extension contexts in the JSON payloads.
