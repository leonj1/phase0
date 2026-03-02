# Phase0: A Case Study in Applied Agent Architecture

*Contracts, specialists, and the durability discipline inside an AI-facilitated domain discovery tool*

The [companion article]() described which of Anthropic's ["Building Effective Agents"](https://www.anthropic.com/engineering/building-effective-agents) patterns Phase0 uses and why. This case study describes how — the contract system that governs what every agent knows and produces, the specialist agents that formalize discoveries, the evaluation pipeline that verifies artifacts, and the durability discipline that ensures nothing gets lost.

The [Phase0 repository](https://github.com/marklauter/phase0) is open. This article describes the architecture at a conceptual level; the repo contains the full implementation.

---

## What Phase0 does

Phase0 is a domain discovery tool. A facilitator agent conducts Socratic dialogue with a human domain expert — asking targeted questions, surfacing contradictions, and refining vocabulary — while specialist agents formalize what the conversation reveals into structured artifacts: actor catalogs, use case models, bounded context maps, domain events, invariants, and glossaries.

The methodology draws on Alan Cooper's goal-directed design and Eric Evans' domain-driven design. Cooper contributes the actor model — primary actors with conditional goals, supporting actors with drives, and the idea that system design emerges from tensions between what actors value and what reality can deliver. Evans contributes the structuring model — bounded contexts as semantic regions, domain events as published facts, and ubiquitous language as the shared vocabulary within each context.

The discovery process operates through three lenses — the actor lens, the use case lens, and the bounded context lens. These form a complete graph: discoveries through any lens can redirect attention to any other. An actor discovery session surfaces use cases. Use case design reveals missing actors. Context mapping exposes term conflicts that reshape actor boundaries. The facilitator shifts between lenses fluidly, following the conversation wherever it leads.

The only structural constraint is an invariant: establish the primary actor and their conditional goal before dispatching to use case or bounded context work. Everything else in the model derives from that foundation.

---

## The contract system

Phase0's instruction set lives in `.claude/contracts/` — a directory of markdown files organized into three subdirectories: principles, forms, and meta.

**Principles** teach how agents think. The modeling foundation defines the shared vocabulary — goals, drives, tensions, conditional goals, invariants, domain events. Lens-specific principles add depth: the actor lens teaches derivation chains and noun refinement; the use case lens teaches goal-directed scenarios and continuous invariants; the bounded context lens teaches term ownership and integration protocols. The durability principle teaches every agent to write as it goes.

**Forms** constrain what agents produce. Each form defines the required sections, their ordering, and placeholder guidance for one artifact type — use cases, actors, contexts, events, invariants, glossary entries, catalogs, notes, todos, and evaluation reports. Forms are pure structure. They carry no philosophy and no creation mechanics. A form serves both reading and writing: the same contract tells an agent what sections to expect when reading an artifact and what sections to produce when writing one.

**Meta contracts** govern the system itself. One defines what a contract is — binding knowledge that constrains rather than informs. Another describes the contract directory structure. A third defines the model output structure — where each artifact type lives, its naming convention, and its governing form.

The three layers compose. An agent loads a stack of contracts, and the stack has dependencies. The modeling foundation is the base — it defines what "conditional goal" and "domain event" mean. Lens principles build on that foundation — "surface invariants" and "name domain events at state transitions" are meaningful only because the foundation defines those terms. Forms constrain what the lens produces. The stack is explicit: each contract can rely on the contracts beneath it.

### The matched-pair convention

Contracts reach agents through skills — Claude Code's mechanism for injecting context at activation time. Each contract has a matched skill file in `.claude/skills/`. The skill file is a thin loader: YAML front matter describing when the skill activates, plus a `!cat` directive — Claude Code's mechanism for including file content at activation time — that injects the contract file's content. The contract file owns the content. The skill file owns the injection. Together they form one logical unit.

This convention enforces a single source of truth. When a form is revised, the revision happens in one place — the contract file. Every agent that loads the matching skill receives the updated content automatically. No content is duplicated between contracts and skills.

### Creation scripts as poka-yoke

Anthropic's article emphasizes tool design: "make mistakes harder to commit." Phase0 applies this through creation scripts — shell scripts in `.claude/scripts/` that scaffold artifact files with the correct structure. When the use case designer creates a new use case, it calls `create-usecase.sh` with a sequence number and slug. The script produces a file with every required section in the correct order, pre-populated with contextual values (the bounded context, the producing actor) and TODO placeholders for content the agent will fill in during the session.

The agent cannot produce a structurally malformed artifact because the script handles the structure. Judgment stays in the agent — what to name the use case, what the scenario is, which invariants apply. Mechanics stay in the script — file naming, section ordering, placeholder scaffolding. This separation is Anthropic's poka-yoke principle applied to agent output: the tool makes the correct structure easy and the incorrect structure impossible.

---

## The facilitator as router

Phase0's facilitator is a router — but unlike Anthropic's textbook examples, it does not classify discrete inputs. It classifies the accumulated state of a conversation.

The facilitator is not a purpose-built agent. It is the main Claude Code conversation — the session that begins when a user starts talking to the agent — equipped with a skill that teaches it how to conduct a discovery session. The `facilitating-discovery` skill gives the facilitator three capabilities: it knows the three lenses and when to shift between them, it knows the dispatch mechanics for each specialist agent, and it enforces the actor-first invariant.

The routing decision is a judgment about readiness. As the conversation progresses, raw material accumulates around one lens or another — observations about who the system serves (actor lens), descriptions of interactions that need to happen (use case lens), or vocabulary conflicts that suggest partitioning (bounded context lens). The facilitator monitors this accumulation and dispatches a specialist when enough material is present for the specialist to do meaningful work.

Each specialist has an input contract — the minimum context it needs to begin:

- The actor discovery agent requires a domain context and an area of focus.
- The use case designer requires a primary actor and their conditional goal.
- The context mapping agent requires an observed contradiction or area of partition.

The facilitator satisfies the input contract before dispatching, passing the required context in the dispatch prompt. It does not invent new specialists or dynamically decompose tasks. It routes to predefined agents with documented contracts. The specialist set is stable. The domain content varies.

---

## Specialist agents as formalizers

The specialist agents are formalizers, not facilitators. They receive a well-defined starting point from the facilitator, conduct a structured Socratic session with the user to deepen it, and produce formal artifacts. The facilitator handles the fluid, nonlinear, backtracking-heavy conversational work of open discovery. The specialists handle the rigorous, template-driven work of crystallizing discoveries into structured documents.

This separation mirrors a real-world design session. The person at the whiteboard driving discussion is not the same person writing up the formal specification afterward. These are different skills exercised at different moments.

### The use case designer

The use case designer operates in four phases: anchor the use case (confirm the primary actor and their conditional goal, identify the trigger and bounded context), discover supporting actors and responsibilities, surface invariants and constraints, and walk the scenario step by step in terms of intent.

The agent creates the artifact file early — in phase one, using the creation script — populated with what it knows and TODO placeholders for what it does not. As the session progresses through phases, the agent updates the file in place: filling in sections, revising earlier content, removing placeholders. The four phases are Anthropic's prompt chaining pattern at the agent level — each phase builds on the output of the previous one, with soft gates that allow discoveries to pull the agent back to earlier phases when needed.

The agent loads a specific skill stack:

- The modeling foundation — shared vocabulary
- The use case lens — scenario design, goal obstacles, continuous invariants
- Form contracts for the artifact types it produces — use cases, events, invariants
- The durability contract — write-as-you-go discipline
- The editorial standards contract

The stack gives the agent exactly the knowledge it needs — no more. It does not load the actor lens or bounded context lens because those belong to other specialists.

### The actor discovery agent

The actor discovery agent applies Cooper's noun refinement cycle — qualify, refine, separate — to extract precise actors from the sloppy nouns domain experts naturally use. "The customer" becomes Sender, Recipient, Complainant — each carrying its own meaning without needing a qualifier. The agent derives conditional goals for primary actors, exposes the tensions those goals create when they meet reality, and traces each supporting actor's genealogy back through a tension to a specific value condition.

### The context mapping agent

The context mapping agent watches for the signals that context boundaries produce — the same word meaning different things to different people, responsibilities that separate naturally, vocabulary that diverges across conversations. It formalizes these observations into bounded context definitions with ubiquitous language, events produced and consumed, and integration points.

### Cross-lens discovery and the handoff mechanism

Each specialist operates within its own lens, but discoveries routinely cross lens boundaries. A use case designer discovers a new supporting actor. An actor discovery session reveals a context boundary. A context mapping session exposes a missing use case.

Agents do not do each other's work. This is a structural rule, not a guideline. Each agent has lens ownership — a defined scope of artifact types it can formalize, determined by the skills it loads. The use case designer loads use case, event, and invariant forms. It does not load the actor form. It lacks the form contract for actor artifacts — it does not know the required structure, so the durability discipline directs it to write a note instead.

When a discovery crosses a lens boundary, the agent writes a note and a todo. The note captures the observation durably — "discovered a supporting actor whose drive is visibility; the Tracker exists because no primary actor's goal alone produces package tracking." The todo captures the action — "stub actor file for Tracker in actors/." The note preserves *why*. The todo drives *what happens next*.

This is the handoff mechanism. Notes and todos are the coordination layer between specialists. No agent reaches into another agent's scope. No agent waits for another agent to act. The discovering agent writes the note and the todo, then continues its own work. The next time the facilitator routes to the actor lens, the todo is waiting. The owning specialist picks it up and formalizes it with the full depth of its own lens.

The result is a system where specialists stay focused and nothing falls through the cracks. Every cross-lens discovery produces a durable trail — a note that remembers the context and a todo that demands the follow-up. The handoff is asynchronous, artifact-mediated, and requires no direct communication between agents.

---

## Evaluation as parallelized sectioning

Anthropic describes parallelization through two mechanisms: sectioning (independent subtasks run simultaneously) and voting (the same task runs multiple times for confidence). Phase0 uses sectioning for model evaluation.

Four evaluation agents assess model artifacts along independent dimensions:

- **Structure** — do artifacts conform to their form contracts? Are required sections present and in the correct order? Do file names match conventions?
- **References** — do cross-references resolve? Does every actor mentioned in a use case appear in the actor catalog? Does every glossary term referenced in an artifact have a glossary entry?
- **Coherence** — do related artifacts agree with each other? Does the same term carry consistent meaning across the model? Do actor descriptions in use cases match their definitions in the actor catalog?
- **Style** — does prose meet the editorial standards contract? Is the tone consistent? Is the voice appropriate?

All four are read-only. No evaluation agent modifies any artifact. This independence is what enables parallelization — the facilitator dispatches all four simultaneously via four concurrent agent calls. No agent can invalidate another's input because no agent mutates shared state.

Each agent produces a structured findings report with classified findings (missing section, broken reference, semantic drift, style violation), severity levels, evidence, and remediation guidance. The facilitator consolidates the four reports and presents a unified summary to the user. Actionable findings become todos — ephemeral work items that disappear when the remediation is done.

The evaluation agents inherit the same contract stack as the modeling agents — they load the form contracts for every artifact type so they know what correct structure looks like, the editorial standards contract so they know what correct style looks like, and the evaluation stance contract that keeps them read-only and evidence-based.

---

## Tool design and the agent-computer interface

The creation scripts described earlier are the most direct example of what Anthropic calls the agent-computer interface — but they are not the only one. Three design decisions collectively define the surface through which agents interact with the system's state.

**Creation scripts** separate judgment from mechanics. The agent decides what to name a use case and which invariants apply. The script handles file naming, directory placement, and section scaffolding. The agent cannot produce a malformed artifact because the tool handles the structure.

**Contract injection** separates knowledge from loading. An agent does not need to know where form contracts are stored, how to read them, or when to load them. The skill system handles injection automatically. When the agent activates, its skill stack appears in context — the right knowledge at the right moment. The agent sees the rules; it does not manage the loading machinery. When a contract is revised, the revision happens in one file and propagates automatically to every agent that loads the matching skill.

**Model directory structure** separates navigation from search. Each artifact type gets its own directory, its own naming convention, its own catalog, and its own form. An agent can predict where any artifact lives based on its type alone. An evaluation agent can inventory all artifacts by globbing for markdown files in known directories. The structure makes correct navigation trivial and incorrect navigation obvious — an actor file in the events directory is a visible error, not a silent one.

---

## Durability: writing on the whiteboard

One discipline that proved essential does not appear in Anthropic's taxonomy of workflow patterns: durability — the practice of writing as you go and refining as you learn.

Every specialist agent creates its output artifact early in the session, populated with what it knows and placeholders for what it does not. As the Socratic dialogue progresses, the agent updates the artifact in place. The file at any moment reflects the current state of understanding — incomplete but durable. If the session ends unexpectedly or the context window compresses, the work survives on disk.

This resembles working at a whiteboard more than writing a report. You write a little, you erase a little, you write again. The artifact evolves with the conversation. It is not a deliverable produced at the end — it is a working surface that captures the conversation's output incrementally.

Durability is not a behavior of one agent. It is a principle contract that every modeling agent loads through the `preserving-discoveries` skill. The contract specifies five categories of discovery and what to do with each:

1. **Refinement to the current artifact** — update the working file immediately.
2. **New artifact surfaces** — write a stub file with TODO placeholders. The artifact exists in the queue even if skeletal.
3. **Loose observation or question** — write a timestamped note. Enough context to map the discovery back to the model.
4. **Actionable work item** — write a todo. Ephemeral — deleted when the work is done.
5. **Both observation and action** — write both. The note preserves the insight; the todo drives the follow-up.

The critical property is timeliness: capture happens in the turn the discovery occurs, not at the end of the session and not when the user asks. The agent exercises judgment about what matters — not every utterance is a discovery — but when something matters, the write happens immediately. The user never has to say "save that." The system treats every discovery as perishable until it is on disk.

This discipline solves a problem that both humans and AI agents share: finite working memory. In a long discovery session, early insights compress and fade. Three sessions in, nobody remembers exactly why the group decided to split Warehouse from Logistics. The notes remember. The iterative write-and-refine cycle guarantees that the model's history is preserved alongside its current state.

---

## What we learned

Phase0 has been in active development since February 2026. The architecture has been revised several times as the system was used to model its own domain — a recursive exercise that exposed gaps no amount of upfront design would have caught.

### Skill descriptions compete

When a system has twenty skills with overlapping vocabulary in their descriptions, the model struggles to choose between them. Phase0's early skill set had separate reading and writing skills for each artifact type — twenty skills with nearly identical triggers. The solution was consolidation: one skill per artifact type that handles both reading and writing, with descriptions rewritten as activation conditions rather than topic inventories. The descriptions tell the model *when* to fire, not *what the skill is about*. This mirrors Anthropic's tool design guidance — give the model clear decision boundaries.

### The facilitator needs a floor

Skills inject context on demand, which is elegant until you realize the facilitator needs baseline vocabulary to recognize *when* to activate a skill. If the facilitator does not know what a conditional goal is, it cannot recognize that the user is describing one, and the actor discovery skill never fires. The fix was identifying the minimum grounding layer and ensuring it loads at session start: the modeling foundation (vocabulary), the model structure (where things go), and the durability principle (preservation discipline). Everything else arrives through skills. These three contracts are the floor.

### Agent memory as institutional knowledge

Each specialist agent has persistent memory that survives across sessions — patterns observed, edge cases encountered, naming conventions that emerged in a specific domain. This institutional knowledge accumulates over time. An evaluation agent that has audited the same model three times knows which structural deviations recur. A use case designer that has worked in a specific domain knows which invariant patterns surface repeatedly. The memory is project-scoped and version-controlled alongside the model.

### The evaluator-optimizer loop is human-gated

Phase0's evaluation pipeline produces findings. The modeling agents can remediate those findings. The loop exists — evaluate, fix, re-evaluate — but the user decides what to fix and when to re-evaluate. This is a deliberate choice. Automated remediation would require the system to judge which findings matter, and that judgment belongs to the domain expert. The human stays in the loop not because the architecture cannot close it, but because the design discipline requires it.

---

## The recursive nature

Phase0 models its own domain using its own tools. The actors, use cases, bounded contexts, and domain events that describe Phase0 were discovered through the same Socratic process that Phase0 facilitates for other domains. The model lives alongside the implementation in the repository — a living example of the artifacts the system produces.

This recursion is more than a curiosity. It is the primary test of the methodology. If the discovery process cannot model itself — if its own architecture cannot be expressed in its own artifact language — then the language is incomplete. Every gap in the model is a gap in the tool.

The architecture holds the process stable while the content changes. Routing provides the decision spine. Prompt chaining enforces prerequisite discipline. Parallelization enables independent evaluation. The patterns compose because each addresses a different concern — and the one pattern deliberately excluded (dynamic task decomposition) was excluded because architectural predictability is a feature of a tool whose purpose is to bring structure to ambiguity.

Phase0 is structured enough to produce rigorous artifacts, flexible enough to follow a conversation wherever it leads, and durable enough to remember what it found.
