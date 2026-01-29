# Python Cheatsheet (Basics)

## 1. Running Code
| Command | What it does |
| :--- | :--- |
| `python main.py` | Runs the script `main.py`. |
| `python` | Starts the interactive Python shell (REPL). |

## 2. Basic Syntax
```python
# Variables
name = "Ninja"
count = 42

# Printing
print(f"Hello, {name}!")

# Lists (Arrays)
items = ["apple", "banana", "cherry"]
items.append("date")
print(items[0])  # apple

# Dictionaries (Key-Value)
user = {"name": "Ninja", "role": "admin"}
print(user["name"])

# Loops
for item in items:
    print(item)

# Conditionals
if count > 10:
    print("Large number")
else:
    print("Small number")
```

## 3. Functions
```python
def greet(who):
    return f"Hello, {who}"

print(greet("World"))
```

## 4. Virtual Environments (Standard Library)
*Note: We use `uv` in this project, but here is the standard way.*
```bash
python -m venv .venv       # Create
source .venv/bin/activate  # Activate (Linux/Mac)
deactivate                 # Exit
```
