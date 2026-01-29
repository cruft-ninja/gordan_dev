# Git Cheatsheet (Basics)

## 1. Getting Started
| Command | What it does |
| :--- | :--- |
| `git init` | Turns the current folder into a new Git repository. |
| `git clone <url>` | Downloads an existing project from the internet (like GitHub) to your computer. |

## 2. Saving Changes
Think of saving in Git as a two-step process: **Staging** (preparing the box) and **Committing** (sealing the box).

| Command | What it does |
| :--- | :--- |
| `git add <file>` | **Stage a file.** Tells Git, "Include this file's changes in the next save." Use `git add .` to add *everything*. |
| `git commit -m "message"` | **Save.** Takes everything you staged and saves it as a permanent snapshot with a description. |

## 3. Checking Status
| Command | What it does |
| :--- | :--- |
| `git status` | **The most important command.** Tells you what files have changed, what is staged, and what is untracked. Run this often! |
| `git diff` | Shows you the exact text changes you made to files that haven't been staged yet. |
| `git log` | Shows a list of all past commits (history). |

## 4. Syncing with Others (or Backup)
| Command | What it does |
| :--- | :--- |
| `git push` | Uploads your commits to a remote server (like GitHub). |
| `git pull` | Downloads new changes from the remote server and updates your files. |

**Pro Tip:** If you ever feel lost, just run `git status`. It usually tells you exactly what state you are in and often suggests what to do next.
