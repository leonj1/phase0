---
name: reading-notes
description: This skill should be used when the user asks to "read a note", "review notes", "check what was captured", or when an agent needs to understand the structure of note files. Loads the structural contract for note documents.
---

!`cat .claude/modeling-contracts/forms/structuring-notes.md`

## Reading notes

Notes have no index file. Discovery is manual.

- **List** — `ls notes/` within the model directory. The ISO datetime prefix sorts chronologically. Newest notes are often most relevant to active work.
- **Scan by topic** — grep `notes/` to find notes related to a specific artifact, actor, or design question. Matches may appear in the title, Context, Body, or References sections.
- **Follow references** — the `## References` section cross-links back into the model. Use it to find every note that touches a specific artifact.
- **Staleness** — notes are raw captures. Some will have been formalized into artifacts since they were written. Check whether the referenced artifact already incorporates the note's content before acting on it.
