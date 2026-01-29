# Discussion: Directory Structure Refactor
**Status:** In Progress
**Goal:** Define rules for folder hierarchy to improve navigation and limit depth.

## Active Topics
| Status | Topic | Context / Notes |
| :--- | :--- | :--- |
| [ ] | **Max Children Rule** | Guideline: Max 10 children. Up to 15 ok if strictly necessary. |
| [x] | **Unique Initials** | Implemented for `projects/`. |
| [x] | **Registry Location** | Decided: `registry` stays in root as global knowledge base. |
| [ ] | **Gemini Files** | How to handle `gemini.md` presence in root vs subfolders regarding clutter. |

## Current Focus: [Documentation Centralization]
*   **Decision:** Project-specific docs stay in project. General/Learning docs move to `registry/`.
*   **Action:** Cleanup of `docs_gemini_internals`, `learning_mentorship_logs` complete.

---
## Decision Log (Archived)
*   [x] **Semantic Naming:** Projects renamed for clarity (e.g., `cli_bootstrap_tools`, `task_runner_gui`).
*   [x] **Project Structure:** "Inverted" `cli_bootstrap_tools` to standard Python/Shell layout (`src`, `scripts`, `lib` in root).
*   [x] **Extensions:** Added `.sh` to scripts in `task_runner_gui`.
*   [x] **Create Template:** Created `_template.md` in `topics/`.
*   [x] **Update README:** Populated `discuss/README.md`.
*   [x] **Move Projects:** Created `projects/` and moved `gnarly`, `script_runner`, `gemini_guru`, `prompt_mentor`, `prompt_engineering`.
*   [x] **Projects Rule:** "Project" folders should live in `projects/`, not root.