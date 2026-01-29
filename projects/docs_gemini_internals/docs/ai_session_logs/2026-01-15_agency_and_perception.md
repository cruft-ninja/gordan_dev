---
title: Agency & Perception: Function Calling & Multimodality
date: 2026-01-15
tags: [concept, llm-internals, function-calling, multimodal]
log_type: concept_explanation
parent_doc: 2026-01-15_alignment_and_safety.md
---

# User Query
"System: Please continue." (Context: Deep dive into Agency and Vision).

# Detailed Explanation

### 1. Function Calling (The Hands)
Explored how text models interact with the physical world (or operating system).
*   **Mechanism:** The model is trained to recognize when a user query requires external data/action.
*   **Output:** Instead of text, it emits a structured token sequence (JSON) matching a provided schema.
*   **Execution Loop:** The "Client" (CLI) pauses -> Runs code -> Returns result -> Model resumes.
*   **Security:** The model has *no* inherent access; it relies entirely on the Client to execute the request (The "Man in the Middle" Architecture).

### 2. Native Multimodality (The Eyes)
Contrasted "Patchwork" vs. "Native" architectures.
*   **Native Approach:** Images/Audio are tokenized into vectors (patches) just like text.
*   **Shared Embedding Space:** The model learns the relationship between the vector for the word "Cat" and the vector for a visual patch of a cat.
*   **Benefit:** Zero information loss from "image-to-text" conversion. Allows for fine-grained reasoning (spatial, textural).

# Final System Map
The complete anatomy of the Gemini CLI is now documented:
`Local CLI (Tools/Context)` <-> `API (Brain)`
1.  **User Input** ("Check disk usage")
2.  **Context Assembly** (Read `GEMINI.md`)
3.  **Transmission** (HTTPS)
4.  **Inference** (MoE Brain decides: "I need `run_shell_command`")
5.  **Output** (JSON Payload)
6.  **Local Execution** (Bash runs `df -h`)
7.  **Re-Inference** (Brain reads output, generates: "You have 20GB free.")
