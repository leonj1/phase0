# Building an Agentic System to Design Agentic Systems

*How Anthropic's agent architecture patterns compose in a real domain discovery tool*

In December 2024, Anthropic published ["Building Effective Agents"](https://www.anthropic.com/engineering/building-effective-agents) — five workflow patterns for LLM-based systems and practical guidance on when to use each one. Start simple. Invest in tool design. Only add complexity when simpler approaches fall short.

We built Phase0 on Claude Code. It uses Socratic dialogue to extract domain knowledge from a human expert and formalize it into vision statements, use case models, and bounded context maps — the upstream artifacts from which agentic systems get specified and built. An agentic system that designs agentic systems.

We mapped Phase0's architecture against Anthropic's taxonomy. Three of the five patterns showed up. One was deliberately left out. And the simplest advice — start simple — was the one we had to learn twice.

This is the first of two articles. A [companion case study]() goes deeper into the architecture.

---

## The upstream problem nobody solves

Everyone is building agents. Nobody is modeling what those agents should do first.

A team identifies a problem, sketches workflows, picks a framework, starts wiring tools together. The disciplined ones write tests. The experienced ones define bounded contexts. But the foundational questions — who does this system serve, what do they value, what tensions exist between those values and reality — get answered informally or not at all. The design is implicit in the code instead of explicit in a model.

Phase0 addresses that gap. It's the zeroth thing — before use cases, before bounded contexts, before architecture decisions. Someone has to stand at a blank whiteboard with domain experts and extract a shared understanding through dialogue.

The question was how to build a tool for that. Anthropic's article gave us the vocabulary.

---

## The conversation is the facilitator

The key realization had nothing to do with patterns. It was about what already existed.

The main Claude Code conversation is already a facilitator. It listens. It asks questions. It notices when something important gets said. It decides what to explore next. It dispatches specialist agents when the conversation is ready for them.

We didn't build an orchestration layer. We equipped the existing conversation with guidance documents and specialist agents. The facilitator isn't a component to be engineered. It's the conversation itself, given structure.

That maps directly to Anthropic's first piece of advice: find the simplest solution possible. The simplest facilitator is the one you already have. Skills, contracts, specialist agents — all of it exists to make the conversation more effective, not to replace it.

---

## Three patterns that showed up

### Routing: the spine

Anthropic describes routing as classifying inputs and directing them to specialized handlers. Our facilitator does this — but it classifies conversation state, not discrete inputs.

Three lenses frame the discovery session: the actor lens (who does this system serve?), the use case lens (what interactions does the design demand?), and the bounded context lens (where do meanings partition?). As conversation progresses, raw material accumulates around one lens or another. When enough material is present, the facilitator dispatches a specialist to formalize it.

Each specialist has an input contract — the minimum context it needs to begin:

- Actor discovery receives a domain context and an area of focus.
- The use case designer receives a primary actor and their conditional goal.
- Context mapping receives an observed contradiction or partition.

The routing decision is a judgment about readiness. Has enough material accumulated for a specialist to do real work? That's the classification criterion — accumulated context, not a single message.

### Prompt chaining: gates between phases

Phase0 uses chaining at two scales.

At the macro level, the actor lens must produce at least one primary actor with a conditional goal before use case work can begin. Not a suggestion — an invariant. If a user asks to design a use case before establishing the actor, the facilitator redirects to actor discovery first. The invariant is a gate: the prerequisite output must exist before the next phase starts.

Within each specialist, the same pattern repeats. The use case designer runs four phases: anchor the use case, discover supporting actors, surface invariants, walk the scenario. Each builds on the previous. The agent creates the artifact file early with placeholders and fills it in progressively. The gates are soft — a discovery in phase four can pull you back to phase two — but the structure provides direction.

### Parallelization: independent evaluation

Four evaluation agents assess model artifacts along independent dimensions: structure, references, coherence, and style. All four are read-only — none modifies anything — so they run simultaneously. No agent can invalidate another's input.

The facilitator dispatches all four in parallel, consolidates findings into a single report, and presents it to the user. Textbook sectioning.

---

## The pattern we left out

Anthropic's orchestrator-workers pattern has a central LLM dynamically decomposing tasks and delegating to workers it invents on the fly.

We deliberately avoided this. Every specialist agent is predefined, contract-bound, discoverable. The facilitator routes to known specialists with documented input contracts. It doesn't invent new agent types at runtime.

Domain discovery is a structured discipline. The lenses are known. The artifact types are known. The evaluation dimensions are known. What's unknown is the domain content — the actors, goals, tensions, and boundaries the conversation will uncover. The architecture holds the process stable while the content varies.

If the facilitator could invent new specialists mid-session, the process itself becomes unpredictable. For a tool that brings structure to ambiguity, architectural predictability is a feature.

Anthropic warns that agents "trade higher latency and cost for better task performance." Routing handles the dispatch without the overhead of dynamic orchestration. The simpler pattern is sufficient. The more complex one adds cost without adding capability.

---

## The hardest advice

"Start simple." Sounds obvious. We had to learn it by violating it.

The first agent we built was a use case designer. We conceived it as a facilitator — guide the expert through the whole discovery process, ask Socratic questions, formalize artifacts, manage flow between lenses. Ambitious, sophisticated, miscast.

The use case designer is excellent at structured formalization. Give it a primary actor and a conditional goal and it walks a four-phase session that produces a detailed artifact. But asking it to also facilitate open-ended discovery — loose and adaptive when the conversation needs looseness, rigorous and template-driven when an artifact is ready — collapsed two skills into one agent. It did neither well.

The fix was simpler than the original design. The conversation facilitates. Specialists formalize. Same as a real design session: the person driving discussion at the whiteboard isn't the person writing the formal spec afterward. Different skills, different moments.

Anthropic makes this point differently: invest in tool design with the same rigor you invest in prompts. We spent more time on creation scripts — shell scripts that scaffold artifact files so agents can't produce malformed output — than on any agent's system prompt. Poka-yoke. Make mistakes structurally difficult instead of relying on the agent to remember the right format. That advice mattered more than the workflow patterns.

Same principle extends to what Anthropic calls the agent-computer interface. Every specialist gets its domain knowledge through a contract system — matched pairs of content files and skill files that inject the right context at activation time. The agent doesn't need to know everything. It needs the right knowledge at the right moment. Designing that injection mechanism was the real work.

---

## Writing on the whiteboard

One pattern not in Anthropic's taxonomy proved essential: durable capture. Write as you go.

Every specialist creates its output artifact early, populated with what it knows and placeholders for what it doesn't. As dialogue progresses, the agent updates the file in place — filling sections, revising earlier content, removing placeholders. The artifact isn't a deliverable produced at the end. It's a working document that evolves with the conversation.

Like a whiteboard. You write a little, you erase a little, you write again. At any moment the artifact reflects current understanding — incomplete but durable. If the session ends early or the context window fills, the work survives on disk.

This isn't a property of one agent. It's a behavioral contract every agent inherits. Discoveries get captured in the turn they occur, not deferred to a summary step that may never happen. Context windows are finite. Sessions get interrupted. Writing as you go isn't a preference. It's an architectural necessity.

---

## The recursive case

Phase0 produces the domain models from which agentic systems get specified and built. It is itself an agentic system — designed using the patterns Anthropic identified and the discipline it teaches to its users.

The patterns compose. Routing is the decision spine. Chaining enforces prerequisites. Parallelization handles evaluation. The excluded pattern confirms that knowing when not to add complexity matters as much as knowing which pattern to apply.

Anthropic closes with a principle we've internalized: "Success in the LLM space isn't about building the most sophisticated system. It's about building the right system for your needs." The right system for domain discovery holds the process stable while the content varies. Structured enough for rigorous artifacts. Flexible enough to follow a conversation wherever it leads.

The [Phase0 repository](https://github.com/marklauter/phase0) is open. The [companion case study]() goes into the contracts, the agents, and the evaluation architecture.
