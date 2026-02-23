# CLAUDE.md

Domain discovery and design system. Guides a domain expert from an empty whiteboard to an implementation-ready system model through goal-directed Socratic dialogue. Three lenses — actor, use case, bounded context — form a complete graph (K₃) across which discoveries flow freely. Grounded in Alan Cooper's goal-directed design and Eric Evans' domain-driven design. The main conversation is the facilitator; specialist agents formalize what the conversation reveals.

## Modeling

`.claude/modeling-contracts/` contains the instruction set for domain modeling.

- `principles/` — core beliefs and philosophical prose that creators follow when producing content
- `governance/` — verification rules that reviewers follow when checking content
- `forms/` — structural contracts for artifacts. Each form defines the sections, ordering, and placeholder guidance for one artifact type. Forms are pure structure — no philosophy, no creation mechanics. They serve both reading and writing.
- `../scripts/` — deterministic helper scripts that agents call via Bash. Judgment stays in the agent; mechanics stay in the script. Always use relative paths (e.g., `bash .claude/scripts/create-note.sh`) to match permission patterns in `settings.json`.
- Process documents at the root describe the design workflow.

Read the matching form before writing any artifact. The form is the structural authority — same sections, same ordering. When a new artifact type is introduced, create a form in `.claude/modeling-contracts/forms/`, a creation script in `.claude/scripts/`, and corresponding reading and writing skills in `.claude/skills/`.

@.claude/modeling-contracts/principles/facilitator-role.md

@.claude/modeling-contracts/principles/modeling-vocabulary.md

@.claude/modeling-contracts/principles/durable-capture.md

@.claude/modeling-contracts/principles/editorial-standards.md

@.claude/modeling-contracts/model-structure.md

## Agents

- `designing-usecases` at `.claude/agents/designing-usecases.md` — use case lens specialist. Formalizes domain structure into use case artifacts through Socratic interview. Takes a primary actor and conditional goal as input. Preloads philosophy, forms, preservation, and editorial contracts.

## Sample model

`models/marklauter/github-wiki-agent/` contains a complete reference model (GitHub wiki management system) demonstrating all artifact types. Use it as a guide for structure, voice, and level of detail.

## Contracts

A contract is the atomic unit of modeling knowledge. Each contract has two expressions that share the same name:

- The modeling file in `.claude/modeling-contracts/` (a principle, a form, or a governance rule) is the single source of truth — it defines what to produce or what to verify, and carries the authoritative prose.
- The skill file in `.claude/skills/` is a thin loader — YAML front matter for triggering, plus a `!`cat`` directive that injects the modeling file's content at activation time. Skills carry no duplicated body content.

The modeling file is the only place to edit contract content. The skill's YAML `description` is the source of truth for triggering language. Agents receive contract content by listing skills in their `skills:` array — the skill injects the modeling file when the agent loads.

Form contracts map to a pair of skills:

- `reading-*` — `!cat` to the form + discovery and navigation exposition. How to find and interpret artifacts of this type.
- `writing-*` — `!cat` to the form + creation machinery (scripts, guidance). How to produce artifacts of this type.

The form is the single source of truth for structure. The skills add operational knowledge — one for consumption, one for production. Three files, no duplication.

Each layer has one job: principles teach rules, agents declare scope, skills inject content. Say it once, in the right place.

## Renaming and refactoring

When renaming or moving files, always search the entire project for references to the old name/path and update them. Verify with a final grep that zero stale references remain before reporting the task complete.

## Multi-agent orchestration

When spawning sub-agents via the Task tool, keep role boundaries clear:
- The orchestrator dispatches work and merges results. It does not apply editorial judgment.
- Editorial personas, judgment rules, and review standards belong in the sub-agent prompts, not the orchestrator.
- Verify sub-agents have the tool permissions they need (especially Write and Edit) before delegating file-writing tasks.
