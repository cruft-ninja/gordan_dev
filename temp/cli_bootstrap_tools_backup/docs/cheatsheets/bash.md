# Bash Cheatsheet (Basics)

## 1. Navigation
| Command | What it does |
| :--- | :--- |
| `pwd` | **Print Working Directory**. Shows where you are. |
| `ls` | **List**. Shows files in the current folder. (Use `ls -la` for hidden files). |
| `cd <folder>` | **Change Directory**. Go into a folder. `cd ..` goes up one level. |

## 2. File Operations
| Command | What it does |
| :--- | :--- |
| `touch <file>` | Creates an empty file. |
| `mkdir <folder>` | Creates a new folder (directory). |
| `cp <src> <dest>` | **Copy**. Copies a file or folder (use `cp -r` for folders). |
| `mv <src> <dest>` | **Move**. Moves (or renames) a file. |
| `rm <file>` | **Remove**. Deletes a file. **Warning: No undo!** |
| `rm -rf <folder>` | Force delete a folder and everything inside it. |

## 3. Viewing Content
| Command | What it does |
| :--- | :--- |
| `cat <file>` | Prints the whole file content to screen. |
| `head <file>` | Shows just the first 10 lines. |
| `tail <file>` | Shows just the last 10 lines. |
| `grep "text" <file>` | Searches for "text" inside a file. |

## 4. Permissions
| Command | What it does |
| :--- | :--- |
| `chmod +x <file>` | Makes a script executable (runnable). |
