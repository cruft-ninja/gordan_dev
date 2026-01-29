---
title: Adversarial AI: Prompt Injection & Defense
date: 2026-01-15
tags: [concept, security, prompt-injection, safety]
log_type: concept_explanation
parent_doc: 2026-01-15_the_frontier.md
---

# User Query
"System: Please continue." (Context: Security and Adversarial Robustness).

# Detailed Explanation

### 1. The Core Vulnerability (Prompt Injection)
Explained why LLMs are hackable.
*   **Root Cause:** "Instruction/Data Equivalence." The model cannot inherently distinguish between the System Prompt (Rules) and the User Input (Data).
*   **Risk:** "Jailbreaking" (bypassing filters) or "Indirect Injection" (malicious instructions hidden in processed documents).

### 2. Defense Mechanisms
*   **Delimiters:** Using XML tags (`<data>...</data>`) to explicitly demarcate untrusted input.
*   **Sandboxing:** Running the agent with limited permissions (e.g., the `gemini-safe` wrapper using `bwrap`).
*   **Human-in-the-Loop:** The architectural requirement for user confirmation on side-effect tools (`write_file`, `run_shell_command`).

# Documentation Suite Complete
The `projects/docs_gemini_internals/` knowledge base now contains a complete "University Course" on LLM Theory & Practice.

**Course Syllabus:**
1.  **Inference:** `parallel_prefill` vs `sequential_decoding`.
2.  **Optimization:** `kv_cache` & `speculative_decoding`.
3.  **Architecture:** `moe` & `attention_scaling`.
4.  **Data:** `tokenization` & `quantization`.
5.  **Alignment:** `rlhf` & `grounding`.
6.  **Agency:** `function_calling` & `multimodality`.
7.  **Scale:** `parameters` & `flops`.
8.  **Cognition:** `react` & `chain_of_thought`.
9.  **Future:** `scaling_laws` & `system_2`.
10. **Security:** `prompt_injection` & `human_oversight` (This file).
