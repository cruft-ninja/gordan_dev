---
title: Gemini Internals Overview
date: 2026-01-04
tags: [gemini, architecture, guide]
---

# How Gemini Operates Locally: A Technical Overview

This document outlines the file structure, configuration, and context mechanisms that power the Gemini CLI on your local machine.

## 1. Global Configuration (`~/.gemini/`)
The primary state and configuration for Gemini reside in your home directory under `.gemini`.

*   **Extensions (`~/.gemini/extensions/`)**
    *   This is where "skills" are installed.
    *   **Context Injection:** If a folder inside here contains a `GEMINI.md` file (e.g., `~/.gemini/extensions/screenshare/GEMINI.md`), its content is *automatically* appended to the system prompt for every session. This is how the agent knows it has tools like "screenshare" or "vision" available globally.
    *   **Tools:** Each extension provides an MCP (Model Context Protocol) server that exposes specific tools (functions) to the agent.

*   **Temporary Workspace (`~/.gemini/tmp/`)**
    *   Gemini uses this directory for scratchpad operations, temporary file downloads, or intermediate processing steps that shouldn't clutter your project directory.
    *   It is generally safe to clear this folder when Gemini is not running.

## 2. Project-Specific Context
Gemini does not automatically "know" about your project just because you are in the directory. It relies on **explicit context injection**.

*   **`gemini.md` (Convention)**
    *   It is a convention (used in this project) to place a `gemini.md` file in the project root.
    *   **Not Automatic:** The CLI does *not* read this file by default.
    *   **Manual Loading:** You must feed this file to the CLI. This is commonly done via piping:
        ```bash
        cat gemini.md | gemini "My task..."
        ```
        Or by using a wrapper function/alias (like the `g-run` function we saw earlier) that handles this piping for you.

## 3. The Runtime Loop
When you run a command like `gemini "Fix this bug"`, the following happens locally:

1.  **Prompt Assembly:**
    *   **Base Identity:** "You are an interactive CLI agent..."
    *   **Global Context:** Reads `~/.gemini/extensions/*/GEMINI.md`.
    *   **Input Stream:** Reads from `stdin`. If you piped `cat gemini.md | ...`, that project context is added here.
    *   **User Prompt:** Adds your specific argument ("Fix this bug").

2.  **Tool Execution:**
    *   The agent runs entirely on your machine (as a CLI process).
    *   When it decides to use a tool (like `read_file` or `run_shell_command`), it executes that code locally with your user permissions.
    *   **Safety:** Critical tools (file writes, shell commands) usually require your confirmation unless you use flags like `-y` (YOLO mode).

3.  **Memory (Session)**
    *   Gemini maintains a short-term conversation history for the current session.
    *   For long-term persistence, it can use a `save_memory` tool (if available/configured) to store facts, typically in a local database or JSON file within `~/.gemini/`.

## Summary
*   **Global Brain:** `~/.gemini/extensions/` (Capabilities + Global Rules)
*   **Local Context:** `./gemini.md` (Project Rules, *must be piped in*)
*   **Scratchpad:** `~/.gemini/tmp/`
