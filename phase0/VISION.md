# Phase0: Domain Discovery Through Socratic Extraction

**Date:** 2026-02-17
**Status:** Vision / Pre-design

**Phase0** is a domain discovery and design tool. Through the Socratic method, the agent facilitator extracts knowledge from a domain expert (the user). A team of specialized agents builds goal-directed usecase models and a bounded context model from which sophisticated agentic systems can be implemented. The system under design emerges through Socratic questioning that distills the truth from an untested set of assumptions.

---

## What Phase0 Produces

Phase0 produces a **vision statement** for the system under design. The vision statement answers three questions:

1. **Who does this system serve?** — primary actors
2. **What do they value?** — conditional goals (desired end states + value conditions)
3. **What forces are at play?** — tensions created by values meeting reality, and the supporting actors those tensions spawn

Everything downstream — use cases, bounded contexts, domain events, protocols — is elaboration of the vision. The vision is the foundation. Phase0 produces the foundation.

---

## Why Phase0 Exists

The use-case-designer agent is excellent at what it does — but it assumes someone already walked into the room knowing the system boundary, the actors, and roughly which use cases exist. That's a lot of pre-chewed knowledge.

In reality, that knowledge doesn't exist yet. There is no vision. A facilitator stands at a blank whiteboard with domain experts and extracts one through Socratic questioning.

Phase0 is the zeroth thing you need before anything else makes sense. The process is domain discovery. The product is a vision statement.

---

## The Natural Group Process

### Round 1: "What is this thing?"

A facilitator asks domain experts: *"What problem are you trying to solve?"* Not "what system do you want" — what **problem**. The answers are messy, overlapping, contradictory. One person says "we need to track shipments," another says "customers keep calling about late deliveries," a third says "our warehouse doesn't know what's coming."

These are all symptoms of the same system, but nobody has named it yet.

The facilitator's job is to keep asking *why* until the group converges on something like: "We need visibility into the lifecycle of a package from warehouse to doorstep." That's a system boundary. It's also the first bounded context candidate — though nobody calls it that yet.

### Round 2: "Who touches this?"

The facilitator asks: *"Who interacts with this?"* and gets answers like "the customer," "the warehouse guy," "the driver," "the dispatcher." But these are sloppy. "The customer" might be three different primary actors with conflicting goals:

- The **Sender** (goal: package is at its destination — safely, on time, intact)
- The **Recipient** (goal: package is in their possession — predictably, conveniently)
- The **Complainant** (goal: problem is resolved — fairly, promptly)

Each of these is a conditional goal: a desired end state plus value conditions. The Sender doesn't want to "send a package" — that's a task. The Sender wants the package to *be there*. Safely. On time. Intact. Those value conditions are where the system design comes from.

The Socratic refinement works by qualifying until the qualifiers disappear and you have standalone nouns with singular goals. "Customer who sends things" becomes Sender. "Customer who receives things" becomes Recipient.

Consider: a passenger is someone who rides in a car. Technically the driver is a passenger — but it's the *operator* passenger. You refine "operator passenger" to Driver. Now you have a standalone noun with a clear goal (be at the destination — via a route they control), distinct from Passenger (be at the destination — without having to operate the vehicle). The qualifier vanished because the noun absorbed it.

This is how ubiquitous language emerges naturally. You don't design it — you extract it through dialogue until every name carries its own meaning without needing a qualifier.

### Round 3: "What goes wrong?"

This is the part most methodologies skip but Cooper never does. You ask domain experts: *"What keeps you up at night?"*

The answers reveal where value conditions collide with reality:
- "Packages get lost between warehouse and truck." — the Sender's *intact* value is threatened
- "Two drivers show up for the same route." — the Recipient's *predictably* value is threatened
- "Customer calls and nobody knows where the package is." — the Sender's *on time* value and the Complainant's *fairly* value are both threatened

Each of these is a **tension** — a value condition meeting the forces of reality. And tensions are where bounded contexts crystallize. The "lost package" problem lives at the boundary between warehouse and logistics. That boundary *is* the context boundary, discovered through conflict rather than declared by architects.

Tensions also spawn supporting actors. "Nobody knows where the package is" creates a tension that demands a **Tracker** — a supporting actor whose drive is visibility (know where every package is at all times). The Tracker exists because no primary actor's goal alone will produce package tracking. The tension between the Sender's values and operational reality *demands* it.

### Round 4: Use cases emerge naturally

By now the group has primary actors with conditional goals, supporting actors with drives, tensions at boundaries, and a rough sense of the system's shape. Use cases aren't invented — they fall out. "The Dispatcher assigns routes" isn't something you design; it's something the domain experts have been doing, and now you've given it a name.

This is where the existing use-case-designer agent excels. Phase0 is everything upstream of that handoff.

---

## The Agentic Architecture

### The Facilitator Already Exists

A key realization: the main Claude Code conversation **is** the facilitator. It already:
- Listens to the domain expert (the human user)
- Asks clarifying questions
- Notices when something important is said
- Decides what to explore next
- Invokes specialist agents when the conversation is ready for them

The use-case-designer agent was initially conceived as a facilitator, but it's actually a **specialist** — it gets called in when facilitation has progressed far enough that a use case is ready to be designed. The same is true for every other agent in the pipeline. They're all specialists. The facilitator is the thing orchestrating them: the main conversation itself.

This means the facilitator doesn't need to be *built*. It needs to be **equipped** — with guidance on how to conduct a Phase0 discovery session, and with specialist agents it can dispatch. The CLAUDE.md and guidance files are already the mechanism for equipping it.

### The Lenses (Not a Pipeline)

The discovery process has distinct **lenses** — ways of looking at the domain — but they are not sequential stages. Looking through one lens changes what you see through another. The facilitator (the main conversation) shifts between lenses fluidly, following the conversation wherever it leads.

```
MAIN CONVERSATION  ← the facilitator (already exists)
│
├── equipped with: Phase0 guidance documents
│     ├── discovery lenses and when to shift between them
│     ├── Socratic questioning techniques
│     ├── when to invoke which specialist
│     └── how to read historian notes for context recovery
│
├── dispatches specialist agents to formalize discoveries:
│     ├── Domain Narrative Agent     → system boundary, domain story
│     ├── Actor Discovery Agent      → refined actors with drives
│     ├── Tension Mapping Agent      → bounded context candidates
│     ├── Use Case Designer Agent    → structured use cases (exists today)
│     └── Consolidation Agent        → validated context map, protocols
│
└── supported by:
      └── Historian Agent  ← always listening, always writing
```

**The lenses feed each other in every direction:**

- Actor discovery surfaces use cases: "If the Driver's drive is 'complete route efficiently,' there must be a route-assignment process." (actors → use cases)
- Use case design spawns actors: "Wait — who makes this decision? That's not the same person who..." (use cases → actors)
- Tension mapping redefines system boundaries: "The lost-package problem means logistics and warehouse are separate contexts." (tensions → domain narrative)
- Actor refinement reveals tensions: "The Sender and the Recipient both care about the package but for different reasons — that's a conflict." (actors → tensions)
- Domain narrative suggests actors: "In our warehouse, the night crew does receiving and the day crew does picking." (narrative → actors)

The specialist agents are **formalizers**, not facilitators. The facilitator (main conversation) handles the fluid, nonlinear, backtracking-heavy conversational work. When enough raw material has accumulated around a particular lens, the facilitator dispatches a specialist to crystallize it into a structured artifact.

This separation mirrors the real world: the facilitator at the whiteboard is loose, adaptive, responsive. The person writing up the meeting notes into formal specs afterward is rigorous, structured, template-driven. These are different skills, and forcing one agent to do both is why the use-case-designer was initially conceived as a facilitator when it's really a specialist.

### The Entry Point: Actors and Goals, From First Principles

Cooper doesn't care how it's done, or what's broken. If it wasn't broken you wouldn't have hired Cooper. So we start from first principles:

1. **Who is involved?** → primary actors
2. **What are their goals?** → desired end states

That's it. That's the entry point. Not problem statements, not domain narratives, not "what keeps you up at night." Those are facilitation techniques — useful for getting conversation started, but not modeling concepts. The modeling starts with actors and goals.

### Conditional Goals: The Foundational Concept

A primary actor's goal is a **conditional goal**: a desired end state plus the values the actor holds about how they exist in that state. A conditional goal is a **value statement**.

**The desired state** describes where the actor wants to *be*, not how they get there. "Arrive at a new floor" leaks an implementation detail (it implies travel). The real end state is "be on a different floor." If a genie could teleport the Passenger, the goal is satisfied. Apply the gift test: "I want to have a guitar" is a goal. "I want to buy a guitar" is a task disguised as a goal. If someone gifts you the guitar, you don't care that you didn't buy it.

**The value conditions** are what the actor values about being in that state. The Passenger values their physical integrity, their time, their psychological comfort. The conditional goal is: be on a different floor — safely, promptly, without trauma, with all my limbs. These are not acceptance criteria bolted on by an engineer. They are the actor's **values**. They *are* the goal. A Passenger who reaches floor 5 missing an arm did not achieve their goal.

**The value conditions are where the entire system design comes from.** The destination ("floor 5") tells you nothing about system design. The values tell you everything. Each value condition meets reality and creates a tension. Those tensions spawn supporting actors with drives. A spec says "elevator must not free-fall." A value says "I don't want to lose my limbs." The spec is one implementation of the value — designing from values keeps the solution space open.

**Drives** belong to supporting actors. A drive is a reason to participate. Drives are born from tensions between the *value conditions* on a primary actor's goal and the forces of reality.

**The elevator example — the full derivation:**

| Actor | Type | Goal or Drive | Why they exist |
|-------|------|--------------|----------------|
| **Passenger** | Primary | **Conditional goal:** be on a different floor — safely, promptly, without trauma | The system exists to serve them |
| **Owner** | Supporting | **Drive:** economic interest (minimize cost) | Elevators cost money; someone must own and maintain them |
| **Inspector** | Supporting | **Drive:** public safety | Spawned by the tension between Owner's economic drive and Passenger's *safety value*. The state's interest in public welfare demands a third party |
| **Scheduler** | Supporting | **Drive:** efficiency (optimize throughput) | Spawned by the Passenger's *promptness value* colliding with building capacity — why hotels bias upper floors in the morning and offices bias lower |

**The derivation chain:**

```
Primary actor
  → conditional goal (desired state + value conditions)
    → value conditions meet reality → tensions
      → tensions spawn supporting actors (each with a drive)
        → system design (invariants, use cases, bounded contexts)
```

Everything in the system traces back to primary actor values. Every supporting actor has a genealogy — trace it back to a specific value condition on a specific primary actor's goal. If you can't trace that lineage, the actor shouldn't exist in the model.

**The discovery order follows from the derivation chain:**

1. **Who are the primary actors?** — Cooper's first question
2. **What are their conditional goals?** — desired state + value conditions
3. **What tensions do those value conditions create when they meet reality?**
4. **What supporting actors do those tensions spawn?** — each with a drive explaining their participation

Notice: the Inspector doesn't exist because "regulations require inspections." The Inspector exists because the Passenger's safety value collides with the Owner's economic drive, and that tension *demands* resolution by a party whose drive is public welfare. The regulation is an implementation detail — the tension is the modeling concept.

---

## Why Socratic Extraction Works

Most "domain modeling" tools are **top-down** — you declare contexts and fill them in. Domain discovery is **bottom-up extraction** through conversation, which is how discovery actually works with domain experts.

The domain expert doesn't know what a bounded context is. They know that "the warehouse team and the delivery team use the word 'shipment' to mean completely different things." That contradition *is* a context boundary, discovered through dialogue rather than declared by architects.

The Socratic method is the right tool because:

1. **Domain experts know more than they can articulate upfront.** Asking "tell me everything about your system" produces a fraction of what targeted questioning extracts.
2. **Contradictions between experts reveal real boundaries.** When Alice says "shipment" means "what leaves the warehouse" and Bob says "shipment" means "what the customer ordered," that's gold — a context boundary waiting to be named.
3. **The why-chain prevents projection.** The facilitator doesn't project their model onto the domain. They keep asking why until the domain's own structure emerges.
4. **Noun refinement produces ubiquitous language.** The qualify-refine-separate cycle (passenger → operator passenger → Driver) is how domain vocabulary crystallizes into unambiguous terms.

---

## Who Holds the Threads?

### The Real-World Answer: The Historian

In a group design session, the facilitator doesn't hold the threads alone. There's always someone — the **historian** — whose job is to *write things down*. The facilitator drives the conversation. The historian captures what matters.

This is a critical distinction. The facilitator is focused on flow: "that's interesting, say more about that," "wait — you two just said opposite things." The historian is silently recording:

- "Alice said 'shipment' means what leaves the warehouse"
- "Bob contradicted — he means what the customer ordered"
- "Open question: same concept or two different ones?"
- "Decision: we split Sender and Recipient"

The historian doesn't need deep domain understanding. They need to recognize **what matters**: contradictions, decisions, new terms, open questions, and shifts in understanding. That's a distinct skill from facilitation or domain expertise.

### Why This Matters for Agents

Humans have context windows too. Working memory is finite. When a meeting runs long, early insights get compressed or lost — both for the AI and for the human domain expert in the conversation. The historian compensates for both.

In human practice, note-taking is a **learned skill**. People are taught to capture:
- What was **decided** (not just discussed)
- What was **contradicted** (not just stated)
- What was **named** (new terms, renamed terms, retired terms)
- What was **deferred** (explicit open questions)

Agents need this skill too — and critically, they need to exercise it **without being prompted**. A human historian doesn't wait to be told "write that down." They recognize significance as it happens and record it. An agent historian should do the same.

### The Architecture

This resolves the "who holds the threads" question cleanly:

**The threads live in the notes, not in any agent's head.**

```
┌──────────────────────────────────────────────────┐
│  HISTORIAN AGENT  (always listening)              │
│                                                   │
│  Watches:  conversation between user & agents     │
│  Writes:   session log, open questions,           │
│            contradictions, decisions, new terms    │
│  Never:    asks questions, makes design decisions  │
│                                                   │
│  Output format: timestamped markdown notes        │
│  Storage: session-scoped files, rolled up into    │
│           cross-session summaries                 │
└──────────────────────────────────────────────────┘
```

The historian agent is **not the facilitator**. It doesn't route conversations or invoke specialists. It listens and writes. Other agents read its notes to recover context they've lost — and the human reads them to remember what happened three sessions ago.

This mirrors how shared artifacts already work in the existing use-case-designer (markdown files as the integration layer), but adds a dedicated agent responsible for capturing the *process* of discovery, not just its *products*.

### What the Historian Captures vs. What Specialist Agents Write

| Historian writes | Specialist agents write |
|-----------------|----------------------|
| "We discussed splitting Customer into Sender and Recipient" | ACTOR-CATALOG.md entry for Sender |
| "Open question: does Driver belong in Logistics or Fleet?" | DC-03-fleet-management.md |
| "Contradiction: 'shipment' means different things to warehouse and delivery" | GLOSSARY.md entries |
| "Decision: bounded context boundary between Warehouse and Logistics" | Domain context definitions |
| "Alice's insight: 'we don't track packages, we track promises'" | Nothing — this is raw material, not yet an artifact |

The last row is crucial. The historian captures things that aren't ready to become artifacts yet. Raw insights, half-formed ideas, metaphors the domain expert used — these are the seeds that specialist agents will later formalize. Without the historian, they vanish when the context window compresses.

---

## What This Means for the Repository

The use-case-designer-agent repo becomes a domain discovery system where use case design is one stage in a larger extraction process. The existing agent, guidance, and samples remain valid; they just become one layer in a deeper stack.

### Immediate Next Steps

1. **Formalize this vision** into guidance documents that parallel the existing `SYSTEM-DESIGN-PHASES.md` but cover the full discovery lifecycle.
2. **Design the Actor Discovery Agent** first — the noun-refinement process (qualify → refine → separate) is concrete enough to build now and provides the clearest bridge to the existing use-case-designer.
3. **Restructure the repo** to reflect that use-case design is one capability within domain discovery, not the whole system.
4. **Eat our own dogfood** — use domain discovery to discover its own bounded contexts, actors, and use cases.
