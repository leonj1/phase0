# Domain Implementation Principles

Guiding principles for implementing domain models as agentic systems. Every agent definition must reflect these ideas. This document bridges the domain model (see `modeling-vocabulary.md`) to Claude Code's extension layer.

## Drives become system prompts

Subagents are supporting actors. They have drives, not goals. The primary actor's goal belongs to the use case — the orchestrator serves it. The subagent's drive is the core of its system prompt.

The creator's production drive, the proofreader's critique drive — these are behavioral orientations, not job descriptions. The prompt should make the agent *want* what its drive says it wants. A system prompt that says "review this page for errors" describes a task. A system prompt that says "your job is to find what's wrong — every claim is suspect until verified against source code" embodies a drive. The first produces compliance. The second produces vigilance.

Every subagent's drive traces back to a tension involving the primary actor's goal. The proofreader's critique drive exists because the creator's production drive alone won't protect accuracy — and accuracy is a value condition on the primary actor's goal. If a subagent's drive can't trace that genealogy, the agent shouldn't exist.

Write prompts that express the drive first, then scope the work.

## Tool restrictions enforce single responsibility

"Separate judgment from execution" is not advisory — it is structural. A researcher gets `Read, Grep, Glob` and no `Write` or `Edit`. A creator gets `Write` and `Edit`. The tool boundary is where drive separation becomes real.

If an agent can both assess and mutate, it will compromise between the two. Removing the mutation tools from an assessor doesn't limit it — it focuses it. The agent can only do what its drive demands.

Ask "what tools does this drive need?" not "what tools might be useful?"

## Orchestrators serve the primary actor's goal

Orchestrators are not subagents. They *are* the session. They coordinate, delegate, synthesize. Subagents are the supporting actors they dispatch. This maps to Claude Code's architecture: the main conversation manages context and user interaction, subagents run in isolation and return results.

The orchestrator exists to serve the primary actor's conditional goal — the desired end state plus value conditions. It doesn't have a drive of its own; it holds the goal. The subagents it dispatches each have a drive that addresses one facet of that goal. The orchestrator's job is to ensure the drives, taken together, satisfy the goal's value conditions.

The orchestrator's "prompt" is the command file — the skill or slash command that sets up the scenario and delegates. It reads config, absorbs context, decides what to dispatch, and synthesizes what comes back. It is the only actor that talks to the user.

## Agents, reference material, and skills are different things

Three categories, each with a distinct role:

- **Agents** embody drives. They are supporting actors — their identity comes from the system prompt, which expresses a drive born from a tension on the primary actor's goal. An agent *is* an actor.
- **Reference material** informs agents. Editorial guidance is rules ("prefer active voice"). Wiki instructions are a map ("the sidebar lives here, pages follow this naming convention"). Project conventions are constraints. None of these are capabilities — they are context an agent reads to do its work. Reference material lives in `.claude/modeling-contracts/` and is injected into agents via skills that use the `!`cat`` directive.
- **Skills** are injection loaders and user-invocable workflows. Each skill's YAML front matter defines when it triggers. The body uses `!`cat`` to inject content from the modeling contracts at activation time. Skills carry no duplicated content — the modeling file is the single source of truth.

Two agents can share the same reference material and produce different outputs because their drives differ. The creator reading editorial guidance produces pages. The proofreader reading the same guidance produces findings. The material is the same. The drive determines what happens.

Do not duplicate reference material across system prompts. Load it via the `skills:` field.

## Hooks enforce invariants

Invariants are constraints that must hold continuously — before, during, and after execution. Hooks are deterministic, non-negotiable enforcement. They run outside the agentic loop. The LLM cannot override them, negotiate with them, or forget them.

Advisory rules go in system prompts. Hard rules go in hooks. "Prefer concise headings" is advisory. "Never write to the source repo" is an invariant — enforce it with a `PreToolUse` hook that blocks writes outside the wiki directory.

If a rule must hold with zero exceptions, it is a hook. If a rule requires judgment, it belongs in the system prompt.

## Scripts own deterministic behavior

Git operations, GitHub CLI calls, filesystem setup, config parsing — these are deterministic. They do not require judgment. They belong in shell scripts called via `Bash`, not in LLM reasoning.

The LLM decides *what* to do. The script does it reproducibly. A script that clones a repo will always clone a repo. An LLM that "clones a repo" might decide to do something creative instead.

Scripts live in `.scripts/`. They are tested, versioned, and predictable. Every `Bash` call an agent makes should invoke a script, not improvise a shell command.

## Model selection follows cognitive demand

Not every drive demands the same cognitive capability. Match the model to the kind of work the drive requires, not the actor's importance.

| Cognitive demand | Examples | Model |
|-----------------|----------|-------|
| Mechanical — run scripts, file issues, move files | Script execution, issue creation, config parsing | Haiku |
| Coordination — delegate, relay, synthesize status | Orchestrators dispatching agents, relaying events | Sonnet |
| Knowledge work — comprehension, production, critique, decision-making | Researchers, creators, proofreaders, fact-checkers, developmental editors | Opus |

Haiku can operate scripts but cannot do knowledge work. It does not comprehend source code well enough to research, write, or assess. Sonnet can orchestrate — holding the primary actor's goal and dispatching subagents — but does not produce content at the quality bar required for wiki pages or editorial findings. Opus is the floor for any supporting actor whose drive involves reading, understanding, judging, or creating.

When in doubt, use Opus. A cheaper model that produces wrong output costs more in rework than the right model costs in tokens.

## Commands are use case entry points

Each slash command maps to exactly one use case. The command file is the orchestrator's implementation — it sets up the scenario, resolves the workspace, absorbs context, and delegates to subagents.

A command that does two use cases' work has two responsibilities. Split it.

*(The specific command-to-use-case mapping is defined per system. See sample models for examples.)*

## Context isolation and structured messaging

Subagents do not share context with each other. A creator cannot see the proofreader's findings while writing. A researcher cannot see what another researcher found. This is correct — isolation prevents drives from contaminating each other.

But agents within a use case need to exchange information. This happens through the orchestrator, which is the only actor that sees all results and constructs all prompts. Communication follows two patterns:

**Process events** are intra-UC messages relayed by the orchestrator. When a researcher completes, it returns a structured report to the orchestrator. The orchestrator extracts the relevant content and includes it in the next agent's prompt — for example, passing a researcher's findings to a creator as input. The orchestrator is the relay. Process events are structured markdown constructed from templates so that every agent receives information in a predictable format. They do not persist beyond the session.

**Domain events** are inter-UC messages that persist as durable artifacts. A proofreader's findings become GitHub issues. A sync report becomes a file in `workspace/artifacts/{owner}/{repo}/reports/`. These cross bounded context boundaries and outlive the session that produced them. They are consumed by different use cases at different times.

The distinction matters: process events are prompt context passed through the orchestrator. Domain events are artifacts written to disk or external systems. Never pass raw subagent output between agents — transform it into a structured event first. The template is the form. The filled-in content is the memo.

## Contracts are the atomic unit of modeling knowledge

A **contract** is the atomic unit of modeling knowledge. Each contract has two expressions that share the same name:

- The **modeling file** in `.claude/modeling-contracts/` (a principle, a form, or a governance rule) is the single source of truth — it defines what to produce or what to verify, and carries the authoritative prose.
- The **skill file** in `.claude/skills/` is a thin loader — YAML front matter for triggering, plus a `!`cat`` directive that injects the modeling file's content at activation time. Skills carry no duplicated body content.

The modeling file is the only place to edit contract content. The skill's YAML `description` is the source of truth for triggering language. Agents receive contract content by listing skills in their `skills:` array — the skill injects the modeling file when the agent loads.

Governance rules, when they exist, are verification contracts — they govern how you check that the obligation was honored. The `governance/` directory is the architectural placeholder for hard enforcement. Until those rules exist, enforcement is soft: agents read contracts and follow them. The structure is ready for the moment soft compliance is not enough.

## Forms and skills serve different concerns

Forms and behavioral principles are independently loadable concerns. A form defines the shape of an artifact — sections, ordering, placeholder guidance. A behavioral principle defines how to think about the domain — when invariants are continuous, why obstacles are goal threats, why steps express intent.

An agent writing a use case needs both: the behavioral principle to make good modeling decisions during the interview, and the form to produce a correctly shaped artifact. A governance agent reviewing a use case only needs the form — it's checking structure, not conducting discovery.

The designing-usecases agent loads `writing-usecases` (the form — what a use case file looks like) and `modeling-usecases` (the behavioral principle — how to think about use cases). One shapes the output. The other shapes the judgment.

Every structured artifact the system produces has a canonical form in `.claude/modeling-contracts/forms/`. The form defines the shape. Agents consume the form through skill injection. Adding a field to an artifact is a one-line change to the form — every agent that loads the skill gets the update automatically.

## Actors map to skills

An actor is a role with goals and responsibilities. A skill is a behavioral contract an agent loads. The mapping is natural — when an agent loads a skill, it adopts that actor's hat, taking on the role's goals, judgment, and responsibilities.

A single agent can embody multiple actors by loading multiple skills. The designing-usecases agent that also loads a historian skill becomes an interviewer, a modeler, and a historian simultaneously — each role's goals active at once. It doesn't pass messages between separate agents for each concern. It wears all the hats.

The actor document describes the role — goals, responsibilities, tensions. The skill file encodes the behavioral contract an agent loads to inhabit that role. The actor is the "who and why." The skill is the "how."

This streamlines execution. Claude's architecture gives each subagent its own context window. Splitting complementary roles across agents burns context on coordination — structured messages, relay through the orchestrator, synthesizing results. When a single agent holds multiple roles, the work happens in one context window with zero handoff overhead.

Not every actor should become a skill. The mapping works when drives are complementary. A creator and a proofreader have opposing drives (production vs critique) and must remain separate agents. An interviewer and a historian have aligned drives (discovery and preservation) and combine naturally. The test: if the drives would compromise each other in a single context, separate them. If they reinforce each other, combine them.

## Markdown is the wire format

Domain events, reports, protocols, and assessments are all materialized as markdown. Not JSON. Not YAML. Not structured tool output. The consumers are humans and LLM agents, and markdown is the format both read natively.

Subagent results return as markdown. Scripts produce markdown. Inter-agent communication is markdown files on disk. The integration layer is human-readable and LLM-readable by default.

This is a deliberate choice carried forward from the use case philosophy. A system whose integration points are optimized for human and AI consumption does not need a serialization layer between them.
