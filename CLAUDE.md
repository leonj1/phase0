# CLAUDE.md

Use case modeling agent. Designs use case models through goal-directed Socratic interviews grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## Output

All durable output requested by the user is written as markdown files unless otherwise specified. Prefer prose, bulleted and numbered lists over tables.

## Modeling

`.claude/modeling/` contains the instruction set for domain modeling.

- **`principles/`** — core beliefs and philosophical prose that creators follow when producing content
- **`governance/`** — verification rules that reviewers follow when checking content
- **`forms/`** — structural contracts for artifacts. Each form defines the sections, ordering, and placeholder guidance for one artifact type. Forms are named after their matching structuring skill (e.g., `structuring-usecases` skill → `structuring-usecases.md` form).
- Process documents at the root describe the design workflow.

Read the matching form before writing any artifact. The form is the structural authority — same sections, same ordering. When a new artifact type is introduced, create a form in `.claude/modeling/forms/` and a corresponding structuring skill in `.claude/skills/`.

Read before writing reference documentation: `.claude/modeling/principles/editorial-guidance.md`

## Facilitation

@.claude/modeling/principles/facilitating-design.md

## Agents

- **`designing-usecases`** at `.claude/agents/designing-usecases.md` — use case lens specialist. Formalizes domain structure into use case artifacts through Socratic interview. Takes a primary actor and conditional goal as input. Preloads philosophy, template, and editorial skills.

## Sample model

`models/marklauter/github-wiki-manager/` contains a complete reference model (GitHub wiki management system) demonstrating all artifact types. Use it as a guide for structure, voice, and level of detail.

## Conventions

- Model output directory: `models/{owner}/{repo}/` (mirrors GitHub URL structure)
- Use case files: `UC-{id}-{slug}.md` (e.g., `UC-01-bootstrap-wiki.md`)
- Domain context files: `domains/DC-{id}-{slug}.md`
- Domain events: PastTense names (e.g., `WikiPopulated`, `FindingFiled`)
- Actors: capitalize role names (User, Orchestrator)
- Every artifact follows its matching form exactly — same sections, same ordering
- Prefer sections, bullets, numbered lists, or prose over tables.

## Ideas

An **idea** is the atomic unit of modeling knowledge. Each idea has two expressions: a source-of-truth file in `.claude/modeling/` (a principle, a form, or a governance rule) and a skill file in `.claude/skills/` that agents load. Both share the same name and the same content. When editing an idea, update both files and verify both before reporting complete.

## Renaming and refactoring

When renaming or moving files, always search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.

## Multi-agent orchestration

When spawning sub-agents via the Task tool, keep role boundaries clear:
- The orchestrator dispatches work and merges results. It does not apply editorial judgment.
- Editorial personas, judgment rules, and review standards belong in the sub-agent prompts, not the orchestrator.
- Verify sub-agents have the tool permissions they need (especially Write and Edit) before delegating file-writing tasks.
