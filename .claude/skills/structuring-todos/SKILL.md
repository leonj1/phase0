---
name: structuring-todos
description: Structural contract for todo documents. Defines the artifact shape for both reading and writing todo files. Load when writing or reviewing todo items captured during design sessions.
---

## Structure

Todo files live at `todos/{slug}.md` within the model directory. One file per work item. The slug captures the action in a few words (e.g., `stub-historian-actor.md`, `revise-populate-scenario-3.md`). The slug alone provides identity — todos are unordered and ephemeral.

```markdown
# {Action title}

## What

{What needs to happen. A concrete, actionable description — specific enough that an agent or future session can pick this up and act on it without additional context. One to three sentences.}

## Why

{Why this matters. What discovery, review, or conversation exposed this gap. Enough to understand the motivation without re-reading the source conversation. One to two sentences.}

## References

{Artifacts this todo touches or depends on. Each reference names the artifact type and identifier.}

- {artifact-type}/{nn}-{slug} ({relationship — e.g., "needs new scenario", "stub created here"})
```

## Lifecycle

Todos are ephemeral. They exist to capture work that needs doing and disappear when the work is done. A completed todo is deleted outright. The artifact it pointed to is the durable record of the work.

## Distinction from notes

Notes preserve durable observations — ideas, tensions, questions that belong to the model's history. Todos capture actionable work items — tasks with a clear completion condition. When an observation implies work, write both: a note for the observation, a todo for the action.
