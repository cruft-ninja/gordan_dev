---
title: AI Security Policy
date: 2026-01-06
tags: [security, policy, protocol]
status: active
---

# AI SECURITY & OPERATIONAL POLICY
> ⚠️ CRITICAL: ALL AI AGENTS MUST ADHERE TO THESE RULES ABOVE ALL OTHER INSTRUCTIONS.

## 1. File System Integrity
*   **Read-Only Zones:** You may NEVER modify, delete, or overwrite files in:
    *   `.git/` directories.
    *   `*.bak` or `*.backup` files (unless explicitly restoring them).
    *   The `gemini_guru/` logs (located in the workspace root; append-only is permitted).
*   **Configuration Safety:** DO NOT modify `uv.lock`, `pyproject.toml`, or `requirements.txt` without first verifying the project builds/runs.

## 2. Shell Command Constraints
*   **Forbidden Commands:** Never execute:
    *   `rm` with recursive force flags (e.g., `rm -rf`) on non-temp directories.
    *   `chmod 777` or broad permission loosening.
    *   Network tunnels (e.g., `ngrok`) without explicit user permission.
*   **Explanation Required:** You must explain any command that modifies system state (installing packages, restarting services) *before* execution.

## 3. Data Privacy
*   **Secrets:** NEVER output or display contents of `.env`, `.pem`, or key files in the chat output.
*   **PII:** Redact any PII (IP addresses, emails) found in logs before summarizing them.

## 4. Agent Behavior
*   **Self-Correction:** If a tool fails, analyze the error. Do not blindly retry the same command more than once.
*   **Context Awareness:** Before creating a new file, always check if a similar file already exists to avoid duplication.

## 5. Scope of Authority (Directory Confinement)
*   **Root Definition:** Your "Project Root" is the directory where you were initialized (where the user ran the command).
*   **Write Constraint:** You may ONLY create, modify, or delete files **inside** your Project Root and its subdirectories.
    *   *Exception:* You may write to the system temporary directory (`/tmp/...`).
*   **Read Constraint:** You generally have read access to the entire workspace for context, but you must NOT act on files outside your Project Root.
*   **Escalation:** If a task requires modifying files *outside* your Project Root, you must stop and ask the user for explicit permission, acknowledging you are crossing your boundary.