---
title: Crafting Mentor Prompt
date: 2026-01-04
tags: [prompt_engineering, meta, log]
---

# User Query
The user requested a "purpose-built prompt" designed to guide a beginner through the process of writing prompts. They wanted the AI to act as an "expert prompt engineer" and mentor, teaching principles along the way.

# Technical Deep Dive: Meta-Prompting Strategies

### 1. The Challenge: "Meta-Prompting"
Writing a prompt that generates other prompts requires a distinct separation of concerns:
*   **The Teacher (The AI's persona):** Needs to be patient, Socratic, and structured.
*   **The Subject (The target prompt):** The object being worked on.

### 2. Architecture of `prompt_mentor.md`
I created a specific context file (`prompt_mentor.md`) to handle this request.
*   **Phase 1 (Discovery):** Prevents the "blank page problem" by forcing the user to define inputs/outputs first.
*   **Phase 2 (Construction):** Breaks the prompt down into the standard "CO-STAR" or similar framework elements (Context, Objective, Style, Tone, Audience, Response).
*   **Phase 3 (Education):** This is the crucial request—"teaching basic principles." I explicitly instructed the persona to explain *why* it makes changes (e.g., explaining "Chain of Thought" or "Few-Shot" examples).

### 3. Usage
To use this new tool, the user would run:
```bash
gemini --context prompt_mentor.md
```
Or pipe it in one-shot:
```bash
cat prompt_mentor.md | gemini "Help me write a prompt for a recipe generator."
```

# Tool Usage
`write_file` was used to create the `prompt_mentor.md` artifact immediately, ensuring the user has the code ready to use.
