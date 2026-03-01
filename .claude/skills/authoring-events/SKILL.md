---
name: authoring-events
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages domain event files — PastTense-named state transitions with producers, consumers, payloads, materialization, bounded context ownership. Use when writing, reading, or modifying domain event artifacts.
---

!`cat .claude/contracts/forms/event.md`

## Reading events

Events live at `events/` within the model directory, with an `index.md` catalog.

- **Start with the index** — `events/index.md` lists every event with its producer and consumers. Read the index for the full event catalog before drilling into individuals.
- **PastTense naming** — event names describe what happened (WikiPopulated, FindingFiled). The name alone should convey the state transition.
- **Context section** — names the bounded context, the producing use case, the consumers, and the materialization. This is the event's integration contract.
- **Payload** — the data the event carries. Each item is a noun or noun phrase. The payload defines what downstream consumers can depend on.

## Authoring events

Use the `create-event.sh` script to create domain event files. The script handles file naming, directory creation, and section scaffolding with TODO placeholders.

```
bash .claude/scripts/create-event.sh <model-dir> <nn> <slug> <event-name> <context-ref> <producer-ref> <description>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **nn** — zero-padded number (e.g., `01`). Check `events/index.md` or list the directory for the next available.
- **slug** — event name in kebab-case (e.g., `wiki-populated`, `finding-filed`)
- **event-name** — PastTense name (e.g., `WikiPopulated`, `FindingFiled`, `DriftDetected`)
- **context-ref** — bounded context path (e.g., `contexts/01-wiki-creation`)
- **producer-ref** — producing use case path (e.g., `use-cases/01-populate-new-wiki`)
- **description** — one paragraph: what happened and why it matters

The script outputs the created file path. Add an entry to `events/index.md` after creating.
