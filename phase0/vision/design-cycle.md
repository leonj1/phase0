# The design cycle

Design is a process of discovery, not invention. The system under design is not assembled from parts — it is revealed through iterative examination from multiple perspectives. Each examination sharpens the picture. Each discovery reshapes what came before. The process is a feedback loop: extract, model, challenge, repeat.

The design cycle has three lenses. Each lens is a way of looking at the domain. Each lens has its own internal phases that form a sub-cycle — the same extract, model, challenge loop operating within a single perspective.

A lens is a contextual focus — a way of attending to one aspect of the domain. You can refocus to any lens at any time. The three lenses form a complete graph — K₃ — where every lens connects to every other. Three nodes, three edges, no preferred direction. The only invariant in the design process is that you must start by identifying the primary actor and their conditional goal. Everything else derives from that foundation, but the order in which you attend to it is driven by what you discover, not by a prescribed sequence.

---

## The three lenses

### Actor lens

Who does this system serve, and what do they value?

The actor lens is the entry point. All design starts here because everything else derives from it. The actor lens applies four phases in a cycle:

1. **Identify primary actors.** Cooper's first question: who is involved? Refine sloppy nouns into standalone names with singular goals. "Customer" becomes Sender, Recipient, Complainant — each carrying its own meaning without needing a qualifier.

2. **Extract conditional goals.** Each primary actor has a desired end state coupled with value conditions. The Sender's goal is not "send a package" — that is a task. The goal is *the package is at its destination — safely, on time, intact.* The value conditions are where system design comes from.

3. **Expose tensions.** Tensions come from two sources. First, the friction required to achieve a primary actor's goal — value conditions collide with reality. "Safely" collides with economic pressure. "On time" collides with logistics complexity. Second, supporting actor drives — a drive that serves one concern is insufficient to protect another. The Owner's economic drive cannot protect the Passenger's safety value. Both sources produce the same thing: a named gap between what is valued and what a single actor's drive can deliver.

4. **Derive supporting actors.** Each tension that cannot be resolved by existing actors spawns a new one. The Inspector exists because the Owner's economic drive is insufficient to protect the Passenger's safety value. Every supporting actor has a drive — a reason to participate — and a genealogy that traces back through a tension to a specific value condition on a specific primary actor's conditional goal.

### Use case lens

What interactions does the design demand?

The use case lens examines the actors, goals, and tensions produced by the actor lens and asks: what does the system actually need to do? Use cases are not invented — they fall out. "The Dispatcher assigns routes" is not something you design; it is something the domain experts have been doing, and now you have given it a name.

Each use case describes one goal pursued by one primary actor. It is a desired end state and the conditions under which that state is achieved, threatened, or failed.

### Bounded context lens

Where do meanings partition, and what facts cross those boundaries?

The bounded context lens examines the domain for regions where the same word means different things, where responsibilities separate naturally, and where integration contracts are needed. When Alice says "shipment" means what leaves the warehouse and Bob says "shipment" means what the customer ordered, that disagreement is a context boundary discovered through contradiction rather than declared by architects.

Domain events — durable facts that cross context boundaries — are identified through this lens. Every interaction that crosses a boundary or is published to the outside world is a domain event. They are the mechanism by which bounded contexts communicate.

---

## The feedback loop

Once the primary actor's conditional goal is established, discoveries through any lens can refocus you to any other. Examples:

- **Use cases spawn actors.** "Wait — who makes this decision? That is not the same person who..." A new actor surfaces through the use case lens and feeds back to the actor lens.
- **Bounded contexts redefine system boundaries.** A term conflict reveals that what looked like one context is actually two. The system boundary — a product of the actor lens — must be revised.
- **Tensions reveal context boundaries.** A tension between two value conditions turns out to live at the boundary between two bounded contexts. The bounded context lens inherits what the actor lens discovered.
- **Domain events expose missing use cases.** An event is published but nothing reacts to it. A missing use case surfaces through the bounded context lens and feeds back to the use case lens.

The cycle repeats until the model converges — until new passes through each lens stop producing discoveries that invalidate earlier work.

---

## What each lens produces

Each lens produces specific artifacts. These are the deliverables of the design cycle — mutable artifacts that evolve as understanding deepens.

### Actor lens

- **Actor catalog** — primary actors with conditional goals, supporting actors with drives, separation rationale, appearance matrix.
- **System boundary** — what is inside the system and what is outside. Falls out of who the actors are and what they value.

### Use case lens

- **Individual use cases** — one per goal, one per primary actor. Desired end state, conditions, scenario, obstacles, integration points.
- **Use case catalog** — the index. Frames the primary actor's goals, lists all use cases, maps them to bounded contexts.

### Bounded context lens

- **Domain contexts** — bounded context definitions. Purpose, ubiquitous language, use case references, domain events produced and consumed, integration points.
- **Domain events catalog** — durable facts that cross context boundaries or are published to the outside world. Each event has a producer, consumer, materialization, and payload.

### Cross-cutting

- **Glossary** — canonical vocabulary. Terms emerge through all three lenses and crystallize as the model matures.
- **Shared invariants** — cross-cutting rules. They originate from value conditions in the actor lens, but are discovered when the same rule surfaces across multiple use cases and refined when bounded context work reveals integration constraints.
- **Design conversations** — decisions made, contradictions surfaced, terms coined, questions deferred. The living record of how the design artifacts came to be.

---

## Further reading

- [Conditional goals](conditional-goals.md) — the foundational concept: desired end states coupled with value conditions, and the derivation chain that produces the entire system design
- [The Socratic method](socratic-method.md) — the facilitation techniques that drive each phase within a lens
- [The agentic architecture](agentic-architecture.md) — how the design cycle maps to a facilitator and specialist agents
