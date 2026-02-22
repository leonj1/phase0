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

Read before writing reference documentation: `.claude/modeling/principles/writing-documentation.md`

## Facilitation

@.claude/modeling/principles/facilitating-design.md

## Agents

- **`designing-usecases`** at `.claude/agents/designing-usecases.md` — use case lens specialist. Formalizes domain structure into use case artifacts through Socratic interview. Takes a primary actor and conditional goal as input. Preloads philosophy, forms, and editorial skills.

## Sample model

`models/marklauter/github-wiki-agent/` contains a complete reference model (GitHub wiki management system) demonstrating all artifact types. Use it as a guide for structure, voice, and level of detail.

## Conventions

- Model output directory: `models/{owner}/{repo}/` (mirrors GitHub URL structure)
- Actor files: `actors/{nn}-{slug}.md` (e.g., `actors/01-user.md`)
- Use case files: `use-cases/{nn}-{slug}.md` (e.g., `use-cases/01-populate-new-wiki.md`)
- Context files: `contexts/{nn}-{slug}.md` (e.g., `contexts/01-wiki-creation.md`)
- Event files: `events/{nn}-{slug}.md` (e.g., `events/01-wiki-populated.md`)
- Invariant files: `invariants/{nn}-{slug}.md` (e.g., `invariants/01-source-repo-readonly.md`)
- Index files: `{topic}/index.md` in each artifact folder (e.g., `actors/index.md`)
- Glossary: `GLOSSARY.md` at model root
- Domain events: PastTense names (e.g., `WikiPopulated`, `FindingFiled`)
- Actors: capitalize role names (User, Orchestrator)
- Every artifact follows its matching form exactly — same sections, same ordering
- Prefer sections, bullets, numbered lists, or prose over tables.

## Ideas

An **idea** is the atomic unit of modeling knowledge. Each idea has two expressions: a source-of-truth file in `.claude/modeling/` (a principle, a form, or a governance rule) and a skill file in `.claude/skills/` that agents load. Both share the same name.

- The **source-of-truth file** carries the full content: an H1 title, an opening description paragraph, and the body.
- The **skill file** carries YAML front matter (`name`, `description`) that replaces the H1 title and opening paragraph. The body begins at the first line of net-new content — no heading, no repeated description.

When editing an idea, update both files and verify both before reporting complete.

## Renaming and refactoring

When renaming or moving files, always search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.

## Multi-agent orchestration

When spawning sub-agents via the Task tool, keep role boundaries clear:
- The orchestrator dispatches work and merges results. It does not apply editorial judgment.
- Editorial personas, judgment rules, and review standards belong in the sub-agent prompts, not the orchestrator.
- Verify sub-agents have the tool permissions they need (especially Write and Edit) before delegating file-writing tasks.
