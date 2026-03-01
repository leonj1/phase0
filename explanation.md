# The philosophy behind Phase0

Phase0 rests on a single conviction: system design is discovery, not invention. The system you need already exists in the heads of the people who understand the domain. Your job is to draw it out — not to imagine it, not to prescribe it, not to assemble it from parts. The model emerges through conversation. Everything else follows from that premise.

---

## Start with who, not what

Most design processes begin with "what should the system do?" That question is too broad and impossible to answer honestly. It invites speculation. It rewards the loudest voice in the room. It produces feature lists disconnected from the people the system is supposed to serve.

Phase0 begins with a different question: who does this system serve, and what do they value?

A primary actor has a conditional goal — a desired end state plus value conditions. The Passenger does not want to "ride the elevator." The Passenger wants to be on a different floor — safely, promptly, without trauma, with all their limbs. The destination tells you nothing about design. The values tell you everything. Safety collides with economic pressure. Promptness collides with building capacity. Each collision is a tension, and each tension that existing actors cannot resolve spawns a new one — the Inspector, the Scheduler, the Maintenance Technician — each with a drive that traces back through the derivation chain to a specific value on a specific goal.

This is not a process you perform once. It is a genealogy you can read at any time. Pick any element of the finished model — an invariant, a use case, a bounded context boundary — and trace it back through the chain. If you reach a primary actor's value condition, the element belongs. If the chain breaks, the element is unjustified and should not exist.

---

## Values over specs

A spec says "the elevator must not free-fall." A value says "I do not want to lose my limbs." The spec is one implementation of the value. You can satisfy the value in ways the spec never imagined. Designing from values keeps the solution space open. Designing from specs closes it prematurely.

This distinction runs through every layer of Phase0. Goals describe where an actor wants to be, not how they get there. Scenario steps express intent, not mechanics. Constraints hold as invariants — continuously, not just at entry and exit. Failures are threats to goals, not branch points in a flowchart.

The gift test makes the distinction concrete. "I want to have a guitar" is a goal. "I want to buy a guitar" is a task disguised as a goal. If someone gifts you the guitar, you do not care that you skipped the purchase. The goal was having, not buying. If your goal statement would be satisfied by a shortcut that skips the described action, you wrote a task, not a goal. Phase0 insists on the goal.

---

## Extract, do not invent

The domain expert knows the domain. The facilitator knows how to structure what the domain expert says. These are different skills exercised by different people.

Phase0 uses Socratic questioning to draw out what the domain expert already knows but cannot articulate unprompted. Three techniques do the heavy lifting.

The why-chain peels back assumptions. An expert says "we need to track shipments." The facilitator asks why. "Customers keep calling about late deliveries." Why can you not tell them? "Our warehouse does not know what is coming." The first statement was a solution disguised as a problem. The last statement is a system boundary — the actual shape of what needs to be built. Every "why" removes one layer of assumption until the domain's own structure appears.

Noun refinement turns vague vocabulary into precise language. "Customer" is sloppy — it hides three actors with conflicting goals. Qualify: the customer who sends things, the customer who receives things, the customer who complains. Refine: Sender, Recipient, Complainant. Separate: each name now carries its own meaning without needing a qualifier. This is how ubiquitous language crystallizes — through dialogue, not dictionaries.

Contradictions are gold. When Alice says "shipment" means what leaves the warehouse and Bob says "shipment" means what the customer ordered, most facilitators treat it as confusion. In Phase0, it is the most valuable signal in the room. That disagreement is a bounded context boundary — discovered through the natural friction of conversation, not declared by architects.

---

## Three lenses, one graph

The design cycle has three lenses — actor, use case, bounded context. Each is a way of attending to one aspect of the domain. Together they form a complete graph where every lens connects to every other. There is no prescribed sequence after the first move: you must start with the primary actor and their conditional goal. After that, discoveries through any lens can refocus you to any other.

Use cases spawn actors. "Wait — who makes this decision? That is not the same person who..." A new actor surfaces through the use case lens and feeds back to the actor lens. Bounded contexts redefine system boundaries. A term conflict reveals that what looked like one context is actually two. Domain events expose missing use cases. An event is published but nothing reacts to it. The cycle is bidirectional across every edge.

The three lenses form K₃ — three nodes, three edges, no preferred direction. The only invariant is that the actor lens is the root. Everything else is derived from the actors and their values. Even when the conversation enters through a different lens, the facilitator routes to actor discovery first. The primary actor's conditional goal is the foundation from which the entire system design is derived.

The cycle repeats until the model converges — until new passes through each lens stop producing discoveries that invalidate earlier work. Convergence, not completeness, is the termination condition.

---

## Facilitation and formalization are different skills

In a real design session, the person driving the conversation at the whiteboard is not the same person writing up the formal specs afterward. The facilitator is loose, adaptive, responsive — they follow the thread wherever it goes, backtrack when something does not hold, and shift focus when a new discovery demands attention. The formalizer is rigorous, structured, template-driven — they crystallize raw material into durable artifacts with consistent shape.

Phase0 respects this difference. The main conversation is the facilitator. It conducts Socratic discovery with the domain expert. When enough raw material accumulates around a particular concern, the facilitator dispatches a specialist agent to formalize it — a use case designer, an actor catalog writer, a context mapper. Each specialist takes unstructured discoveries and produces structured artifacts. Each is good at formalization because formalization is all it does.

Evaluation is a third skill, separate from both. Four independent agents — structural conformance, referential integrity, semantic coherence, editorial style — verify the model after production. Each is read-only. Each produces a findings report. Nothing is modified without the domain expert's approval. Production and evaluation stay apart because a single drive cannot serve competing concerns — the same principle that separates the Owner from the Inspector in the elevator.

---

## Agents are people too

Humans are fallible. They have conflicting interests, lack information, make guesses, and fill gaps with assumptions. Organizations cope with human fallibility through oversight — reviewers who check producers, auditors who verify claims, inspectors who enforce standards. Since overseers are also fallible, the loop never terminates. It becomes continuous improvement.

Agent fallibility works the same way. Agents hallucinate, drift from intent, optimize for the wrong thing, and miss what they were not told to look for. The framework that handles human fallibility — drives, separation, oversight, feedback — handles agent fallibility just as well.

Give each agent a drive that makes its behavior predictable. A Creator's drive is production. A Proofreader's drive is critique. A Deduplicator's drive is filtering. These drives are as predictable as their classical counterparts — you know what each agent will optimize for, and therefore where it will fall short.

Separate production from evaluation. Add oversight agents whose drives conflict productively with the producers'. Design the feedback loop. The result is a system where no single agent needs to be perfect because the architecture compensates for each agent's blind spots through complementary drives.

The test for actor-hood is simple: does this entity pursue a goal and make decisions in service of that goal? If yes, it is an actor with a drive. If it executes deterministically with no judgment, it is a tool. `grep` is a tool. A researcher agent that decides which files are relevant is an actor.

---

## Nothing is lost

Discoveries are perishable. Context windows end. Sessions expire. Human memory degrades. Three sessions in, nobody remembers exactly why the group decided to split Warehouse from Logistics.

Phase0 writes every discovery to file in the turn it occurs — artifact refinements, new stubs, observations, open questions, follow-up work. The model is not a deliverable produced at the end. It is a living document that evolves with each exchange. When a session resumes days later, the model is the memory.

The historian role makes this explicit. While the facilitator drives conversation and specialists formalize artifacts, the historian captures what no specialist would — raw insights, half-formed ideas, metaphors the domain expert used, contradictions that surfaced but were not yet resolved. These are the seeds that specialists will eventually crystallize into formal constructs. Without the historian, they vanish when the context window compresses.

---

## The model is the architecture

Traditional design produces specs that developers interpret. Phase0 produces a model that maps directly to implementation — especially for agentic systems.

An actor's drive becomes its system prompt — not a job description, but a behavioral orientation that makes the agent want what the drive demands. Tool restrictions enforce single responsibility: a researcher that cannot write stays focused on research; a creator that cannot judge stays focused on production. Invariants become hooks and guardrails enforced outside the reasoning loop — hard rules the model cannot override, negotiate with, or forget. Domain events become the structured messages agents exchange across bounded context boundaries. The orchestrator holds the primary actor's goal and dispatches supporting agents whose drives, taken together, satisfy the goal's value conditions.

No translation step. The actors are the agents. The drives are the prompts. The events are the wire protocol. The model is the architecture.

---

## The zeroth thing

Phase0 is called Phase0 because it is the zeroth thing you need before anything else makes sense. Before you can design use cases, you need actors. Before you can map bounded contexts, you need tensions. Before you can identify tensions, you need value conditions. Before you can articulate value conditions, you need to know who the system serves and what they care about.

That knowledge does not come from a requirements document. It comes from standing at the empty whiteboard with the people who understand the domain and asking the right questions until the model emerges from what they say — not from what anyone assumes.

Phase0 is the blank whiteboard moment, made repeatable.
