---
title: Context File Latency
date: 2026-01-04
tags: [gemini, context, performance, log]
---

# User Query
Does the restriction added to `gemini.md` become effective immediately, or on restart?

# Technical Deep Dive
## Context Injection & Lifecycle
In the Gemini CLI ecosystem, files like `gemini.md` serve as **System Prompt Context**.

1.  **Initialization Phase:** When the CLI starts, it reads specific files (`gemini.md`, `.geminiignore`, etc.) to construct the initial "World View" for the AI. This context is injected before the first user message.
2.  **Runtime Modifications:** modifying `gemini.md` during an active session changes the *artifact on disk*, but typically **does not** retroactively update the system prompt context of the *current* conversation history, unless the agent is specifically programmed to re-ingest context dynamically (which is rare due to token costs and context window limits).

## Immediate vs. Persistent Compliance
*   **Immediate Effect (Session):** The restriction is effective **immediately** in this specific session because the User explicitly stated the rule in the chat flow ("Security: you do not have permission..."). The AI's short-term memory (context window) now holds this constraint.
*   **Persistent Effect (File):** The update to `gemini.md` ensures that **future sessions** (after a restart) will automatically include this constraint in the system prompt, without the user needing to repeat it.

## Best Practice
Always treat `gemini.md` updates as "Configuration for the *next* run," while using direct prompts to enforce immediate behavioral changes in the *current* run.
