# AI Documentation & Logging Standard

## 1. Habitat Registry Structure
All global documentation must be stored in the `registry/docs/` hierarchy:
- `protocol/`: High-level directives and standards.
- `learning/`: Session logs, deep dives, and educational notes.
- `tools/`: Technical references for IDEs, CLI tools, and libraries.
- `archive/`: Deprecated or historical proposals and drafts.

## 2. Filename Convention
- **Format:** `YYYY-MM-DD_HHmm_Topic_Snake_Case.md`
- **Rule:** Use lowercase ONLY. No spaces. Use underscores for word separation.
- **Location:** 
    - **Global Logs/Learning:** `registry/docs/learning/`
    - **Project Specs:** Local `./docs/` subdirectory within the active project.

## 3. Content Structure
- **# User Query**: A clear, concise summary of the turn's objective.
- **# Technical Deep Dive**: A detailed, documentation-style explanation. Refine the interaction into a permanent technical resource. Include command flags, architecture diagrams (text-based), and "gotchas".
- **# Tool Usage**: (Optional) Explain why and how tools were employed.

## 4. Master Index
- **Requirement:** After adding or moving a document, the agent SHOULD update `registry/docs/INDEX.md` to ensure the file is linked and discoverable.
