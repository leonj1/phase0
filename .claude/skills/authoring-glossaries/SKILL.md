---
name: authoring-glossaries
user-invokable: false
disable-model-invocation: false
description: Writes, reads, and manages glossary entries — definitions, domain vocabulary, alphabetical ordering, renamed terms, context-specific meanings, ubiquitous language. Use when writing, reading, or modifying glossary entries.
---

!`cat .claude/contracts/forms/glossary.md`

## Reading glossaries

The glossary is a single file at `GLOSSARY.md` in the model root. Entries are alphabetical.

- **Model-spanning terms only** — the glossary holds terms that span the model. Terms scoped to one bounded context live in that context's Ubiquitous language section instead.
- **Check both locations** — to find a term's definition, check GLOSSARY.md first, then the relevant context file's Ubiquitous language section.
- **Formerly annotations** — renamed terms carry a "Formerly:" note. If you encounter an unfamiliar term, it may have been renamed — grep the glossary for the old name.

## Authoring glossary entries

Use the `create-glossary-entry.sh` script to add entries. The script creates `GLOSSARY.md` if it doesn't exist and appends the entry.

```
bash .claude/scripts/create-glossary-entry.sh <model-dir> <term> <definition>
```

- **model-dir** — path to the model directory (e.g., `models/marklauter/github-wiki-agent`)
- **term** — the term to define (e.g., `Editorial lens`)
- **definition** — one sentence, present tense, declarative (e.g., `A distinct editorial discipline applied to wiki content during review.`)

The script appends to the end of the file. Use Edit to move the entry into alphabetical position after appending. If a term is only meaningful within one bounded context, add it to that context's Ubiquitous language section instead.
