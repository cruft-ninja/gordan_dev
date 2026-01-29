---
title: Alignment & Reliability: RLHF & Hallucination
date: 2026-01-15
tags: [concept, llm-internals, alignment, hallucination]
log_type: concept_explanation
parent_doc: 2026-01-15_data_representation.md
---

# User Query
"System: Please continue." (Context: Deep dive into Alignment and Behavior).

# Detailed Explanation

### 1. Post-Training Pipeline (Making it Helpful)
Distinguished between "Base Models" (Auto-complete engines) and "Instruct Models" (Assistants).
*   **SFT (Supervised Fine-Tuning):** Teaching the format of dialogue.
*   **RLHF/RLAIF (Reinforcement Learning):** Optimizing for preference (Helpfulness, Safety, Truthfulness). Moving from "what comes next?" to "what is best?".

### 2. Hallucination (The Feature-Bug)
Explained the root cause of fabrication.
*   **Probabilistic Nature:** Models minimize "perplexity" (surprise), not factual error. A plausible lie has lower perplexity than "I don't know" if not explicitly trained otherwise.
*   **Solution = Grounding:** RAG (Retrieval Augmented Generation) and Context Injection (what this CLI does) shift the model's focus from "Internal Parametric Memory" (prone to hallucination) to "External Context" (verifiable facts).

# Final Synthesis
This concludes the "Full Stack" tour of the LLM:
`Architecture (MoE)` -> `Input (Tokenization)` -> `Compute (Inference/KV Cache)` -> `Alignment (RLHF)` -> `Output`.
