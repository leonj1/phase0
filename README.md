![phase0](https://raw.githubusercontent.com/marklauter/phase0/refs/heads/main/images/phase0.png)

# Phase0 — In the beginning...

Ever stare at the empty whiteboard wondering how to start? Welcome to Phase 0 — the moment before you start.

Most system design starts with "what should the system do?" It's too broad and impossible to answer. Design for agentic and cognitive systems often begins with prompts and tool lists. It's too detailed and impossible to keep straight.

Phase0 starts earlier — with actors and their goals. A primary actor has a goal. Supporting actors have drives. Goals and drives conflict, cracks form, and new structure emerges to fill them: more actors, invariants, domain events, bounded contexts, use cases.

A Socratic agent guides you through the design process, from the empty whiteboard to an implementation-ready system model. You describe your system. The agent works with you to extract your domain knowledge, structures it, and produces a complete system model that expresses intent rather than mechanics.

Built on [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

## Why agentic systems need this

Every multi-agent system faces the same design questions: how many agents, what does each one care about, how do they communicate, and what keeps them honest. Phase0 answers all four — and the answers map directly to implementation.

An actor's drive becomes its system prompt — not a job description, but a behavioral orientation that makes the agent *want* what the drive demands. Tool restrictions enforce single responsibility: a researcher that can't write stays focused on research; a creator that can't judge stays focused on production. Invariants become hooks and guardrails enforced outside the LLM's reasoning loop — hard rules the model cannot override, negotiate with, or forget. Domain events become the structured messages agents exchange across bounded context boundaries. The orchestrator holds the primary actor's goal and dispatches supporting agents whose drives, taken together, satisfy the goal's value conditions.

Traditional design produces specs that developers interpret. Phase0 produces a model that *is* the agent architecture — the actors are the agents, the drives are the prompts, the events are the wire protocol. No translation step.

See [DOMAIN-IMPLEMENTATION-PRINCIPLES.md](.claude/modeling/principles/DOMAIN-IMPLEMENTATION-PRINCIPLES.md) for the full mapping from domain model to agent system.

## How it works

The agent conducts a phased interview for each use case:

1. **Goal discovery** — What is the actor trying to achieve? Why does it matter? How would they know it succeeded?
2. **Invariants and constraints** — What rules must never be violated? What is readonly? What external dependencies exist?
3. **Domain events** — What meaningful state transitions occur? What facts does this use case publish?
4. **Scenario and obstacles** — Walk through the success path in terms of intent. What could prevent the goal?
5. **Grounding** — Read source files to verify the scenario matches reality. Flag gaps.

The agent asks one phase at a time, summarizes what it heard, and moves on. It extracts structure from your domain knowledge — it does not invent requirements.

## What it produces

A use case model lives at `models/{owner}/{repo}/` and is organized into topic directories:

- **`actors/`** — one file per actor (`{nn}-{slug}.md`). Primary actors, supporting actors, and sub-systems.
- **`use-cases/`** — one file per use case (`{nn}-{slug}.md`). One goal, one primary actor.
- **`contexts/`** — one file per bounded context (`{nn}-{slug}.md`). Semantic boundaries, ubiquitous language, events produced and consumed.
- **`events/`** — one file per domain event (`{nn}-{slug}.md`). Meaningful state transitions that cross context boundaries.
- **`invariants/`** — one file per shared invariant (`{nn}-{slug}.md`). Domain rules that hold continuously across multiple use cases.
- Each topic folder contains an **`index.md`** that indexes its artifacts. Gives agents enough context to select which full artifacts to read.
- **`GLOSSARY.md`** — canonical vocabulary for the model.

Each artifact type has a structural contract in `.claude/modeling/forms/`.

## Key ideas

- **Primary actors have goals; supporting actors have drives.** A primary actor has a conditional goal — a desired end state plus value conditions (what the actor values about being in that state). The system exists to serve it. A supporting actor has a drive — a reason to participate, born from tensions between value conditions and reality. Both make actors predictable in a modeling sense: you know what a primary actor wants to achieve, and you know what a supporting actor will optimize for.
- **Goals over tasks.** A goal is a desired end state plus value conditions — what the actor values about being in that state. Use the gift test: if a shortcut satisfies it, you wrote a task, not a goal. Value conditions are where system design comes from.
- **Invariants over preconditions.** Domain rules hold continuously — not just at entry.
- **Intent over mechanics.** Scenario steps say what is accomplished, not how.
- **Extract, don't invent.** The user knows the domain. The agent knows how to structure it.

See the modeling principles: [grounding-models.md](.claude/modeling/principles/grounding-models.md) (shared vocabulary), [discovering-actors.md](.claude/modeling/principles/discovering-actors.md) (actor lens), [modeling-usecases.md](.claude/modeling/principles/modeling-usecases.md) (use case lens), [mapping-contexts.md](.claude/modeling/principles/mapping-contexts.md) (bounded context lens).

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

The agent loads [grounding-models.md](.claude/modeling/principles/grounding-models.md), [modeling-usecases.md](.claude/modeling/principles/modeling-usecases.md), [structuring-usecases.md](.claude/modeling/forms/structuring-usecases.md), and [writing-documentation.md](.claude/modeling/principles/writing-documentation.md) before every session to maintain consistency across use cases.

## Sample model

A complete reference model is included at [models/marklauter/github-wiki-agent/](models/marklauter/github-wiki-agent/). It models a GitHub wiki management system across 8 use cases, 6 bounded contexts, 7 domain events, and 17 actors. Start with [use-cases/index.md](models/marklauter/github-wiki-agent/use-cases/index.md) for an overview.

## Design process

The model is built in phases — sequential in tendency, not in practice. Discovery at any phase can revise earlier work.

1. **Establish principles** — Write PHILOSOPHY.md and TEMPLATE.md
2. **Design individual use cases** — Socratic interviews, one at a time
3. **Consolidate** — Extract shared actors, invariants, and domain events
4. **Model the domain** — Formalize bounded contexts and domain events
5. **Refine** — Remove implementation leaks, verify cross-references, reconcile with reality

See [SYSTEM-DESIGN-PHASES.md](.claude/modeling/SYSTEM-DESIGN-PHASES.md) for the full process guide.

## Guidance documents

**Principles** — core beliefs that guide modeling decisions:

- [grounding-models.md](.claude/modeling/principles/grounding-models.md) — shared modeling vocabulary (Cooper + Evans)
- [discovering-actors.md](.claude/modeling/principles/discovering-actors.md) — actor lens: conditional goals, derivation chain
- [modeling-usecases.md](.claude/modeling/principles/modeling-usecases.md) — use case lens: invariants, obstacles, scenarios
- [mapping-contexts.md](.claude/modeling/principles/mapping-contexts.md) — bounded context lens: boundaries, domain events
- [writing-documentation.md](.claude/modeling/principles/writing-documentation.md) — tone, style, and editorial guidance
- [DOMAIN-IMPLEMENTATION-PRINCIPLES.md](.claude/modeling/principles/DOMAIN-IMPLEMENTATION-PRINCIPLES.md) — how domain models become agentic systems

**Forms** — structural contracts for artifact types:

- [structuring-actors.md](.claude/modeling/forms/structuring-actors.md) — actor documents
- [structuring-usecases.md](.claude/modeling/forms/structuring-usecases.md) — use case documents
- [structuring-contexts.md](.claude/modeling/forms/structuring-contexts.md) — bounded context documents
- [structuring-events.md](.claude/modeling/forms/structuring-events.md) — domain event documents
- [structuring-invariants.md](.claude/modeling/forms/structuring-invariants.md) — invariant documents
- [structuring-catalogs.md](.claude/modeling/forms/structuring-catalogs.md) — index documents
- [structuring-glossaries.md](.claude/modeling/forms/structuring-glossaries.md) — glossary documents
- [structuring-agents.md](.claude/modeling/forms/structuring-agents.md) — agent definition files

**Process:**

- [SYSTEM-DESIGN-PHASES.md](.claude/modeling/SYSTEM-DESIGN-PHASES.md) — how the design process unfolds
