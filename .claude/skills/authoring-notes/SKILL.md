---
name: authoring-notes
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages notes — captured observations, questions, discoveries, session findings, design rationale, referenced artifacts. Use when writing, reading, or modifying note artifacts.
---

!`cat .claude/contracts/forms/note.md`

## Reading notes

Notes have no index file. Discovery is manual.

- **List** — `ls notes/` within the model directory. The ISO datetime prefix sorts chronologically. Newest notes are often most relevant to active work.
- **Scan by topic** — grep `notes/` to find notes related to a specific artifact, actor, or design question. Matches may appear in the title, Context, Body, or References sections.
- **Follow references** — the `## References` section cross-links back into the model. Use it to find every note that touches a specific artifact.
- **Staleness** — notes are raw captures. Some will have been formalized into artifacts since they were written. Check whether the referenced artifact already incorporates the note's content before acting on it.

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
