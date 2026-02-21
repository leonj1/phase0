# CLAUDE.md

Use case modeling agent. Designs use case models through goal-directed Socratic interviews grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## Output

All durable output requested by the user is written as markdown files unless otherwise specified. Prefer prose, bulleted and numbered lists over tables.

## Forms

`.claude/forms/` contains structural contracts — the canonical shapes for artifacts that humans and agents produce and consume. Each form defines the sections, ordering, and placeholder guidance for one artifact type.

- Read the matching form before writing any artifact. The form is the structural authority — same sections, same ordering.
- Forms are named after their matching structuring skill (e.g., `structuring-usecases` skill → `structuring-usecases.md` form).
- When a new artifact type is introduced, create a form for it in `.claude/forms/` and a corresponding structuring skill in `.claude/skills/`.

## Agents

- **`designing-usecases`** at `.claude/agents/designing-usecases.md` — the primary agent. Discovers domain structure through Socratic interview and writes use case artifacts. Preloads philosophy, template, and editorial skills.

## Guidance

Read before writing reference documentation `.claude/guidance/editorial-guidance.md`

Read before designing, reading, or writing use cases:

- `.claude/guidance/usecase-philosophy.md` — core modeling principles
- `.claude/forms/structuring-usecases.md` — structural contract for use cases
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
- Every artifact follows its matching form exactly — same sections, same ordering
- Prefer sections, bullets, numbered lists, or prose over tables.

## Renaming and refactoring

When renaming or moving files, always search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.

## Multi-agent orchestration

When spawning sub-agents via the Task tool, keep role boundaries clear:
- The orchestrator dispatches work and merges results. It does not apply editorial judgment.
- Editorial personas, judgment rules, and review standards belong in the sub-agent prompts, not the orchestrator.
- Verify sub-agents have the tool permissions they need (especially Write and Edit) before delegating file-writing tasks.
