# Phase0: domain discovery through Socratic extraction

**Date:** 2026-02-17
**Status:** Vision / Pre-design

Phase0 is a domain discovery and design tool. A facilitator agent extracts knowledge from a domain expert through Socratic questioning. Specialized agents formalize what the conversation reveals — goal-directed use case models and bounded context maps from which sophisticated agentic systems can be implemented.

The system under design emerges through dialogue that distills truth from an untested set of assumptions.

---

## What Phase0 produces

Phase0 produces a **vision statement** for the system under design. The vision statement answers three questions:

1. **Who does this system serve?** — primary actors
2. **What do they value?** — conditional goals (desired end states plus value conditions)
3. **What forces are at play?** — tensions created by values meeting reality, and the supporting actors those tensions spawn

Everything downstream — use cases, bounded contexts, domain events, protocols — is elaboration of the vision. The vision is the foundation. Phase0 produces the foundation.

---

## Why Phase0 exists

The use-case-designer agent is excellent at what it does — but it assumes someone already walked into the room knowing the system boundary, the actors, and roughly which use cases exist. That is a lot of pre-chewed knowledge.

In reality, that knowledge does not exist yet. There is no vision. A facilitator stands at a blank whiteboard with domain experts and extracts one through Socratic questioning.

Phase0 is the zeroth thing you need before anything else makes sense. Use case modeling is the method by which we discover the domain. The product is a vision statement.

---

## What this means for the repository

The use-case-designer repo becomes a domain discovery system where use case design is one stage in a larger extraction process. The existing agent, guidance, and samples remain valid — they become one layer in a deeper stack.

Immediate next steps:

1. **Formalize this vision** into guidance documents that parallel the existing `SYSTEM-DESIGN-PHASES.md` but cover the full discovery lifecycle.
2. **Design the Actor Discovery Agent first** — the noun-refinement process (qualify, refine, separate) is concrete enough to build now and provides the clearest bridge to the existing use-case-designer.
3. **Restructure the repo** to reflect that use-case design is one capability within domain discovery, not the whole system.
4. **Eat our own dogfood** — use domain discovery to discover Phase0's own bounded contexts, actors, and use cases.

---

## Further reading

These articles develop the ideas introduced here:

- [Conditional goals](conditional-goals.md) — the foundational modeling concept: desired end states plus value conditions, and the derivation chain that produces the entire system design
- [The design cycle](design-cycle.md) — the three lenses, the feedback loop, and the artifacts each lens produces
- [The Socratic method](socratic-method.md) — why Socratic extraction works and the specific techniques it employs
- [The agentic architecture](agentic-architecture.md) — how Phase0 is built: the facilitator, the lenses, and the specialist agents
- [The historian](historian.md) — who holds the threads when the conversation runs long
