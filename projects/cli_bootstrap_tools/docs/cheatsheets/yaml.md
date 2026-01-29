# YAML Cheatsheet

YAML (YAML Ain't Markup Language) is a human-readable data serialization standard.

## Basic Syntax

```yaml
# Key-Value pairs (colon + space is mandatory)
name: John Doe
age: 30
is_admin: true   # Booleans: true, false, yes, no
nothing: null    # Null value

# Lists (Sequences)
fruits:
  - Apple
  - Banana
  - Orange

# Inline List
numbers: [1, 2, 3, 4]

# Dictionaries (Maps/Objects)
address:
  street: 123 Main St
  city: Anytown

# Inline Dictionary
coordinates: { lat: 34.05, long: -118.25 }
```

## Strings

```yaml
simple: Just a string
quoted: "Double quotes allow escaped characters: \n"
literal_block: |
  Preserves newlines
  exactly as they appear.
folded_block: >
  Replaces newlines
  with spaces (good for long text).
```

## YAML Frontmatter
Common in static site generators and markdown docs (like this project).
It sits at the very top of a file between triple dashes.

```markdown
---
task_id: T-001
title: "My Task"
tags: [bash, learning]
---

# Document content starts here...
```

