# Registry Indexing and Search

**Date:** 2026-01-06
**Status:** Closed

## Context
The `registry/` directory is evolving into the central knowledge base for the workspace, storing documentation, learning logs, protocols, and archived discussions. As the volume of these documents grows, relying on manual navigation (`cd`, `ls`) and simple file recall is becoming inefficient and error-prone.

## Scope
*   Primary: Indexing and searching content within the `registry/` directory.
*   Secondary: Potentially including `projects/*/docs/` if centralized search is desired.
*   Out of Scope: Indexing code source files (handled by IDEs).

## Goals / Questions
*   **Retrieval Speed:** How can we find the right document in under 5 seconds?
*   **Search Depth:** Do we need just filename search (fuzzy finding) or full-text content search?
*   **Semantic Search:** Is "find documents about setting up python" (semantic) required, or is "grep 'python setup'" (keyword) sufficient?
*   **Integration:** How should this expose itself? A CLI command (e.g., `search_docs`)? A GUI tab in `task_runner_gui`?
*   **Tool Location:** Where should the search script live? `cli_bootstrap_tools`, `registry/scripts/`, or `utils/`?

## Ideas / Notes
*   **Option 1: The Unix Way (Ripgrep/FZF)**
    *   Use `rg` (ripgrep) for fast text search.
    *   Use `fzf` for fuzzy filename finding.
    *   *Pros:* Zero overhead, instant, standard tools.
    *   *Cons:* No semantic understanding.

*   **Search Implementation Prototype (Bash):**
    *   **Status:** Implemented in `utils/registry_search`.
    *   **Code:**
    ```bash
    #!/bin/bash
    # Simple tag search relying on grep
    # Usage: registry_search "tag_name"
    # ...
    ```

*   **Option 2: Python Search Tool**
    *   Develop a script in `task_runner_gui` or `cli_bootstrap_tools`.
    *   Features: Tag filtering, category browsing, simple keyword indexing.
    *   *Pros:* Customizable, fits existing `runner.py` ecosystem.

*   **Option 3: Semantic/Vector Search**
    *   Use a lightweight embedding model (e.g., `sentence-transformers`) to index `registry/`.
    *   Store embeddings locally (JSON or SQLite).
    *   *Pros:* "Natural language" queries.
    *   *Cons:* Complexity, python dependencies, "over-engineering" risk for small volume.

## Metadata & Tagging (Sub-topic)
To enable structured search (Option 2), we need a consistent way to tag files.

*   **Candidate A: YAML Frontmatter (`---`)**
    *   *Format:* YAML block at start of file.
    *   *Pros:* Industry standard (Obsidian, Jekyll, Hugo), readable, supports lists/nesting.
    *   *Verdict:* **Strong Candidate.**
*   **Candidate B: Hashtags (`#tag`)**
    *   *Format:* Inline tags in text.
    *   *Pros:* Easy to type.
    *   *Cons:* Hard to parse reliably, clutters content.
*   **Candidate C: TOML/JSON Frontmatter**
    *   *Pros:* Precise.
    *   *Cons:* Verbose (JSON) or niche (TOML).

## Taxonomy (Draft)
**Style:** `snake_case` (e.g., `prompt_engineering`)

**Core Categories:**
*   `gemini` (The agent, memory, config)
*   `bash` (Shell scripting, CLI tools)
*   `python` (Language, uv, ruff)
*   `prompt_engineering` (Mentorship, techniques)
*   `security` (Policies, safety)
*   `workflow` (Git, project structure, process)
*   `architecture` (System design, internals)
*   `meta` (Project management, discussions)

**Content Types:**
*   `guide` (Tutorials, how-to)
*   `log` (Session logs, dated entries)
*   `reference` (Cheatsheets, glossary)
*   `policy` (Rules, standards)

## Action Items / Decisions
- [x] Assess current document volume to determine if simple grep is enough for now. (Confirmed: grep is sufficient).
- [x] Prototype a simple `search_registry` alias using `ripgrep`. (Implemented `tag_registry_search`).
- [x] Research lightweight local embedding options for future-proofing. (Deferred: Tags chosen as current solution).
- [x] **Decision:** Adopt YAML Frontmatter (`tags: [...]`) for all registry files.
- [x] **Action:** Auto-tag existing registry files (Completed 37+ files).

> **Guideline:** Update this file *during* the discussion as decisions are made, rather than waiting until the end. This helps keep the context active and prevents "drift".
