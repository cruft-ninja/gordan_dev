---
title: IDE Setup Guide
date: 2026-01-04
tags: [workflow, ide, guide, vscode]
---

# IDE Setup Guide for Gemini Agent Workflow

This guide outlines the recommended settings for Visual Studio Code (or similar IDEs) to ensure a seamless and safe collaboration between the human developer and the Gemini CLI agent.

## 💾 File Synchronization (Crucial)

To prevent the agent from acting on outdated code, ensure your editor saves files automatically before you switch to the terminal.

*   **Setting:** `Files: Auto Save`
*   **Recommended Value:** `onFocusChange`
*   **Why:** This ensures that every time you click from the editor into the terminal to run a command, the latest version of your code is written to disk.

## 🔍 Reducing Noise

Keep the agent focused on your source code by excluding environment and build artifacts from searches and the explorer.

*   **Setting:** `Files: Exclude`
*   **Recommended Patterns:**
    *   `**/.venv` (Virtual environments)
    *   `**/__pycache__` (Python bytecode)
    *   `**/*.egg-info` (Metadata)
    *   `**/.git` (Version control internals)

## 🛠️ Tooling Consistency

Prevent "formatting wars" where the IDE and the Agent overwrite each other's style.

*   **Setting:** `Editor: Default Formatter`
*   **Recommended Value:** `Ruff` (Official extension)
*   **Why:** Since this monorepo uses `ruff` for linting and formatting, having the IDE use the same engine ensures clean git diffs.

## 📜 Terminal Visibility

Avoid losing agent output when it generates long explanations or code blocks.

*   **Setting:** `Terminal > Integrated: Scrollback`
*   **Recommended Value:** `10000` (or higher)
*   **Why:** The agent often outputs significant amounts of Markdown; a larger buffer allows you to scroll back to the start of the interaction.
