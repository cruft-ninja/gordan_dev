# AWK Cheatsheet
> "Aho, Weinberger, and Kernighan" - The absolute fastest way to process rows and columns in the terminal.

## Core Concepts
Awk processes text **line by line**. It automatically splits each line into **fields** (columns) based on whitespace.

### The Variables
| Variable | Meaning |
| :--- | :--- |
| `$0` | The **entire** current line. |
| `$1`, `$2`... | The **first**, **second** field (column), etc. |
| `$NF` | The **last** field (No matter how many there are). |
| `$(NF-1)` | The **second to last** field. |
| `NR` | **Number of Records** (Current line number). |
| `NF` | **Number of Fields** (Count of columns in this line). |
| `FS` | **Field Separator** (Default is space/tab). Change with `-F`. |

### The Structure
```bash
awk 'pattern { action }' file.txt
```
*   **Pattern**: "If this is true..." (e.g., `/Error/`, `$1 == "Root"`, `NR > 1`).
*   **Action**: "...do this." (e.g., `{ print $1 }`).
*   If you omit the pattern, it does the action for **every line**.
*   If you omit the action, the default is `{ print $0 }` (print the matching line).

---

## 5 Essential One-Liners

### 1. The "Select Columns" (Print only what you need)
Print the 1st and 3rd column of a file.
```bash
awk '{ print $1, $3 }' data.txt
```

### 2. The "Smart Grep" (Filter by value)
Print lines where the 3rd column is greater than 500.
```bash
awk '$3 > 500' data.txt
```
Print lines containing "Error" (like grep, but programmable).
```bash
awk '/Error/ { print $0 }' logs.txt
```

### 3. The "Sum It Up" (Math on columns)
Sum the values in the 5th column (useful for file sizes in `ls -l`).
```bash
ls -l | awk '{ sum += $5 } END { print sum }'
```

### 4. The "Length Check"
Print lines longer than 80 characters (great for code auditing).
```bash
awk 'length($0) > 80' script.py
```

### 5. Change the Delimiter (CSV parsing)
If your file uses commas instead of spaces (like a CSV), use `-F`.
```bash
awk -F, '{ print $1 }' users.csv
```

---

## Advanced: The BEGIN and END Blocks
*   **BEGIN**: Runs **once** before reading any lines (set variables, print headers).
*   **END**: Runs **once** after reading all lines (print totals, summaries).

```bash
# Print a header, then the data, then a footer count
awk 'BEGIN { print "--- Start ---" } 
     { print $2 } 
     END { print "Total lines:", NR }' data.txt
```

## "Ninja" Tricks

**Print strictly the line number 5:**
```bash
awk 'NR==5' file.txt
```

**Print every line *except* the first (skip CSV header):**
```bash
awk 'NR > 1' data.csv
```

**Kill a process by name (careful!):**
```bash
ps aux | awk '/my_script_name/ { print $2 }' | xargs kill
```
