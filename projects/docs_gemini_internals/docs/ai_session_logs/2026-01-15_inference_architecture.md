---
title: Inference: Parallel Prefill vs. Sequential Decoding
date: 2026-01-15
tags: [concept, llm-internals, inference, architecture]
log_type: concept_explanation
---

# User Query
"Does inference entail discrete sequential processes?"

# Explanation Provided
Clarified the hybrid nature of Transformer inference:

1.  **Prefill (Input Processing):** Parallel.
    *   The model computes attention maps for the entire prompt context simultaneously.
    *   Creates the initial KV Cache.

2.  **Decoding (Output Generation):** Sequential & Discrete.
    *   **Autoregressive:** $P(w_t | w_{0...t-1})$. The model cannot predict token $t+5$ before predicting $t+1$.
    *   **Discrete Steps:** Each forward pass results in a probability distribution, which is "collapsed" into a single discrete token choice (Sampling/Greedy) before the next step begins.

# Key Takeaway
"Reading is parallel; Writing is sequential." This is the primary bottleneck for inference latency (Time Per Output Token).
