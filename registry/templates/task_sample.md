---
task_id: T-001
title: "Initialize Habitat Registry"
status: Complete
owner: Overseer
priority: P0
created: 2026-01-05
updated: 2026-01-05
---

# 🎯 Purpose
Establish a centralized directory for management files, templates, and task tracking.

# 📋 Requirements
- [x] Create root `/registry` directory.
- [x] Relocate `/templates` and `/tasks` into the registry.
- [x] Create a standardized task template.
- [x] Document usage conventions in a Guide.

# 🏗️ Technical Context
- **Affected Projects:** Global Habitat
- **Relevant Files:** `registry/templates/task_template.md`, `registry/templates/GUIDE.md`

# 🛠️ Proposed Implementation
Use shell commands to restructure the filesystem and `write_file` to generate documentation artifacts.

# 📝 Execution Notes
- 2026-01-05: Grouped directories into `registry/` to reduce root clutter.
- 2026-01-05: Drafted initial template and guide based on user collaboration.

# ✅ Completion Criteria
Registry exists with working templates and clear documentation.
