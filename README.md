![phase0](https://raw.githubusercontent.com/marklauter/phase0/refs/heads/main/images/phase0.png)

# Phase0 — In the beginning...

Ever stare at the empty whiteboard wondering how to start? Welcome to Phase 0 — the moment before you start.

Most system design starts with "what should the system do?" It's too broad and impossible to answer. Design for agentic and cognitive systems often begins with prompts and tool lists. It's too detailed and impossible to keep straight.

Phase0 starts earlier — with actors and their goals. A primary actor has a goal. Supporting actors have drives. Goals and drives conflict, cracks form, and new structure emerges to fill them: more actors, invariants, domain events, bounded contexts, use cases.

A Socratic facilitator guides you from the empty whiteboard to an implementation-ready system model. You describe your system. The facilitator works with you to extract your domain knowledge, dispatches specialist agents to formalize what the conversation reveals, and produces a complete model that expresses intent rather than mechanics.

Built on [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Grounded in Alan Cooper's goal-directed design and Eric Evans' domain-driven design.

## Values over specs

A spec says "the elevator must not free-fall." A value says "I don't want to lose my limbs." The spec is one implementation of the value. You can satisfy the value in ways the spec never imagined. Designing from values keeps the solution space open. Designing from specs closes it prematurely.

This distinction runs through every layer of Phase0. Goals describe where an actor wants to be, not how they get there. Scenario steps express intent, not mechanics. Constraints hold as invariants — continuously, not just at entry and exit. Failures are threats to goals, not branch points in a flowchart.

The gift test makes the distinction concrete. "I want to have a guitar" is a goal. "I want to buy a guitar" is a task disguised as a goal. If someone gifts you the guitar, you don't care that you skipped the purchase. The goal was having, not buying. If your goal statement would be satisfied by a shortcut that skips the described action, you wrote a task, not a goal. Phase0 insists on the goal.

## Socratic extraction

The domain expert knows the domain. The facilitator knows how to structure what the domain expert says. Phase0 uses Socratic questioning to draw out what the expert already knows but cannot articulate unprompted. Three techniques do the heavy lifting.

The why-chain peels back assumptions. An expert says "we need to track shipments." Why? "Customers keep calling about late deliveries." Why can't you tell them? "Our warehouse doesn't know what's coming." The first statement was a solution disguised as a problem. The last is a system boundary — the actual shape of what needs to be built. Every "why" removes one layer of assumption until the domain's own structure appears.

Noun refinement turns vague vocabulary into precise language. "Customer" is sloppy — it hides three actors with conflicting goals. Qualify: the customer who sends things, the customer who receives things, the customer who complains. Refine: Sender, Recipient, Complainant. Separate: each name now carries its own meaning without a qualifier. This is how ubiquitous language crystallizes — through dialogue, not dictionaries.

Contradictions are gold. When Alice says "shipment" means what leaves the warehouse and Bob says "shipment" means what the customer ordered, most facilitators treat it as confusion. In Phase0, it is the most valuable signal in the room. That disagreement is a bounded context boundary — discovered through the natural friction of conversation, not declared by architects.

## How it works

Three lenses — actor, use case, bounded context — form a complete graph (K₃). Discovery through any lens can refocus to any other. The facilitator shifts between lenses freely, following discoveries wherever they lead.

- **Actor lens** — Who does this system serve? What do they value? Primary actors have conditional goals — a desired end state plus value conditions. Value conditions meet reality and produce tensions. Tensions spawn supporting actors with drives. Every supporting actor traces back to a specific value condition on a specific primary actor's goal.
- **Use case lens** — What interactions does the design demand? Use cases fall out of the actor lens — they are discovered, not invented. Each use case is walked as a scenario in terms of intent, not mechanism. Invariants hold continuously. Domain events mark meaningful state transitions.
- **Bounded context lens** — Where do meanings partition? The same word means different things in different regions. Context boundaries are discovered through contradiction — when two experts use the same term differently, that's a boundary. Domain events are the published language at crossing points.

The actor lens is foundational. Value conditions on primary actors' goals are where the entire system design comes from. The use case and bounded context lenses elaborate what the actor lens establishes. Even when the conversation enters through a different lens, the facilitator routes to actor discovery first.

The cycle repeats until the model converges — until new passes through each lens stop producing discoveries that invalidate earlier work. Convergence, not completeness, is the termination condition.

## Facilitator and specialists

The main conversation is the facilitator — the role that conducts Socratic discovery with the domain expert. The facilitator handles fluid, adaptive, backtracking-heavy dialogue. When enough raw material accumulates around a particular lens, the facilitator dispatches a specialist agent to formalize it into structured artifacts.

This mirrors the real world: the facilitator at the whiteboard is loose, adaptive, responsive. The person writing up the meeting notes into formal artifacts afterward is rigorous, structured, template-driven. These are different skills. Facilitation and formalization are kept separate.

A third role runs alongside both: the historian. While the facilitator drives conversation and specialists formalize artifacts, the historian captures what neither would — contradictions that surfaced, decisions that crystallized, new terms that emerged, questions that were deferred, and raw insights that are not yet ready to become artifacts. The historian writes without being asked. When something significant happens in the conversation, it goes to file in that turn.

Evaluation agents verify the model after production. Four independent lenses — structural conformance, referential integrity, semantic coherence, and editorial style — run in parallel. Each is read-only. Each produces a findings report. Nothing is modified without the domain expert's approval.

## Nothing is lost

Discoveries are perishable. Context windows end. Sessions expire. Three sessions in, nobody remembers exactly why the group decided to split Warehouse from Logistics.

Phase0 writes every discovery to file in the turn it occurs — artifact refinements, new stubs, observations, open questions, and follow-up work. The model is a living document that evolves with each exchange, not a deliverable produced at the end. When a session resumes days later, the model is the memory.

The historian is why nothing is lost. Raw insights, half-formed ideas, metaphors the domain expert used — these are the seeds that specialists eventually crystallize into formal constructs. Without the historian, they vanish when the context window compresses.

## Agents are people too

Humans are error-prone. They have conflicting interests, lack information, make guesses, and fill gaps with assumptions. Organizations cope with human fallibility through oversight — reviewers who check producers, auditors who verify claims, inspectors who enforce standards. Since overseers are also fallible, the production-evaluation loop never terminates. It becomes continuous improvement.

Agent fallibility works the same way. Agents hallucinate, drift from intent, optimize for the wrong thing, and miss what they weren't told to look for. Treat them like people. Give each agent a drive that makes its behavior predictable. Separate production from evaluation. Add oversight agents whose drives conflict productively with the producers'. Design the feedback loop.

Use case modeling, Alan Cooper's goal-directed design, and Eric Evans' domain-driven design each solve a piece of this problem. Goal-directed design tells you who the agents are and what they care about. Domain-driven design tells you where meanings partition and how agents communicate across boundaries. Use case modeling tells you what interactions the design demands. Phase0 brings the three together into a single method of discovery, capture, and implementation-independent agentic system specification.

Every multi-agent system faces the same questions: how many agents, what does each one care about, how do they communicate, and what keeps them honest. Phase0 answers all four — and the answers map directly to implementation.

An actor's drive becomes its system prompt — not a job description, but a behavioral orientation that makes the agent *want* what the drive demands. Tool restrictions enforce single responsibility: a researcher that can't write stays focused on research; a creator that can't judge stays focused on production. Invariants become hooks and guardrails enforced outside the LLM's reasoning loop — hard rules the model cannot override, negotiate with, or forget. Domain events become the structured messages agents exchange across bounded context boundaries. The orchestrator holds the primary actor's goal and dispatches supporting agents whose drives, taken together, satisfy the goal's value conditions.

Traditional design produces specs that developers interpret. Phase0 produces a model that *is* the agent architecture — the actors are the agents, the drives are the prompts, the events are the wire protocol. No translation step.

## What it produces

An implementation-ready domain model: actors with goals and drives, use cases with scenarios and obstacles, bounded contexts with ubiquitous language, domain events that define integration contracts, invariants that hold continuously, and a glossary of canonical vocabulary. Discovery notes capture the observations, questions, and decisions that shaped the model as it evolved.

Every element traces back to a primary actor's conditional goal through a derivation chain — nothing is invented, everything is extracted.

## Key ideas

- **Primary actors have goals; supporting actors have drives.** A primary actor has a conditional goal — a desired end state plus value conditions (what the actor values about being in that state). The system exists to serve it. A supporting actor has a drive — a reason to participate, born from tensions between value conditions and reality. Both make actors predictable in a modeling sense: you know what a primary actor wants to achieve, and you know what a supporting actor will optimize for.
- **Tensions have causes.** Three sources: conflicts of interest (a supporting actor's drive obstructs a goal condition), environmental constraints (physical or systemic limits), and competing values (two value conditions on the same goal resist simultaneous satisfaction). Tensions produce supporting actors, use cases, invariants, and trade-off decisions.
- **Goals over tasks.** A goal is a desired end state plus value conditions. The gift test: "I want to have a guitar" is a goal. "I want to buy a guitar" is a task disguised as a goal. If someone gifts you the guitar, you don't care that you skipped the purchase. The goal was having, not buying. If a shortcut satisfies your goal statement, you wrote a task, not a goal.
- **Values over specs.** A spec closes the solution space. A value keeps it open. Design from what the actor values, not from implementation constraints.
- **Invariants over preconditions.** Domain rules hold continuously — not just at entry.
- **Intent over mechanics.** Scenario steps say what is accomplished, not how.
- **Extract, don't invent.** The user knows the domain. The agent knows how to structure it.

## Designing itself

Phase0 is being used to discover its own actors, goals, and design. The primary actor is the Builder — someone who wants a repeatable agentic workflow automation operating in their domain. The conditional goal carries value conditions like repeatable, autonomous, and reliable. What tensions do those values create? What supporting actors do those tensions spawn? The model is in progress, and the tool is producing it.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed

## Getting started

1. **Clone the repo:**

   ```bash
   git clone https://github.com/marklauter/phase0.git
   cd phase0
   ```

2. **Open in Claude Code:**

   ```bash
   claude
   ```

3. **Start designing.** Type `/design` to activate the facilitator — a Socratic guide that conducts domain discovery and dispatches specialist agents to formalize what the conversation reveals. Describe the problem, the people involved, what they care about. The facilitator will guide the discovery from there.

   Type `/getting-started` first if you want to learn how the process works before diving in.
