![phase0](https://raw.githubusercontent.com/marklauter/phase0/refs/heads/main/images/phase0.png)

# Phase0 — In the beginning...

Ever stare at the empty whiteboard wondering how to start? Welcome to Phase 0 — the moment before you start.

Most system design starts with "what should the system do?" It's too broad and impossible to answer. Design for agentic and cognitive systems often begins with prompts and tool lists. It's too detailed and impossible to keep straight.

Phase0 starts earlier — with actors and their goals. A primary actor has a goal. Supporting actors have drives. Goals and drives conflict, cracks form, and new structure emerges to fill them: more actors, invariants, domain events, bounded contexts, use cases.

A Socratic facilitator guides you from the empty whiteboard to an implementation-ready system model. You describe your system. The facilitator works with you to extract your domain knowledge, dispatches specialist agents to formalize what the conversation reveals, and produces a complete model that expresses intent rather than mechanics.

Built on [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Grounded in Alan Cooper's goal-directed design and Eric Evans' domain-driven design.

## Agents are people too

Humans are error-prone. They have conflicting interests, lack information, make guesses, and fill gaps with assumptions. Organizations cope with human fallibility through oversight — reviewers who check producers, auditors who verify claims, inspectors who enforce standards. Since overseers are also fallible, the production-evaluation loop never terminates. It becomes continuous improvement.

Agent fallibility works the same way. Agents hallucinate, drift from intent, optimize for the wrong thing, and miss what they weren't told to look for. Treat them like people. Give each agent a drive that makes its behavior predictable. Separate production from evaluation. Add oversight agents whose drives conflict productively with the producers'. Design the feedback loop.

Use case modeling, Alan Cooper's goal-directed design, and Eric Evans' domain-driven design each solve a piece of this problem. Goal-directed design tells you who the agents are and what they care about. Domain-driven design tells you where meanings partition and how agents communicate across boundaries. Use case modeling tells you what interactions the design demands. Phase0 brings the three together into a single method of discovery, capture, and implementation-independent agentic system specification.

Every multi-agent system faces the same questions: how many agents, what does each one care about, how do they communicate, and what keeps them honest. Phase0 answers all four — and the answers map directly to implementation.

An actor's drive becomes its system prompt — not a job description, but a behavioral orientation that makes the agent *want* what the drive demands. Tool restrictions enforce single responsibility: a researcher that can't write stays focused on research; a creator that can't judge stays focused on production. Invariants become hooks and guardrails enforced outside the LLM's reasoning loop — hard rules the model cannot override, negotiate with, or forget. Domain events become the structured messages agents exchange across bounded context boundaries. The orchestrator holds the primary actor's goal and dispatches supporting agents whose drives, taken together, satisfy the goal's value conditions.

Traditional design produces specs that developers interpret. Phase0 produces a model that *is* the agent architecture — the actors are the agents, the drives are the prompts, the events are the wire protocol. No translation step.

## How it works

Three lenses — actor, use case, bounded context — form a complete graph (K₃). Discovery through any lens can refocus to any other. The facilitator shifts between lenses freely, following discoveries wherever they lead.

- **Actor lens** — Who does this system serve? What do they value? Primary actors have conditional goals — a desired end state plus value conditions. Value conditions meet reality and produce tensions. Tensions spawn supporting actors with drives. Every supporting actor traces back to a specific value condition on a specific primary actor's goal.
- **Use case lens** — What interactions does the design demand? Use cases fall out of the actor lens — they are discovered, not invented. Each use case is walked as a scenario in terms of intent, not mechanism. Invariants hold continuously. Domain events mark meaningful state transitions.
- **Bounded context lens** — Where do meanings partition? The same word means different things in different regions. Context boundaries are discovered through contradiction — when two experts use the same term differently, that's a boundary. Domain events are the published language at crossing points.

The actor lens is foundational. Value conditions on primary actors' goals are where the entire system design comes from. The use case and bounded context lenses elaborate what the actor lens establishes. Even when the conversation enters through a different lens, the facilitator routes to actor discovery first.

The cycle repeats until the model converges — until new passes through each lens stop producing discoveries that invalidate earlier work.

## Facilitator and specialists

The main conversation is the facilitator — the role that conducts Socratic discovery with the domain expert. The facilitator handles fluid, adaptive, backtracking-heavy dialogue. When enough raw material accumulates around a particular lens, the facilitator dispatches a specialist agent to formalize it into structured artifacts.

This mirrors the real world: the facilitator at the whiteboard is loose, adaptive, responsive. The person writing up the meeting notes into formal artifacts afterward is rigorous, structured, template-driven. These are different skills. Facilitation and formalization are kept separate.

Evaluation agents verify the model after production. Four independent lenses — structural conformance, referential integrity, semantic coherence, and editorial style — run in parallel. Each is read-only. Each produces a findings report. Nothing is modified without the domain expert's approval.

## What it produces

An implementation-ready domain model: actors with goals and drives, use cases with scenarios and obstacles, bounded contexts with ubiquitous language, domain events that define integration contracts, invariants that hold continuously, and a glossary of canonical vocabulary. Discovery notes capture the observations, questions, and decisions that shaped the model as it evolved.

Every element traces back to a primary actor's conditional goal through a derivation chain — nothing is invented, everything is extracted.

## Nothing is lost

Discoveries are perishable. Context windows end. Sessions expire. Phase0 writes every discovery to file in the turn it occurs — artifact refinements, new stubs, observations, open questions, and follow-up work. The model is a living document that evolves with each exchange, not a deliverable produced at the end. When a session resumes days later, the model is the memory.

## Key ideas

- **Primary actors have goals; supporting actors have drives.** A primary actor has a conditional goal — a desired end state plus value conditions (what the actor values about being in that state). The system exists to serve it. A supporting actor has a drive — a reason to participate, born from tensions between value conditions and reality. Both make actors predictable in a modeling sense: you know what a primary actor wants to achieve, and you know what a supporting actor will optimize for.
- **Tensions have causes.** Three sources: conflicts of interest (a supporting actor's drive obstructs a goal condition), environmental constraints (physical or systemic limits), and competing values (two value conditions on the same goal resist simultaneous satisfaction). Tensions produce supporting actors, use cases, invariants, and trade-off decisions.
- **Goals over tasks.** A goal is a desired end state plus value conditions. Use the gift test: if a shortcut satisfies it, you wrote a task, not a goal. Value conditions are where system design comes from.
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

3. **Start designing.** Type `/getting-started` to learn how the process works, or just tell the facilitator about a system you want to model. Describe the problem, the people involved, what they care about. The facilitator will guide the discovery from there.

