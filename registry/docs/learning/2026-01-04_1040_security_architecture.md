---
title: Security Architecture
date: 2026-01-04
tags: [security, architecture, guide]
---

# AI Workspace Security Architecture
> **Date:** 2026-01-04
> **Status:** Active
> **Scope:** Global (`/home/ninja/dev`)

## 1. Executive Summary
**"Trust, but Verify (and Isolate)"**

We have implemented a **Defense-in-Depth** security model for AI agents operating within this workspace. As we delegate more autonomy to AI tools, the risk of accidental damage (deleting the wrong folder) or unintended scope creep (modifying a different project's files) increases.

Our solution mimics a corporate security clearance system with three distinct layers:
1.  **The Constitution (Policy):** A written set of laws every agent must read.
2.  **The Contract (Context):** Every project explicitly imports these laws into the AI's mind.
3.  **The Prison (Sandbox):** A physical digital barrier that makes it impossible for the AI to modify files outside its assigned room.

**Impact on Users:**
*   **Standard Mode (`gemini`):** Full access. Use this for cross-project management or when you need the AI to be a "Super User."
*   **Safe Mode (`gemini-safe`):** Restricted access. Use this when working deep inside a sub-project. The AI will be physically unable to touch anything outside that folder.

---

## 2. Technical Implementation

### Layer 1: The Policy (Soft Constraint)
*   **File:** `~/dev/AI_SECURITY_POLICY.md`
*   **Function:** Defines the "Rules of Engagement." It prohibits specific dangerous commands (`rm -rf`, `chmod 777`) and behavioral patterns (blindly retrying errors).
*   **Mechanism:** This file is plain text. It relies on the LLM's ability to understand and follow instructions ("Prompt Engineering").

### Layer 2: The Context Hook (Awareness)
*   **Mechanism:** We appended a "Global Security Context" directive to the bottom of every `gemini.md` file in the workspace.
*   **Code:**
    ```markdown
    # GLOBAL SECURITY CONTEXT
    > **IMPORTANT:** You are strictly bound by the security and operational rules defined in `~/dev/AI_SECURITY_POLICY.md`.
    ```
*   **Effect:** When an agent starts, it loads its specific persona (e.g., "Python Coder") AND the global security rules. This ensures the policy is always "top of mind."

### Layer 3: The Sandbox (Hard Constraint)
*   **Tool:** `gemini-safe` (Bash script wrapper)
*   **Technology:** **Bubblewrap (`bwrap`)**. This is the same sandboxing tech used by Flatpak containers.
*   **How it works:**
    When you run `gemini-safe`, it launches the CLI inside a temporary namespace.
    1.  **Read-Only Mounts:** The entire OS (`/`, `/home`) is mounted as Read-Only.
    2.  **Read-Write Mounts:** ONLY the current working directory (`$PWD`) and necessary temp paths (`/tmp`, `~/.gemini`) are writable.
*   **The Guarantee:** Even if the AI "hallucinates" and tries to run `rm -rf /home/ninja/dev/other_project`, the **Linux Kernel** will reject the system call with `EROFS` (Error: Read-Only File System).

---

## 3. Educational Context: Why this matters?

In Software Engineering, this pattern is known as the **Principle of Least Privilege (PoLP)**. A process (or person) should only have the bare minimum access necessary to do its job.

*   **Before:** Every AI session ran as `ninja` (you), with full power to delete your entire home directory.
*   **After:** An AI session in `script_runner` runs as a confined process that literally cannot see the world outside `script_runner`.

This architecture transforms the AI from a "Wild West" tool into a "Managed Microservice."
