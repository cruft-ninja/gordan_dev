# Task Template User Guide

This guide defines the conventions for the Task Description Template to ensure consistency across the Habitat.

## 🔠 Capitalization & Style
*   **YAML Header:** Keys (e.g., `task_id:`) must be lowercase. Values should use Title Case (e.g., `Status: Active`).
*   **Headers:** Use **Emoji + Title Case** (e.g., `# 🎯 Purpose`). This makes the sections visually distinct for humans and easily "indexable" for AI.
*   **Body Text:** Standard sentence case is preferred. User capitalization (for practice/readability) is perfectly acceptable and does not interfere with AI parsing.

## 🏗️ Structure Sections
1.  **YAML Frontmatter:** Used for metadata.
    *   `task_id`: T-001, T-002, etc.
    *   `status`: [Draft, Active, Blocked, Complete]
2.  **Purpose:** Keep this to a single, impactful sentence.
3.  **Requirements:** Use Markdown checkboxes (`- [ ]`). AI agents can check these off as they complete sub-tasks.
4.  **Technical Context:** List specific files and projects to limit the agent's search scope.

## 🤖 AI Interaction
*   Agents are encouraged to update the `updated:` timestamp in the header when significant progress is made.
*   Agents should append progress to the `Execution Notes` section rather than overwriting previous entries.
