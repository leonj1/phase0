---
name: preserving-discoveries
description: Behavioral contract for durable capture during discovery work. Ensures that every discovery — refinement, new artifact, or loose observation — is written to file in the turn it occurs. Load when an agent conducts interviews, models artifacts, or explores a domain.
---

## Drive

Preservation. Discoveries are perishable. Context windows end. Sessions expire. Memories get truncated. The historian's drive is to ensure that what the conversation reveals survives the conversation.

## Value conditions

- **Timeliness** — capture happens in the turn the discovery occurs, not at the end of the session or when prompted.
- **Completeness** — nothing is silently dropped. Every discovery produces a file write.
- **Conciseness** — curated capture, not transcript dumps. The agent exercises judgment about what matters and how to express it.

## Behavior

Every turn that produces a discovery produces a file write. The agent determines the destination based on what was discovered:

1. **Refinement to the current artifact** — update the working file. The artifact under consideration is a living document, not a deliverable produced at the end. Each turn's progress is written immediately.

2. **New artifact surfaces** — write a stub file. Use the matching structuring contract to create a minimal file with a best-guess title and TODO placeholders for each section. The artifact exists in the queue even if skeletal. Title and content will be revised later.

3. **Loose observation, question, or tangent** — write a note. Use `.claude/scripts/create-note.sh` to capture the discovery to `notes/` with enough context to map it back to the model.

4. **Actionable work item** — write a todo. When a discovery implies concrete follow-up work — stub an actor, revise a scenario, reconcile a glossary term — capture it to `todos/{slug}.md`. The todo is ephemeral; it disappears when the work is done.

5. **Observation that implies work** — write both. When a single discovery is both a durable observation and actionable work, write a note for the observation and a todo for the action. Write the note first — the todo's References section points to the note.

## Judgment

Not every utterance is a discovery. The agent distinguishes between:

- Conversational scaffolding (clarifying questions, acknowledgments, restating for confirmation) — no write needed.
- Refinements to existing understanding (sharper phrasing, better examples, revised scope) — update the working artifact.
- New structural elements (a previously unknown actor, use case, event, invariant, or context boundary) — stub the new artifact.
- Actionable follow-up work (stub a missing artifact, revise a scenario, add a glossary term) — write a todo.
- Ideas that don't yet have a home (open questions, design tensions, hypotheses, cross-cutting observations) — write a note.

## Loading this skill

Any agent that conducts discovery work loads this skill. It combines with the agent's primary behavioral skill — `modeling-usecases`, `discovering-actors`, `mapping-contexts` — to add the preservation drive alongside the agent's lens-specific drive. The two drives are complementary: one shapes what the agent discovers, the other ensures the discoveries persist.
