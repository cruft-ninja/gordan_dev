---
title: Inference Optimization: Speculative Decoding & KV Cache
date: 2026-01-15
tags: [concept, llm-internals, optimization, memory]
log_type: concept_explanation
parent_doc: 2026-01-15_inference_architecture.md
---

# User Query
"System: Please continue." (Context: Deep dive into sequential inference bottlenecks).

# Detailed Explanation

### 1. Speculative Decoding (The Speed Hack)
Addressed how we bypass the $N+1$ sequential limit.
*   **Mechanism:** A small "Draft Model" predicts $N$ tokens ahead.
*   **Verification:** The "Target Model" validates these tokens in parallel.
*   **Gain:** If the draft is accurate, we decode multiple tokens per GPU clock cycle.

### 2. KV Cache (The Memory Cost)
Explored the memory implications of autoregressive decoding.
*   **Function:** Stores attention keys/values for past tokens to prevent re-computation.
*   **Scale:** Linear (or worse) scaling with context length.
*   **Constraint:** 1M context windows require massive VRAM just to hold the *state* of the conversation, separate from the model weights.

# Connection to CLI
This explains why the `gemini` CLI might feel "bursty" or why very long context sessions might have a higher initial latency (loading the KV cache) before streaming begins.
