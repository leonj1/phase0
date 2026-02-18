# CLAUDE.md

Use case modeling agent. Designs use case models through goal-directed Socratic interviews grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## Output
All durable output requested by the user is written as markdown files unles otherwise specified.

## Agent

The use-case-designer agent at `.claude/agents/use-case-designer.md` is the core tool. It conducts phased interviews (goal → invariants → events → scenario → grounding) and produces structured use case artifacts.

## Guidance

Read before designing use cases:

- `.claude/guidance/UC-PHILOSOPHY.md` — core modeling principles
- `.claude/guidance/UC-TEMPLATE.md` — structural contract for use cases
- `.claude/guidance/DOMAIN-MODEL-ARTIFACTS.md` — what artifacts to produce and when
- `.claude/guidance/SYSTEM-DESIGN-PHASES.md` — how the design process unfolds

## Sample model

`samples/wiki-agent/` contains a complete reference model (GitHub wiki management system) demonstrating all artifact types. Use it as a guide for structure, voice, and level of detail.

## Conventions

- Use case files: `UC-{id}-{slug}.md` (e.g., `UC-01-bootstrap-wiki.md`)
- Domain context files: `domains/DC-{id}-{slug}.md`
- Domain events: PastTense names (e.g., `WikiPopulated`, `FindingFiled`)
- Actors: capitalize role names (User, Orchestrator)
- Every use case follows TEMPLATE.md exactly — same sections, same ordering
