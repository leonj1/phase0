# The agentic architecture

Phase0 is built on a simple structural insight: the main Claude Code conversation is already a facilitator. It does not need a purpose-built orchestration agent. It needs guidance documents and specialist agents it can dispatch. This article describes that architecture — the facilitator, the lenses it looks through, and the specialist agents that formalize what the conversation discovers.

---

## The facilitator already exists

The main Claude Code conversation already does everything a facilitator does:

- Listens to the domain expert (the human user)
- Asks clarifying questions
- Notices when something important is said
- Decides what to explore next
- Invokes specialist agents when the conversation is ready for them

The facilitator does not need to be *built*. It needs to be **equipped** — with guidance on how to conduct a Phase0 discovery session, and with specialist agents it can dispatch. The /design command, skills, and contracts are already the mechanism for equipping it.

---

## The specialist realization

The use-case-designer agent was initially conceived as a facilitator, but it is actually a **specialist**. It gets called in when facilitation has progressed far enough that a use case is ready to be designed. The same is true for every other agent in the pipeline. They are all specialists. The facilitator is the thing orchestrating them: the main conversation itself.

This distinction matters because facilitation and formalization are different skills. Forcing one agent to do both is what made the use-case-designer feel miscast — it was being asked to do loose, adaptive, backtracking-heavy conversational work when its real strength is rigorous, structured, template-driven formalization.

---

## The lenses

The discovery process has distinct **lenses** — ways of looking at the domain. Each is bidirectional. Looking through one lens changes what you see through another. The facilitator shifts between lenses fluidly, following the conversation wherever it leads.

```
MAIN CONVERSATION  <- the facilitator (already exists)
|
+-- equipped with: Phase0 guidance documents
|     +-- discovery lenses and when to shift between them
|     +-- Socratic questioning techniques
|     +-- when to invoke which specialist
|     +-- how to read historian notes for context recovery
|
+-- dispatches specialist agents to formalize discoveries:
|     +-- Domain Narrative Agent     -> system boundary, domain story
|     +-- Actor Discovery Agent      -> refined actors with drives
|     +-- Tension Mapping Agent      -> bounded context candidates
|     +-- Use Case Designer Agent    -> structured use cases (exists today)
|     +-- Consolidation Agent        -> validated context map, protocols
|
+-- supported by:
      +-- Historian Agent  <- always listening, always writing
```

The [historian](historian.md) appears in this diagram but has its own article. It is not a specialist that the facilitator dispatches on demand. It runs continuously, capturing the process of discovery so that context survives across sessions and beyond the limits of working memory.

---

## The lenses feed each other

The lenses are bidirectional. Discoveries through one lens reshape what you see through every other:

- **Actors surface use cases.** "If the Driver's drive is 'complete route efficiently,' there must be a route-assignment process." (actors to use cases)
- **Use cases spawn actors.** "Wait — who makes this decision? That's not the same person who..." (use cases to actors)
- **Tensions redefine system boundaries.** "The lost-package problem means logistics and warehouse are separate contexts." (tensions to domain narrative)
- **Actor refinement reveals tensions.** "The Sender and the Recipient both care about the package but for different reasons — that's a conflict." (actors to tensions)
- **Domain narrative suggests actors.** "In our warehouse, the night crew does receiving and the day crew does picking." (narrative to actors)

This multidirectional flow is what makes the architecture a complete graph. Designing use cases discovers new actors. Actor refinement reveals context boundaries. The facilitator shifts lenses freely, following discoveries wherever they lead.

But the graph has a root. The actor lens is the foundational lens — the ground truth from which everything else is derived. Use cases elaborate actors' goals into scenarios. Bounded contexts partition the domain that actors' tensions revealed. Both lenses depend on actor lens output to begin. The K₃ graph is complete, every edge is bidirectional, but one node is the starting point. The facilitator enforces this: before dispatching to use case or bounded context work, ensure the primary actor and their conditional goal are established.

---

## Specialists as formalizers

The specialist agents are **formalizers**, not facilitators. The facilitator handles the fluid, nonlinear, backtracking-heavy conversational work. When enough raw material has accumulated around a particular lens, the facilitator dispatches a specialist to crystallize it into a structured artifact.

This separation mirrors a real-world design session. The facilitator at the whiteboard is loose, adaptive, responsive. The person writing up the meeting notes into formal specs afterward is rigorous, structured, template-driven. These are different skills exercised at different moments. The architecture respects that difference rather than collapsing both roles into a single agent.

---

## Further reading

- [Conditional goals](conditional-goals.md) — the foundational modeling concept the architecture serves: desired end states plus value conditions, and the derivation chain that produces the entire system design
- [The historian](historian.md) — who holds the threads when the conversation runs long, and how the historian agent captures process alongside product
