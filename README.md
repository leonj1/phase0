![phase0](https://raw.githubusercontent.com/marklauter/phase0/refs/heads/main/images/phase0.png)

# Phase0 — In the beginning...

Most design starts with "what should the system do?" Phase0 starts earlier — with what the actor values about the world they want to be in. Goals crack when they meet reality, and the cracks are where architecture comes from.

You describe your system. A Socratic agent asks questions — one phase at a time — structures your answers, and produces a complete use case model: actors with goals and drives, invariants, domain events, bounded contexts, and scenarios that express intent rather than mechanics.

Built on [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## How it works

The agent conducts a phased interview for each use case:

1. **Goal discovery** — What is the actor trying to achieve? Why does it matter? How would they know it succeeded?
2. **Invariants and constraints** — What rules must never be violated? What is readonly? What external dependencies exist?
3. **Domain events** — What meaningful state transitions occur? What facts does this use case publish?
4. **Scenario and obstacles** — Walk through the success path in terms of intent. What could prevent the goal?
5. **Grounding** — Read source files to verify the scenario matches reality. Flag gaps.

The agent asks one phase at a time, summarizes what it heard, and moves on. It extracts structure from your domain knowledge — it does not invent requirements.

## What it produces

A use case model is a set of interconnected artifacts:

| Artifact | Purpose |
|----------|---------|
| `UC-PHILOSOPHY.md` | Guiding principles — the constitution of the model |
| `UC-TEMPLATE.md` | Structural contract for individual use cases |
| `UC-{id}-{slug}.md` | Individual use cases — one goal, one primary actor |
| `ACTOR-CATALOG.md` | Every actor, their drives, and where they appear |
| `SHARED-INVARIANTS.md` | Cross-cutting rules that apply system-wide |
| `USE-CASE-CATALOG.md` | Index of all use cases and bounded contexts |
| `domains/DC-{id}-{slug}.md` | Bounded context definitions |
| `domains/DOMAIN-EVENTS.md` | Published events that cross context boundaries |
| `GLOSSARY.md` | Canonical vocabulary for the model |

See [DOMAIN-MODEL-ARTIFACTS.md](.claude/guidance/DOMAIN-MODEL-ARTIFACTS.md) for full descriptions of each artifact and their relationships.

## Key ideas

- **Primary actors have goals; supporting actors have drives.** A primary actor has a conditional goal — a desired end state plus value conditions (what the actor values about being in that state). The system exists to serve it. A supporting actor has a drive — a reason to participate, born from tensions between value conditions and reality. Both make actors predictable in a modeling sense: you know what a primary actor wants to achieve, and you know what a supporting actor will optimize for.
- **Goals over tasks.** A goal is a desired end state plus value conditions — what the actor values about being in that state. Use the gift test: if a shortcut satisfies it, you wrote a task, not a goal. Value conditions are where system design comes from.
- **Invariants over preconditions.** Domain rules hold continuously — not just at entry.
- **Intent over mechanics.** Scenario steps say what is accomplished, not how.
- **Extract, don't invent.** The user knows the domain. The agent knows how to structure it.

See [UC-PHILOSOPHY.md](.claude/guidance/UC-PHILOSOPHY.md) for all 12 principles.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed

## Getting started

1. **Clone the repo:**

   ```bash
   git clone https://github.com/marklauter/use-case-designer-agent.git
   cd use-case-designer-agent
   ```

2. **Open in Claude Code:**

   ```bash
   claude
   ```

3. **Start designing.** Tell the agent about a system you want to model. It will begin the interview process and guide you through each phase.

The agent reads [UC-PHILOSOPHY.md](.claude/guidance/UC-PHILOSOPHY.md) and [UC-TEMPLATE.md](.claude/guidance/UC-TEMPLATE.md) before every session to maintain consistency across use cases.

## Sample model

A complete reference model is included at [samples/wiki-agent/](samples/wiki-agent/). It models a GitHub wiki management system across 6 designed use cases, 6 bounded contexts, and 7 domain events. Start with [USE-CASE-CATALOG.md](samples/wiki-agent/USE-CASE-CATALOG.md) for an overview.

## Design process

The model is built in phases — sequential in tendency, not in practice. Discovery at any phase can revise earlier work.

1. **Establish principles** — Write PHILOSOPHY.md and TEMPLATE.md
2. **Design individual use cases** — Socratic interviews, one at a time
3. **Consolidate** — Extract shared actors, invariants, and protocols
4. **Model the domain** — Formalize bounded contexts and domain events
5. **Refine** — Remove implementation leaks, verify cross-references, reconcile with reality

See [SYSTEM-DESIGN-PHASES.md](.claude/guidance/SYSTEM-DESIGN-PHASES.md) for the full process guide.

## Guidance documents

| Document | What it covers |
|----------|---------------|
| [UC-PHILOSOPHY.md](.claude/guidance/UC-PHILOSOPHY.md) | Core modeling principles |
| [UC-TEMPLATE.md](.claude/guidance/UC-TEMPLATE.md) | Structural contract for use cases |
| [DOMAIN-MODEL-ARTIFACTS.md](.claude/guidance/DOMAIN-MODEL-ARTIFACTS.md) | What artifacts to produce and when |
| [SYSTEM-DESIGN-PHASES.md](.claude/guidance/SYSTEM-DESIGN-PHASES.md) | How the design process unfolds |
| [DOMAIN-IMPLEMENTATION-PRINCIPLES.md](.claude/guidance/DOMAIN-IMPLEMENTATION-PRINCIPLES.md) | How domain models become agentic systems — drives become system prompts, orchestrators serve goals, tool restrictions enforce actor separation |
