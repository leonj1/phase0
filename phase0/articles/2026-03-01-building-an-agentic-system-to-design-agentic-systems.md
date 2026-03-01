# Building an Agentic System to Design Agentic Systems

In December 2024, Anthropic's engineering team published ["Building Effective Agents"](https://www.anthropic.com/engineering/building-effective-agents) — a taxonomy of five workflow patterns for LLM-based systems, along with hard-won guidance on when to use each one. The article is grounded in practical experience: start simple, invest in tool design, and only add complexity when simpler approaches demonstrably fall short.

Phase0 is a domain discovery tool built on Claude Code. It uses Socratic dialogue to extract domain knowledge from a human expert and formalize it into vision statements, use case models, and bounded context maps — the upstream artifacts from which agentic systems are specified and built. It is, in a literal sense, an agentic system that designs agentic systems.

When we mapped Phase0's architecture against Anthropic's taxonomy, three of the five patterns emerged clearly, one was deliberately excluded, and the simplest piece of advice in the article — start simple — turned out to be the one we had to learn twice.

---

## The unsolved upstream problem

Everyone is building agents. Few are modeling what those agents should do first.

The typical path looks like this: a team identifies a problem, sketches some workflows, picks an LLM framework, and starts wiring tools together. If they are disciplined, they write tests. If they are experienced, they define bounded contexts. But the foundational questions — who does this system serve, what do they value, what tensions exist between those values and reality — are answered informally or not at all. The system's design is implicit in the code rather than explicit in a model.

This is the gap Phase0 addresses. It is the zeroth thing you need before anything else makes sense. Before use cases, before bounded contexts, before architecture decisions — someone has to stand at a blank whiteboard with domain experts and extract a shared understanding through structured dialogue.

The question was how to build a tool for that extraction process. Anthropic's article provided the architectural vocabulary.

---

## The insight that unlocked the architecture

The key realization was not about patterns. It was about what already existed.

The main Claude Code conversation — the thing running when a user opens a terminal and starts talking — is already a facilitator. It listens. It asks clarifying questions. It notices when something important is said. It decides what to explore next. It can invoke specialist agents when the conversation is ready for them.

Phase0 does not build an orchestration layer. It equips the existing conversation with guidance documents that teach it how to conduct a discovery session, and with specialist agents it can dispatch to formalize what the conversation uncovers. The facilitator is not a component to be engineered. It is the conversation itself, given structure.

This maps directly to Anthropic's foundational advice: find the simplest solution possible, and only increase complexity when needed. The simplest possible facilitator is the one you already have. Everything added on top — skills, contracts, specialist agents — exists to make that facilitator more effective, not to replace it.

---

## Three patterns that emerged

### Routing: the spine

Anthropic describes routing as classifying inputs and directing them to specialized handlers. In Phase0, the facilitator does exactly this — but it classifies conversation state rather than discrete inputs.

The facilitator monitors the discovery session through three lenses: the actor lens (who does this system serve?), the use case lens (what interactions does the design demand?), and the bounded context lens (where do meanings partition?). As the conversation progresses, raw material accumulates around one lens or another. When enough material is present, the facilitator dispatches a specialist agent to formalize it.

An actor discovery agent receives a domain context and an area of focus. A use case designer receives a primary actor and their conditional goal. A context mapping agent receives an observed contradiction or area of partition. Each specialist has an input contract — the minimum context it needs to begin work — and the facilitator satisfies that contract before dispatching.

The routing decision is not a simple classifier over user messages. It is a judgment about readiness: has enough raw material accumulated for a specialist to do meaningful work? This is routing in Anthropic's sense — classification followed by dispatch to a specialized handler — but the classification criterion is accumulated conversational context rather than a single input.

### Prompt chaining: gates between phases

Anthropic describes prompt chaining as sequential steps where each LLM call processes the output of the previous one, with programmatic checkpoints between them. Phase0 uses this pattern at two scales.

At the macro level, the three lenses have a dependency: the actor lens must produce at least one primary actor with a conditional goal before the use case lens can begin work. This is not a suggestion. It is an invariant enforced by the facilitator. If a user asks to design a use case before establishing the actor, the facilitator redirects the conversation to actor discovery first. The invariant functions as a gate — a checkpoint that ensures the prerequisite output exists before the next phase begins.

Within each specialist agent, the same pattern repeats. The use case designer operates in four phases: anchor the use case (confirm actor and goal), discover supporting actors and responsibilities, surface invariants and constraints, and walk the scenario. Each phase builds on the output of the previous one. The agent creates the artifact file early with placeholders and updates it progressively as each phase produces discoveries. The gates are softer here — a discovery in phase four can pull the agent back to phase two — but the sequential structure provides direction.

### Parallelization: independent evaluation

Anthropic describes two forms of parallelization: sectioning (independent subtasks run simultaneously) and voting (the same task runs multiple times for confidence). Phase0 uses sectioning for artifact evaluation.

Four evaluation agents assess model artifacts along independent dimensions: structural conformance (do artifacts match their form contracts?), referential integrity (do cross-references resolve?), semantic coherence (do related artifacts agree with each other?), and editorial style (does prose meet the standards contract?). All four are read-only — none modifies any artifact — which means they can run simultaneously without coordination. No evaluation agent can invalidate another's input.

The facilitator dispatches all four in parallel, consolidates their findings into a single report, and presents it to the user. This is a direct application of Anthropic's sectioning pattern: decompose an evaluation task into independent dimensions and run them concurrently.

---

## The pattern we left out

Anthropic's orchestrator-workers pattern describes a central LLM that dynamically decomposes complex tasks and delegates to specialized workers. The subtasks emerge from analysis rather than predefinition — the orchestrator invents work on the fly.

Phase0 deliberately avoids this. Every specialist agent is predefined, contract-bound, and discoverable. The facilitator routes to known specialists with documented input contracts. It does not invent new agent types at runtime or dynamically decompose tasks into novel subtasks.

This is a design choice rooted in the nature of the problem. Domain discovery is a structured discipline with known phases. The lenses are known. The artifact types are known. The evaluation dimensions are known. What is unknown is the domain content — the actors, goals, tensions, and boundaries that the conversation will uncover. The architecture holds the process stable while the content varies.

Dynamic task decomposition would work against this. If the facilitator could invent new specialist types mid-session, the process itself would become unpredictable. For a tool whose purpose is to bring structure to ambiguity, architectural predictability is a feature.

There is a deeper alignment with Anthropic's guidance here. The article warns that agents "trade higher latency and cost for better task performance" and recommends them only when "the task at hand actually needs" that flexibility. Phase0's routing pattern handles the dispatch decision without the overhead and error-compounding risk of dynamic orchestration. The simpler pattern is sufficient. The more complex one would add cost without adding capability.

---

## The hardest advice

"Start simple" is the first and most prominent recommendation in Anthropic's article. It sounds obvious. In practice, it was the advice we had to learn by violating it.

The first agent built for Phase0 was a use case designer. It was conceived as a facilitator — a conversational agent that would guide a domain expert through the entire discovery process, ask Socratic questions, formalize artifacts, and manage the flow between lenses. It was ambitious, sophisticated, and miscast.

The use case designer is excellent at structured formalization. Give it a primary actor and a conditional goal, and it will walk a four-phase session that produces a detailed use case artifact. But asking it to also facilitate open-ended discovery — to be loose and adaptive when the conversation needs looseness, then switch to rigorous and template-driven when an artifact is ready — collapsed two distinct skills into one agent. The result was an agent that did neither well.

The fix was simpler than the original design. The main conversation facilitates. Specialist agents formalize. The separation mirrors a real-world design session: the person at the whiteboard driving discussion is not the same person writing up the formal specification afterward. These are different skills exercised at different moments.

Anthropic's article makes this point through a different lens: invest in tool design with the same rigor you invest in prompts. The Phase0 team spent more time on creation scripts — shell scripts that scaffold artifact files with the correct structure so agents cannot produce malformed output — than on any individual agent's system prompt. These scripts are poka-yoke devices: they make mistakes structurally difficult rather than relying on the agent to remember the right format. The tool design advice turned out to matter more than the workflow patterns themselves.

The same principle extends to what Anthropic calls the agent-computer interface. Every specialist agent in Phase0 receives its domain knowledge through a contract system — matched pairs of content files and skill files that inject the right context at activation time. The agent does not need to know everything. It needs to receive exactly the right knowledge at the right moment. Designing that injection mechanism was the real architectural work.

---

## Writing on the whiteboard

One pattern that does not appear in Anthropic's taxonomy but proved essential is what Phase0 calls durability — the discipline of writing as you go.

Every specialist agent creates its output artifact early in the session, populated with what it knows and placeholders for what it does not. As the Socratic dialogue progresses, the agent updates the artifact in place: filling in sections, revising earlier content, removing placeholders. The artifact is not a deliverable produced at the end. It is a working document that evolves with the conversation.

This resembles working at a whiteboard more than writing a report. You write a little, you erase a little, you write again. The artifact at any moment reflects the current state of understanding — incomplete but durable. If the session ends early or the context window fills, the work survives on disk.

Durability is not a property of one agent. It is a behavioral contract that every agent inherits. The discipline ensures that discoveries are captured in the turn they occur, not deferred to a summary step that may never happen. In a system where context windows are finite and sessions can be interrupted, writing as you go is not a stylistic preference. It is an architectural necessity.

---

## The recursive case

Phase0 uses AI-facilitated Socratic dialogue to produce the domain models from which agentic systems are specified and built. It is itself an agentic system — one that was designed using the architectural patterns Anthropic identified and the design discipline it teaches to its users.

The patterns compose. Routing provides the decision spine. Prompt chaining enforces prerequisite discipline. Parallelization enables independent evaluation. The excluded pattern — orchestrator-workers — confirms that knowing when not to add complexity is as important as knowing which pattern to apply.

Anthropic's article closes with a principle that Phase0 embodies: "Success in the LLM space isn't about building the most sophisticated system. It's about building the right system for your needs." The right system for domain discovery is one that holds the process stable while the content varies — structured enough to produce rigorous artifacts, flexible enough to follow a conversation wherever it leads.

The [Phase0 repository](https://github.com/marklauter/phase0) is open. A companion case study explores the contract system, the specialist agents, and the evaluation architecture in detail.
