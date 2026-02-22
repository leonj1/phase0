# Goal-directed domain modeling curriculum

A workshop series that teaches you to model systems through goals, actors, and Socratic extraction. Grounded in Alan Cooper's goal-oriented design and Eric Evans' domain-driven design.

You learn to think about systems in terms of what actors want — not what features exist. You practice extracting domain knowledge through questioning, structuring it into use case models, and connecting those models to bounded contexts and domain events.

---

## Three tracks

The curriculum has a shared foundation (4 lessons) and three specialized tracks (3 lessons each). Every participant completes the foundation. Then you follow the track that matches your role.

### Foundation — the ideas

Shared across all tracks. You learn conditional goals, actors with drives, the Socratic method, and the anatomy of a use case.

| Lesson | Title | You learn to... |
|--------|-------|-----------------|
| F01 | Goals, not tasks | Distinguish desired states from implementation paths |
| F02 | Actors and drives | Derive supporting actors from tensions on value conditions |
| F03 | Socratic extraction | Extract domain structure through questioning |
| F04 | Anatomy of a use case | Read and write structured use cases |

### Software engineer — how it becomes a system

You already know how to build software. This track teaches you to model the domain first — bounded contexts, domain events, invariants — and then translate the model into an agentic system where drives become system prompts and tool restrictions enforce actor separation.

| Lesson | Title | You learn to... |
|--------|-------|-----------------|
| SWE01 | Domain-driven design foundations | Identify bounded contexts, domain events, and invariants |
| SWE02 | From model to agentic system | Translate drives into system prompts and tool restrictions |
| SWE03 | The complete model | Navigate and produce a full artifact ecosystem |

### System engineer — where things connect and break

You think about integration, failure, and resilience. This track teaches you to model system boundaries as bounded contexts, define protocols at every crossing point, derive failure modes from value conditions, and design recovery strategies that preserve the actor's goal.

| Lesson | Title | You learn to... |
|--------|-------|-----------------|
| SE01 | System boundaries and integration | Map bounded contexts, domain events, and protocols |
| SE02 | Invariants and resilience | Derive failure modes from value conditions and design recovery |
| SE03 | The complete domain model | Consolidate actors, invariants, and cross-references |

### UX designer — understanding users through goals

You already know how to research users. This track teaches you Cooper's goal-directed approach — conditional goals with value conditions, how tensions between values and reality spawn the actors in your system, and how Socratic extraction surfaces domain structure that interviews alone miss.

| Lesson | Title | You learn to... |
|--------|-------|-----------------|
| UX01 | Value conditions and the design space | Use value conditions to keep the solution space open |
| UX02 | Tension mapping and actor genealogy | Trace every actor back to a specific value condition |
| UX03 | From discovery to design | Conduct a Phase0 discovery session |

---

## Progression

```
Foundation (all tracks)
  F01  Goals, not tasks
  F02  Actors and drives
  F03  Socratic extraction
  F04  Anatomy of a use case
       │
       ├─── Software engineer ──── SWE01 → SWE02 → SWE03
       │
       ├─── System engineer ────── SE01  → SE02  → SE03
       │
       └─── UX designer ────────── UX01  → UX02  → UX03
```

Each lesson builds on the previous. Foundation lessons build the conceptual vocabulary. Track lessons apply it to your discipline.

---

## Running examples

Two systems thread through the entire curriculum:

- **Elevator system** — the illustrative example. A Passenger wants to be on a different floor — safely, promptly, without trauma, intact. This simple system demonstrates every concept: conditional goals, value conditions, tensions, the derivation chain from values to supporting actors (Owner, Inspector, Scheduler), and how a single goal generates an entire actor network. The elevator appears in every lesson.

- **Wiki-agent sample model** — the concrete case study. A complete domain model for a GitHub wiki management system, included in the repository at `models/marklauter/github-wiki-manager/`. Six designed use cases, six bounded contexts, seven domain events. You examine a finished model to see what the ideas look like in practice.

---

## Prerequisites

No technical prerequisites beyond familiarity with your own discipline. You need domain knowledge about systems — the curriculum teaches you how to structure it.

---

## Materials per lesson

Each lesson includes three documents:

- **Lesson plan** — learning objectives, activity sequence, timing, source references
- **Instructor notes** — facilitation techniques, common misconceptions, exercise guidance
- **Student notes** — self-contained reading material with examples and exercises

---

## Source documents

The curriculum draws from these documents in the repository:

| Document | What it provides |
|----------|-----------------|
| [modeling-vocabulary.md](../.claude/modeling-contracts/principles/modeling-vocabulary.md) | Shared vocabulary — goals, drives, tensions, domain events |
| [actor-lens.md](../.claude/modeling-contracts/principles/actor-lens.md) | Actor lens — conditional goals, derivation chain, actor genealogy |
| [usecase-lens.md](../.claude/modeling-contracts/principles/usecase-lens.md) | Use case lens — invariants, obstacles, intent-driven scenarios |
| [context-lens.md](../.claude/modeling-contracts/principles/context-lens.md) | Bounded context lens — boundaries, protocols |
| [usecase.md](../.claude/modeling-contracts/forms/usecase.md) | Structural contract for use cases |
| [DOMAIN-MODEL-ARTIFACTS.md](../.claude/modeling-contracts/DOMAIN-MODEL-ARTIFACTS.md) | What artifacts to produce and when |
| [SYSTEM-DESIGN-PHASES.md](../.claude/modeling-contracts/SYSTEM-DESIGN-PHASES.md) | How the design process unfolds |
| [DOMAIN-IMPLEMENTATION-PRINCIPLES.md](../.claude/modeling-contracts/principles/DOMAIN-IMPLEMENTATION-PRINCIPLES.md) | How domain models become agentic systems |
| [VISION.md](../phase0/VISION.md) | Phase0 domain discovery vision |
| [models/marklauter/github-wiki-manager/](../models/marklauter/github-wiki-manager/) | Complete reference model |
