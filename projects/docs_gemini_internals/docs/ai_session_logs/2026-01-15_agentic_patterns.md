---
title: Agentic Patterns: ReAct & Chain of Thought
date: 2026-01-15
tags: [concept, llm-internals, agents, react, cot]
log_type: concept_explanation
parent_doc: 2026-01-15_system_constants.md
---

# User Query
"System: Please continue." (Context: Moving from Architecture to Behavior).

# Detailed Explanation

### 1. The ReAct Pattern (Reason + Act)
Explained the loop that defines "Agency".
*   **Structure:** Interleaving **Thought** (Reasoning traces), **Action** (Tool execution), and **Observation** (Tool output).
*   **Significance:** Allows the model to solve problems it cannot answer from memory (e.g., "What is in my specific folder?").

### 2. Chain of Thought (CoT)
Explored the concept of "Buying Compute".
*   **Mechanism:** Generating intermediate reasoning steps significantly improves performance on logic/math/coding tasks.
*   **Theory:** The model uses the generated tokens as a "scratchpad" to hold state, overcoming the limitations of a single forward pass.

### 3. Self-Correction (The Feedback Loop)
Discussed how agents handle failure.
*   **Error as Input:** Tool failures (stderr) are fed back into the context.
*   **Iterative Refinement:** The model uses the error message to adjust its hypothesis and try again.

# System Connection
This explains the "verbose" nature of the CLI logs. The system is visibly "thinking" (using CoT) and "looping" (using ReAct) to ensure safety and accuracy before presenting the final result.
