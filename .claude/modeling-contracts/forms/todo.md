## Structuring todos

A todo file captures a concrete, actionable work item that surfaced during design — specific enough for an agent or future session to pick up without additional context. Todos are ephemeral and deleted when the work is done.

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
