# Editorial standards

Writing principles, tone, and style guidelines for producing or reviewing any prose output in the phase0 system.

## Writing principles

- Lead with what the reader needs.
- Second person ("you") — direct, conversational, professional.
- Present tense — "the method returns."
- Short sentences, short paragraphs — scannable over readable.
- Sentence-case headings.
- Numbered steps for tasks, bullets for options.
- Self-contained pages — link to supporting concepts and include enough context for the page to stand alone.
- Define by presence — say what something is, let that stand. "The facilitator conducts discovery across all three lenses" is a complete assertion. Governance rules own the boundaries.

## Tone — phase0 vision articles

Authoritative, declarative, polished. The voice of a practitioner who has done this — confident, precise, decisive.

## Output format

All durable output is written as markdown files unless otherwise specified.

## Style guidelines

- Prefer bullets, numbered lists, or prose over tables.
- Positive assertions in principles, forms, and instructions. Negative assertions belong to governance and proofreaders.
- Em dash (`—`) for parenthetical breaks, definitions, and appositives. Use the em dash character, not double hyphens (`--`).
- Avoid bold. Headings, bullets, and numbered lists already carry structure — bold adds visual noise without changing how LLMs process the content.
- Capitalize actor role names in prose (User, Orchestrator).

## Renaming and refactoring

When renaming or moving files, search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.
