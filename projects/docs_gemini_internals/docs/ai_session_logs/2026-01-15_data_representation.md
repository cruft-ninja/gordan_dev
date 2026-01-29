---
title: Data Representation: Tokenization & Quantization
date: 2026-01-15
tags: [concept, llm-internals, tokenization, quantization]
log_type: concept_explanation
parent_doc: 2026-01-15_advanced_architecture.md
---

# User Query
"System: Please continue." (Context: Deep dive into Data Representation).

# Detailed Explanation

### 1. Tokenization (The Translator)
Explored how text becomes numbers.
*   **Mechanism:** Subword algorithms (BPE/SentencePiece) balance dictionary size vs. sequence length.
*   **Implication:** Models "see" tokens, not characters. This causes specific weaknesses in character-level tasks (spelling, reversing strings) and arithmetic (digit processing).

### 2. Quantization (The Compression)
Explored how we fit giant brains into small chips.
*   **Precision:** Moving from FP16 (16-bit float) to INT4 (4-bit integer).
*   **Trade-off:** Massive reduction in memory bandwidth (the main bottleneck) and VRAM usage with negligible perplexity (intelligence) loss.
*   **Significance:** This is the primary driver behind "Local LLMs" and cost-effective API serving.

# System View
The complete pipeline is now defined:
`Text` -> `Tokenize` -> `Embed` -> `Inference (Quantized MoE + KV Cache)` -> `Detokenize` -> `Text`.
