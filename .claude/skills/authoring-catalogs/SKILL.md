---
name: authoring-catalogs
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages index catalogs — artifact listings, cross-references, entry scaffolding, topic directories. Use when writing, reading, or modifying catalog indexes.
---

!`cat .claude/contracts/forms/catalog.md`

## Reading catalogs

Each topic folder (`actors/`, `contexts/`, `events/`, `invariants/`, `use-cases/`) contains an `index.md`.

- **Catalogs are entry points** — read the index before drilling into individual artifacts. The one-sentence description per entry gives enough context to decide which files to read in full.
- **Cross-references vary by type** — actor entries show use case participation and drive. Event entries show producer and consumers. Use case entries show bounded context and primary actor. The form documents each type's cross-reference pattern.
- **Ordering** — entries are ordered by numeric prefix, matching the file ordering in the folder.
- **Referencing style** — siblings use bare `{nn}-{slug}`. Cross-topic references use `{namespace}/{nn}-{slug}`. No markdown link syntax.

## Authoring catalogs

Use the `create-catalog.sh` script to create new catalog files. The script creates the topic directory and `index.md` skeleton. Does nothing if the index already exists.

```
bash .claude/scripts/create-catalog.sh <model-dir> <topic> <description>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **topic** — the artifact type folder (e.g., `actors`, `use-cases`, `events`)
- **description** — one sentence describing what this artifact type represents in the model

The script outputs the index file path. After creation, add entries using Edit as artifacts are created. Keep the index in sync — update it whenever an artifact is added, removed, or renamed.
