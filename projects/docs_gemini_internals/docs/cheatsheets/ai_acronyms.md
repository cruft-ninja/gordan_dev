---
title: AI Engineering Acronyms
date: 2026-01-15
tags: [reference, glossary, acronyms]
---

# AI Engineering & Architecture Glossary

A quick reference for the acronyms governing Modern AI and the Gemini Ecosystem.

## Model Architecture
| Acronym | Full Name | Definition |
| :--- | :--- | :--- |
| **LLM** | Large Language Model | A neural network trained on vast text data to generate human-like text (e.g., Gemini 1.5). |
| **SLM** | Small Language Model | Efficient models (<10B parameters) designed for local/edge devices (e.g., Gemma, Llama-3-8B). |
| **MoE** | **Mixture of Experts** | A sparse architecture where only a fraction of parameters ("experts") are active per token, increasing efficiency. |
| **VLM** | Vision Language Model | Multimodal models capable of processing images and text natively (e.g., Gemini). |
| **KV** | Key-Value (Cache) | The memory mechanism storing past attention states to speed up sequential token generation. |
| **BPE** | Byte Pair Encoding | The standard algorithm for **Tokenization**, breaking text into subword units. |

## Training & Alignment
| Acronym | Full Name | Definition |
| :--- | :--- | :--- |
| **SFT** | Supervised Fine-Tuning | Training a base model on high-quality Q&A examples to teach it how to follow instructions. |
| **RLHF** | **Reinforcement Learning from Human Feedback** | Using human preferences to train a "Reward Model" that steers the LLM toward helpfulness/safety. |
| **RLAIF** | RL from AI Feedback | Scaling alignment by using a strong AI (instead of humans) to rate the outputs of a weaker AI. |
| **DPO** | Direct Preference Optimization | A newer, more stable alternative to RLHF that optimizes the model directly on preference data without a separate reward model. |

## Inference & Prompting
| Acronym | Full Name | Definition |
| :--- | :--- | :--- |
| **RAG** | **Retrieval Augmented Generation** | Injecting external data (from files/databases) into the context window to ground the model's answers. |
| **CoT** | **Chain of Thought** | A prompting technique encouraging the model to "show its work" step-by-step to improve logic. |
| **ReAct** | Reason + Act | An agentic pattern where the model loops between **Reasoning** (Thinking) and **Acting** (Using Tools). |
| **TTFT** | Time To First Token | The latency between sending a request and seeing the first character of the response. |
| **TPS** | Tokens Per Second | The speed of text generation (Inference throughput). |

## Compute & Data
| Acronym | Full Name | Definition |
| :--- | :--- | :--- |
| **FLOPS** | Floating Point Operations Per Second | The standard unit of measurement for AI compute power (Training & Inference). |
| **GPU/TPU** | Graphics/Tensor Processing Unit | Hardware accelerators specialized for the matrix multiplication required by deep learning. |
| **FP16** | Floating Point 16-bit | Standard precision for model weights. |
| **INT4** | Integer 4-bit | **Quantization** format reducing model size by ~75% for efficient local execution. |
