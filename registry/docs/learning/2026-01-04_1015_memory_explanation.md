---
title: Memory Explanation
date: 2026-01-04
tags: [gemini, memory, guide]
---

# User Prompt
ok. it's beginning to make sense. please continue to output prompts & responses as files. i would prefer a prompt and response pair combined into a single file if that's doable. the save_memory tool is of great interest. is that what is used internally by the '/memory save' command?

# Response
You are spot on regarding the relationship between the tool and the command. They are two sides of the same coin, interacting with the same underlying storage mechanism.

### 1. The `save_memory` Tool (My Hands)
*   **Who uses it:** I (the AI Agent) use this.
*   **When:** I call this function when you tell me something like "Remember that my API key is stored in env var X" or "I prefer concise Python code."
*   **Mechanism:** It allows me to structure a fact and commit it to the long-term storage (typically a database or JSON file in `~/.gemini/memory/`).

### 2. The `/memory` Slash Command (Your Control Panel)
*   **Who uses it:** You (the User) use this in the CLI.
*   **When:** You use this to manually inspect (`/memory show`), add, or modify memories without relying on me to interpret your request.
*   **Relation:** When you run `/memory save` (or similar variants like `/memory add`, depending on the specific version), you are bypassing my "reasoning" and writing directly to that same database.

**In summary:**
Yes, they share the same backend. The tool is my way of accessing it; the slash command is your way of accessing it.
