# CLAUDE.md

Use case modeling agent. Designs use case models through goal-directed Socratic interviews grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## Output

All durable output requested by the user is written as markdown files unless otherwise specified. Prefer prose, bulleted and numbered lists over tables.

## Agent

The use-case-designer agent at `.claude/agents/use-case-designer.md` is the core tool. It conducts phased interviews (goal → invariants → events → scenario → grounding) and produces structured use case artifacts.

## Guidance

Read before writing reference documentation `.claude/guidance/editorial-guidance.md`

Read before designing use cases:

- `.claude/guidance/usecase-philosophy.md` — core modeling principles
- `.claude/guidance/usecase-template.md` — structural contract for use cases
- `.claude/guidance/DOMAIN-MODEL-ARTIFACTS.md` — what artifacts to produce and when
- `.claude/guidance/SYSTEM-DESIGN-PHASES.md` — how the design process unfolds

## Sample model

`samples/wiki-agent/` contains a complete reference model (GitHub wiki management system) demonstrating all artifact types. Use it as a guide for structure, voice, and level of detail.

## Conventions

- Model output directory: `models/{owner}/{repo}/` (mirrors GitHub URL structure)
- Use case files: `UC-{id}-{slug}.md` (e.g., `UC-01-bootstrap-wiki.md`)
- Domain context files: `domains/DC-{id}-{slug}.md`
- Domain events: PastTense names (e.g., `WikiPopulated`, `FindingFiled`)
- Actors: capitalize role names (User, Orchestrator)
- Every use case follows usecase-template.md exactly — same sections, same ordering
- Prefer sections, bullets, numbered lists, or prose over tables.

## Renaming and refactoring

When renaming or moving files, always search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.

## Multi-agent orchestration

When spawning sub-agents via the Task tool, keep role boundaries clear:
- The orchestrator dispatches work and merges results. It does not apply editorial judgment.
- Editorial personas, judgment rules, and review standards belong in the sub-agent prompts, not the orchestrator.
- Verify sub-agents have the tool permissions they need (especially Write and Edit) before delegating file-writing tasks.
