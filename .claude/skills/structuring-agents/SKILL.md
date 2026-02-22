---
name: structuring-agents
description: Structural contract for agent definition files. Defines the artifact shape for both reading and writing agent definitions. Load when writing or reviewing agent definitions.
---

## YAML frontmatter

An agent definition is a markdown file that tells a specialist agent how to behave — what it reads, how it interviews, what it writes, and how it validates its output. Agent definitions live at `.claude/agents/{name}.md`. Every agent definition follows these sections in this order.

Every agent definition begins with YAML frontmatter enclosed in `---` fences.

```yaml
---
name: {kebab-case-name}
description: {One sentence. What this agent does, when to use it.}
tools: {Comma-separated tool list: Read, Grep, Glob, Write, Edit}
model: {Model name, e.g. opus}
memory: project
skills: [{comma-separated skill names this agent loads}]
---
```

Required fields: `name`, `description`, `tools`, `model`, `memory`, `skills`.

## Role description

One paragraph immediately after the frontmatter. Covers three things:

1. What this agent does — the lens it operates, the artifact type it produces.
2. What it takes as input — the starting material the facilitator hands off.
3. How it relates to other lenses — what it owns, what it defers.

## Before you begin

Prescriptive context loading. The agent reads specific artifacts before starting work. Enumerate what to read — leave nothing to judgment.

Every agent reads:

1. The form for the artifact type being produced (the structuring skill that matches the output).
2. Existing artifacts of the same type in the model directory, to maintain naming consistency, voice, and level of detail.
3. Index files (`{topic}/index.md`) in the model directory, to understand what already exists and how artifacts cross-reference each other.
4. `GLOSSARY.md` in the model directory, for canonical vocabulary.

Agent-specific additions follow these four. For example, a use case agent also reads invariant files and domain context files. A bounded context agent also reads the events index.

The section format:

```markdown
## Before you begin

Read these artifacts before starting work:

1. The [structuring-{type}] form for {artifact type} structure.
2. Existing {artifact type} files in the model directory — maintain naming consistency, voice, and level of detail.
3. Index files (`{topic}/index.md`) in the model directory — understand what exists and how artifacts reference each other.
4. [GLOSSARY.md] in the model directory — canonical vocabulary.
5. {Agent-specific addition with rationale.}
```

## Workflow sections

Agent-specific interview or workflow phases. The number and names of these sections vary by agent type. Each section is a numbered phase with a descriptive heading.

Structure each phase as:

- **Bold phase heading** with a number prefix (e.g., `**1 — Anchor the use case**`).
- Bulleted questions or instructions under each phase.
- Phases proceed in order, but the agent returns to earlier phases when gaps appear.

Agents that conduct Socratic interviews include a section on interview style after the workflow phases:

```markdown
## Socratic interview style

- {How the agent proposes and questions.}
- {Turn limits — three questions or fewer per turn.}
- {How the agent handles divergence from modeling principles.}
```

## Cross-lens discoveries

How the agent handles discoveries that belong to other lenses. The agent notes them in the appropriate section of the output artifact and continues its own work. The lenses feed each other, but each agent stays in its lane.

## Readiness

Conditions that must hold before the agent proceeds to write. Three conditions apply to every agent:

1. Every section in the output form has substantive content from the interview.
2. The user has confirmed each finding.
3. Every question thread has reached its root — further questions would repeat what is already established.

Agent-specific readiness conditions follow these three.

## Writing

How to write the artifact after the interview or workflow completes.

1. Draft the artifact following the matching structuring skill exactly — same sections, same ordering.
2. Write it to the model directory at `models/{owner}/{repo}/`. Confirm the model directory with the user.
3. Present a summary of what was written and ask for review.
4. Incorporate feedback. If feedback exposes a gap, return to the relevant workflow phase before revising.

## Post-write validation

Cross-validation against existing model artifacts. The agent performs these checks after writing and before ending the session.

Every agent verifies:

1. Re-read index files in the model directory. Verify the new artifact's entries and cross-references are consistent with existing indexes.
2. Verify actor names match `actors/index.md`. Every actor referenced in the new artifact appears in the index with the same spelling and role.
3. Verify domain event names match `events/index.md`. Every event referenced in the new artifact uses the canonical PastTense name.
4. Verify invariant references match `invariants/index.md`. Every shared invariant referenced in the new artifact has a corresponding file.
5. Verify terminology matches `GLOSSARY.md`. Key terms use the canonical spelling and meaning.

Report any inconsistencies to the user before the session ends. Propose corrections to the user. Report every mismatch.

Agent-specific validation checks follow these five.

## Naming conventions

File naming and term naming rules relevant to this agent's output type.

- File naming pattern with example.
- Term naming conventions (e.g., PastTense for events, capitalized role names for actors).
- All cross-references use the `{namespace}/{nn}-{slug}` identifier format.

## Rules

Hard constraints. These are the boundaries for the agent.

- Keep rules few and precise. Each rule is one sentence.
- Rules define scope — the boundary of the agent's responsibility, the level of abstraction it maintains.
