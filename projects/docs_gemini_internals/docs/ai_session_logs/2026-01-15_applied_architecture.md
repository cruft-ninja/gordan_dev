---
title: Applied Architecture: RAG, Evals & Agents
date: 2026-01-15
tags: [concept, architecture, rag, evals, agents]
log_type: concept_explanation
parent_doc: 2026-01-15_adversarial_safety.md
---

# User Query
"System: Please continue." (Context: Moving from Theory to Application).

# Detailed Explanation

### 1. RAG (Retrieval Augmented Generation)
Explained the standard pattern for "Private Knowledge".
*   **Problem:** Models have frozen knowledge and limited context.
*   **Solution:** Embedding data into Vectors -> Storing in Vector DB -> Semantic Search -> Injecting relevant chunks into Context.
*   **Metaphor:** "Open Book Test" vs "Memorization".

### 2. Evals (LLM-as-a-Judge)
Explained how to test non-deterministic software.
*   **Method:** Using a "Gold Standard" model to grade the outputs of the application based on a rubric (Accuracy, Tone, Safety).
*   **Impact:** Enables CI/CD for Prompts.

### 3. The Agentic Shift
Distinguished between Copilots and Agents.
*   **Copilot:** Human-in-the-loop (Suggestions).
*   **Agent:** Human-on-the-loop (Supervision).
*   **Enabler:** Massive Context Windows (Gemini 1.5) allow agents to hold the entire "World State" (Codebase) in memory, reducing the need for complex RAG retrieval during reasoning.

# Series Finalization
This wraps the extended "Physics of AI" series.
The user is now equipped with the full architectural vocabulary to discuss, debug, and design AI systems within the `~/dev` ecosystem.
