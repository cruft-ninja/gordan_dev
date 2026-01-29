---
title: System Constants: Parameters & Compute
date: 2026-01-15
tags: [concept, llm-internals, parameters, flops]
log_type: concept_explanation
parent_doc: 2026-01-15_agency_and_perception.md
---

# User Query
"System: Please continue." (Context: Finalizing the technical deep dive).

# Detailed Explanation

### 1. Parameters vs. Hyperparameters
Clarified the distinction between the "Brain Structure" and the "Mood Settings".
*   **Parameters (Weights):** The 300B+ frozen numbers that constitute the model's knowledge.
*   **Hyperparameters (Inference Config):** Variables like Temperature ($T$) that control the sampling distribution curve during the Decoding Phase.

### 2. The Cost of Thought (FLOPS)
Quantified the computational intensity.
*   **The Rule:** Inference cost $\approx 2 \times P$ FLOPs per token.
*   **Scale:** Generating a short sentence on a large model requires more arithmetic operations than a human performs in a lifetime.

# Series Conclusion
This completes the **"Physics of AI"** series within `projects/docs_gemini_internals/`.
We have mapped the entire journey from **silicon (FLOPS)** to **structure (MoE)** to **software (CLI)** to **user experience (Prompting)**.

**Files Created:**
1.  `2026-01-15_inference_architecture.md` (Parallel vs Sequential)
2.  `2026-01-15_inference_optimization.md` (Speculative Decoding / KV Cache)
3.  `2026-01-15_advanced_architecture.md` (MoE / Attention)
4.  `2026-01-15_data_representation.md` (Tokenization / Quantization)
5.  `2026-01-15_alignment_and_safety.md` (RLHF / Hallucination)
6.  `2026-01-15_agency_and_perception.md` (Function Calling / Vision)
7.  `2026-01-15_system_constants.md` (Parameters / FLOPS - This file)
