# Phase0: Bounded Context Discovery Through Socratic Extraction

**Date:** 2026-02-17
**Status:** Vision / Pre-design

---

## The Problem

The use-case-designer agent is excellent at what it does — but it assumes someone already walked into the room knowing the system boundary, the actors, and roughly which use cases exist. That's a lot of pre-chewed knowledge.

In reality, that knowledge doesn't exist yet. A facilitator stands at a blank whiteboard with domain experts and asks: *"What problem are you trying to solve?"*

Phase0 is everything that happens before the first use case is written.

---

## The Natural Group Process

### Round 1: "What is this thing?"

A facilitator asks domain experts: *"What problem are you trying to solve?"* Not "what system do you want" — what **problem**. The answers are messy, overlapping, contradictory. One person says "we need to track shipments," another says "customers keep calling about late deliveries," a third says "our warehouse doesn't know what's coming."

These are all symptoms of the same system, but nobody has named it yet.

The facilitator's job is to keep asking *why* until the group converges on something like: "We need visibility into the lifecycle of a package from warehouse to doorstep." That's a system boundary. It's also the first bounded context candidate — though nobody calls it that yet.

### Round 2: "Who touches this?"

The facilitator asks: *"Who interacts with this?"* and gets answers like "the customer," "the warehouse guy," "the driver," "the dispatcher." But these are sloppy. "The customer" might be three different actors with conflicting drives:

- The **Sender** (drive: ensure package arrives safely)
- The **Recipient** (drive: know when to expect delivery)
- The **Complainant** (drive: get resolution when something goes wrong)

The Socratic refinement works by qualifying until the qualifiers disappear and you have standalone nouns with singular drives. "Customer who sends things" becomes Sender. "Customer who receives things" becomes Recipient.

Consider: a passenger is someone who rides in a car. Technically the driver is a passenger — but it's the *operator* passenger. You refine "operator passenger" to Driver. Now you have a standalone noun with a clear drive (operate the vehicle), distinct from Passenger (be transported). The qualifier vanished because the noun absorbed it.

This is how ubiquitous language emerges naturally. You don't design it — you extract it through dialogue until every name carries its own meaning without needing a qualifier.

### Round 3: "What goes wrong?"

This is the part most methodologies skip but Cooper never does. You ask domain experts: *"What keeps you up at night?"*

The answers reveal the real system:
- "Packages get lost between warehouse and truck."
- "Two drivers show up for the same route."
- "Customer calls and nobody knows where the package is."

Each of these is a **domain tension** — and tensions are where bounded contexts crystallize. The "lost package" problem lives at the boundary between warehouse and logistics. That boundary *is* the context boundary, discovered through conflict rather than declared by architects.

### Round 4: Use cases emerge naturally

By now the group has actors with drives, tensions at boundaries, and a rough sense of the system's shape. Use cases aren't invented — they fall out. "The Dispatcher assigns routes" isn't something you design; it's something the domain experts have been doing, and now you've given it a name.

This is where the existing use-case-designer agent excels. Phase0 is everything upstream of that handoff.

---

## The Agentic Pipeline

Phase0 decomposes into a pipeline of Socratic agents, each operating at a different level of abstraction. Each agent's output feeds the next, but the process supports backtracking — discovering an actor might reveal a new bounded context, which might split an existing use case.

```
┌─────────────────────────────────────────────────────────┐
│  1. SYSTEM DISCOVERY AGENT                              │
│     "What problem are you solving?"                     │
│     Input:  blank whiteboard                            │
│     Output: system boundary, raw problem statements     │
│     Method: why-chain questioning                       │
├─────────────────────────────────────────────────────────┤
│  2. ACTOR DISCOVERY AGENT                               │
│     "Who touches this and what do they want?"           │
│     Input:  system boundary                             │
│     Output: refined actor catalog with drives           │
│     Method: qualify → refine → separate                 │
├─────────────────────────────────────────────────────────┤
│  3. TENSION MAPPING AGENT                               │
│     "What goes wrong? Where do goals conflict?"         │
│     Input:  actors + drives                             │
│     Output: bounded context candidates, domain events   │
│     Method: conflict elicitation, boundary detection    │
├─────────────────────────────────────────────────────────┤
│  4. USE CASE DESIGNER AGENT  ← (exists today)          │
│     "Walk me through how {actor} achieves {goal}"       │
│     Input:  actors, contexts, tensions                  │
│     Output: structured use cases per TEMPLATE.md        │
│     Method: goal-directed Socratic interview            │
├─────────────────────────────────────────────────────────┤
│  5. CONTEXT CONSOLIDATION AGENT                         │
│     "Do these contexts hold up? What crosses?"          │
│     Input:  all use cases, all contexts                 │
│     Output: validated bounded context map, protocols    │
│     Method: cross-reference, event flow validation      │
└─────────────────────────────────────────────────────────┘
```

### Agent Boundaries Are Not Walls

In a real group session, facilitators bounce between these levels constantly. Discovering an actor might surface a tension. A tension might redefine the system boundary. A use case walkthrough might split an actor into two. The pipeline is a conceptual ordering, not a rigid sequence.

The agents need to support this fluidity — either through explicit backtracking protocols or through a facilitator agent that routes conversations where they need to go.

---

## Why Socratic Extraction Works

Most "domain modeling" tools are **top-down** — you declare contexts and fill them in. Phase0 is **bottom-up extraction** through conversation, which is how discovery actually works with domain experts.

The domain expert doesn't know what a bounded context is. They know that "the warehouse team and the delivery team use the word 'shipment' to mean completely different things." That contradition *is* a context boundary, discovered through dialogue rather than declared by architects.

The Socratic method is the right tool because:

1. **Domain experts know more than they can articulate upfront.** Asking "tell me everything about your system" produces a fraction of what targeted questioning extracts.
2. **Contradictions between experts reveal real boundaries.** When Alice says "shipment" means "what leaves the warehouse" and Bob says "shipment" means "what the customer ordered," that's gold — a context boundary waiting to be named.
3. **The why-chain prevents projection.** The facilitator doesn't project their model onto the domain. They keep asking why until the domain's own structure emerges.
4. **Noun refinement produces ubiquitous language.** The qualify-refine-separate cycle (passenger → operator passenger → Driver) is how domain vocabulary crystallizes into unambiguous terms.

---

## The Hard Design Question: Who Holds the Threads?

In a group setting, the facilitator holds all the threads. They remember that Alice said "shipment" means one thing while Bob said it means another. That contradiction is a context boundary waiting to be named.

In an agentic system, **who holds the threads?** Three options:

### Option A: Single Orchestrating Agent
One agent delegates to specialist interviewers but maintains the global model.
- **Pro:** Single source of truth, can spot cross-cutting contradictions.
- **Risk:** Becomes a god-object. Socratic discipline breaks down when the orchestrator starts "knowing" too much.

### Option B: Shared Artifacts as the Thread
Each agent reads/writes to a living model (markdown files), and consistency is maintained through cross-validation. This is the pattern the existing use-case-designer already follows.
- **Pro:** Decentralized, each agent stays in its lane, artifacts are inspectable.
- **Risk:** No single agent sees the whole picture. Contradictions may go unnoticed until consolidation.

### Option C: Explicit Facilitator Agent
A dedicated agent whose only job is to notice contradictions, track open questions, and decide which specialist to invoke next. It never writes artifacts — it only asks questions and routes.
- **Pro:** Closest to the real-world group dynamic. Separation between facilitation and production.
- **Risk:** Harder to implement. The facilitator needs enough domain understanding to know *when* a contradiction matters.

The answer is probably a hybrid — shared artifacts for persistence (Option B) with a lightweight facilitator for routing and contradiction detection (Option C). The facilitator reads the artifacts but only writes to a "open questions" or "tensions" log, never to the model itself.

---

## What This Means for the Repository

The use-case-designer-agent repo becomes Phase0 — a broader bounded-context discovery system where use case design is one stage in a larger extraction pipeline. The existing agent, guidance, and samples remain valid; they just become one layer in a deeper stack.

### Immediate Next Steps

1. **Formalize this vision** into guidance documents that parallel the existing `UC-MODEL-DESIGN-PHASES.md` but cover the full discovery lifecycle.
2. **Design the Actor Discovery Agent** first — the noun-refinement process (qualify → refine → separate) is concrete enough to build now and provides the clearest bridge to the existing use-case-designer.
3. **Restructure the repo** to reflect that use-case design is one capability within Phase0, not the whole system.
4. **Eat our own dogfood** — use the Socratic method to discover Phase0's own bounded contexts, actors, and use cases.
