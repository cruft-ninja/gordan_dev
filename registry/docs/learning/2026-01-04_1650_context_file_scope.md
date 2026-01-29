---
title: Context File Scope
date: 2026-01-04
tags: [gemini, context, workflow, log]
---

# User Query
The user is asking for confirmation on how the `gemini.md` context file works across different directories. specifically:
1.  If they start in `gnarly_workflow_encabulator` (parent), will I read the `gemini.md` there?
2.  If they start in `gemini_learning_logs` (child), will I read the `gemini.md` here?
3.  Is it really that simple?

# Technical Deep Dive: Context Resolution Logic

### 1. The "Current Working Directory" Rule
Yes, it is (mostly) that simple.
*   **The Rule:** When you run `gemini`, the CLI looks for a file named `GEMINI.md` or `gemini.md` in the **current working directory** (where you typed the command).
*   **Result:** It loads *that specific file* into the System Prompt.

### 2. Scenario A: Inside `gemini_learning_logs/`
*   **File Present:** Yes, we just created `gemini_learning_logs/gemini.md`.
*   **Outcome:** I load this file. I become the "Technical Writer". I log everything to markdown files.

### 3. Scenario B: Inside `gnarly_workflow_encabulator/` (Parent)
*   **File Present:** I do not know yet (we haven't checked).
    *   *If there is NO `gemini.md` there:* I will revert to my default generic assistant persona.
    *   *If there IS a `gemini.md` there:* I will adopt whatever persona is defined in *that* file.

### 4. The "Missing Piece": Recursive Inheritance
Does the CLI look *up* the tree?
*   **Standard Behavior:** Typically, no. It looks in the current folder (`.`). It does not usually walk up to parent directories (like git does looking for `.git`).
*   **Implication:** If you want the "Technical Writer" persona in the parent folder, you must **copy** or **symlink** the `gemini.md` file to that parent folder.

### 5. Summary
You are correct: **Where you start the session determines which `gemini.md` is loaded.**

# Tool Usage
None. Logical verification of CLI behavior.
