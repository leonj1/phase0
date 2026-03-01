---
name: authoring-todos
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages todos — actionable work items, follow-up tasks, remediation from evaluation findings, ephemeral tracking. Use when writing, reading, or modifying todo artifacts.
---

!`cat .claude/contracts/forms/todo.md`

## Reading todos

Todos live at `todos/` within the model directory. No index, no ordering. They are ephemeral — they exist only while the work is pending.

- **List** — `ls todos/` within the model directory. The slug names the action (e.g., `stub-historian-actor.md`, `revise-populate-scenario-3.md`).
- **What and Why** — the What section describes the work. The Why section explains what surfaced the gap. Together they provide enough context to pick up the work without re-reading the source conversation.
- **References** — cross-links to the artifacts this todo touches. Use these to understand what will change when the work is done.
- **Absence is completion** — when a todo is done, it gets deleted. An empty `todos/` directory means all captured work has been addressed.

## Creating todos

Use the `create-todo.sh` script to create todo files. The script handles file naming, directory creation, and section scaffolding.

```
bash .claude/scripts/create-todo.sh <model-dir> <slug> <title> <what> <why> <references>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **slug** — action in kebab-case (e.g., `stub-historian-actor`, `revise-populate-scenario-3`). No numeric prefix, no datetime.
- **title** — the action title (e.g., `Stub historian actor`)
- **what** — what needs to happen, one to three sentences
- **why** — what discovery exposed this gap, one to two sentences
- **references** — artifacts this todo touches (e.g., `use-cases/01-populate-new-wiki (discovery source)`)

The script outputs the created file path. Todos are ephemeral — delete the file when the work is done.
