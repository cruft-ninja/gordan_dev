1. Structural Design (The "Skeleton")
  To ensure the template is both "AI-agent friendly" and "Token efficient," I suggest using a structured
  header (like YAML frontmatter) followed by functional Markdown sections.

  Proposed Layout:

    1 ---
    2 task_id: T-001
    3 title: "Task Name"
    4 status: [Draft | Active | Blocked | Complete]
    5 owner: [Hats / User]
    6 priority: [P0 | P1 | P2]
    7 created: YYYY-MM-DD
    8 ---
    9 
   10 # 🎯 Purpose
   11 A single, high-level sentence. (e.g., "Refactor the documentation logging to reduce token overhead.
   12 
   13 # 📋 Requirements
   14 - [ ] Requirement 1
   15 - [ ] Requirement 2
   16 
   17 # 🏗️ Technical Context
   18 - **Affected Projects:** [e.g., script_runner, gnarly_workflow]
   19 - **Relevant Files:** [paths to files]
   20 
   21 # 📝 Execution Notes
   22 *Brainstorming or iterative logs during the task.*

  2. Discussion Points & Questions
   * Central Location: You mentioned a central location. Should we create a ~/dev/tasks/ directory, or
     perhaps a TASKS.md ledger at the root? A dedicated directory allows each task to be its own file
     (easier for AI to read one specific file without "The Window" blowing up).
   * State Management: How should we handle "Status"? Should the AI update the status automatically when
     a task is finished, or is that a manual "Management" (User) action?
   * Human vs. AI Style: You mentioned capitalization for your own typing practice. I recommend we stick
     to a standard (like Title Case for headers) because consistency helps the AI recognize the structure
     of the document faster, even if the case itself doesn't change the logic.

  3. Feasibility of Features
   * Token Efficiency: Using checkboxes (- [ ]) is extremely token-efficient and allows agents to "see"
     progress instantly.
   * Automation: We could potentially write a "Hat" command (e.g., gemini create-task) that scaffolds
     this file based on your input.
