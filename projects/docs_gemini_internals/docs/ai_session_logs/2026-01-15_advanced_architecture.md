---
title: Advanced Architecture: MoE & Attention Scaling
date: 2026-01-15
tags: [concept, llm-internals, moe, attention]
log_type: concept_explanation
parent_doc: 2026-01-15_inference_optimization.md
---

# User Query
"System: Please continue." (Context: Deep dive into Model Architecture).

# Detailed Explanation

### 1. Mixture of Experts (MoE)
Explored the "Sparse Activation" paradigm.
*   **Concept:** The model is a collection of specialized sub-networks ("Experts").
*   **Routing:** A gating network routes tokens to only a fraction of the experts (e.g., Top-2).
*   **Metric:** Distinguishes between **Total Parameters** (Disk size/VRAM) vs. **Active Parameters** (Compute cost per token).
*   **Result:** High intelligence with low inference latency.

### 2. The Context Challenge ($O(N^2)$)
Addressed the mathematical limits of the Context Window.
*   **Standard Attention:** Quadratic complexity. Comparing every token to every other token.
*   **Long Context:** Requires architectural shifts (Ring Attention, Linear Attention, etc.) to handle 1M+ tokens without exponential compute growth.

# Relevance to "Gemini CLI"
This explains why the CLI can "read" an entire repository (MoE/Efficient Attention) but still requires careful prompting to ensure the *right* experts are activated (Prompt Engineering).
