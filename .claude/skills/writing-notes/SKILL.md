---
name: writing-notes
description: This skill should be used when the user asks to "write a note", "capture an observation", "create a design note", or when an agent needs to create note files during design work. Loads the structural contract and the creation script.
---

!`cat .claude/modeling-contracts/forms/structuring-notes.md`

## Creating notes

Use the `create-note.sh` script to create note files. The script handles naming (ISO timestamp + slug), directory creation, and section scaffolding.

```
bash .claude/scripts/create-note.sh <model-dir> <slug> <topic> <context> <body> <references>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **slug** — short topic identifier for the filename (e.g., `historian-as-skill`)
- **topic** — the note's H1 title
- **context** — what spawned this note (one to three sentences)
- **body** — the substance (observations, questions, proposals)
- **references** — links back into the model (e.g., `actors/01-user (primary actor discovered here)`)

The script outputs the created file path.
