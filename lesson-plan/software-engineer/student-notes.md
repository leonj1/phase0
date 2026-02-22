# Software engineer track: student notes

Self-contained reading material for SWE01--SWE03. You have completed the foundation lessons on conditional goals, actors/drives, Socratic extraction, and use case anatomy. You know how to build software. This track teaches you how domain models become agentic systems.

---

## SWE01: Domain-driven design foundations

### The core idea

A domain model has boundaries, events, and rules that hold continuously. You discover these by finding contradictions in how different parts of the domain use the same words.

### Bounded contexts: own language, own rules, own truth

A bounded context is a region of the domain with its own language. The same word can mean different things in different contexts. That is not a defect. It is a signal.

Consider the word "shipment." Ask the warehouse team what it means. They say: items that have been picked and boxed, ready to leave. Ask the delivery team. They say: items loaded on a truck, in transit. Both are right -- inside their own context.

You do not design these boundaries. You discover them through contradictions. When the same word means different things to different people, you have found a boundary.

In the wiki-agent system, "correction" appears in two contexts. In Issue Resolution (DC-03), a correction is an applied fix from a GitHub issue filed by a proofreader. In Drift Detection (DC-04), a correction is an applied fix from a fact-checker's assessment against source code. The trigger is different. The authority is different. The workflow is different. The word is the same. Two bounded contexts.

The wiki-agent has six bounded contexts:

| Context | What it owns |
|---------|-------------|
| DC-01 Wiki Creation | Transition from empty wiki to populated wiki |
| DC-02 Editorial Review | Critique of existing content across four editorial lenses |
| DC-03 Wiki Revision | Remediation of documented problems from GitHub issues |
| DC-04 Drift Detection | Ongoing verification of claims against sources of truth |
| DC-05 Workspace Lifecycle | Provisioning and decommissioning of project workspaces |
| DC-06 Wiki Restructuring | Interactive restructuring of an existing wiki |

Each context defines its own ubiquitous language. DC-01 talks about "exploration reports," "wiki plans," and "writing assignments." DC-02 talks about "editorial lenses," "findings," and "severity." These terms have precise meaning inside their context. They do not need to agree across contexts.

### Domain events: the published language between contexts

Actors communicate through meaningful state transitions, not function returns. A domain event is the fact that something happened. It has a name, a payload, and consumers.

Name events as past-tense nouns: WikiPopulated, FindingFiled, WikiSynced. These are facts. WikiPopulated means the wiki went from empty to populated. FindingFiled means a documentation problem was recorded as a GitHub issue.

These are not commands ("PopulateWiki") or descriptions ("WikiPopulation"). They are statements of what occurred.

Domain events are the published language between bounded contexts. FindingFiled crosses from Editorial Review (DC-02) to Wiki Revision (DC-03). The event is the integration contract. No internal state is shared across the boundary.

The wiki-agent has seven domain events:

| Event | Context | What it signifies |
|-------|---------|-------------------|
| DE-01 WikiPopulated | DC-01 | Wiki has been populated from source code |
| DE-02 FindingFiled | DC-02 | A documentation problem has been filed as a GitHub issue |
| DE-03 WikiReviewed | DC-02 | The review process has completed |
| DE-04 WikiRemediated | DC-03 | All actionable issues have been processed |
| DE-05 WikiSynced | DC-04 | All factual claims have been checked and drift corrected |
| DE-06 WorkspaceProvisioned | DC-05 | A new workspace is ready for editorial operations |
| DE-07 WorkspaceDecommissioned | DC-05 | A workspace has been removed |

Notice that some events cross boundaries (FindingFiled goes from DC-02 to DC-03) and some are consumed only by the user (WikiReviewed). Both are domain events because they represent observable outcomes.

### Invariants hold continuously

An invariant is a domain rule that must hold before, during, and after execution. It is not a precondition you check once at the start.

"The elevator must not move with doors open." If you check this only at departure, you miss the case where doors malfunction mid-transit. The invariant must hold at every moment.

"Source code is the single source of truth." In the wiki-agent, this invariant holds during wiki creation (UC-01), during review (UC-02), during sync (UC-04). An agent that invents a claim from training data instead of reading source code has violated this invariant mid-scenario, even if the claim happens to be correct.

Invariants are different from preconditions. A precondition is an entry gate: "workspace must exist before wiki creation." That is checked once. An invariant is a continuous constraint: "every claim must be grounded in source code." That is checked always.

### Intent over mechanics

Scenario steps express what is accomplished, not how.

Good: "Wiki content is verified against current source."
Bad: "Run grep on lines 1-50 of each file."

The first gives an actor room to find the best path. The second prescribes a method. In a domain model, you describe intent. The actor's job is to satisfy it. The use case's job is to express it clearly.

### Markdown is the wire format

In the wiki-agent system, every protocol, event, report, and assessment is materialized as markdown. Not JSON. Not YAML. Not protocol buffers.

The consumers are humans and LLM agents. Both read markdown natively. A system whose integration points are optimized for human and AI consumption does not need a serialization layer between them.

### Try it

Identify 3 bounded context candidates in the elevator system from the foundation lessons. For each context, define one domain event.

Remember: look for contradictions in language. What word means different things to different actors? Where does the same concept have different rules? Those contradictions are your boundaries.

### Further reading

- `usecase-lens.md` -- invariants as continuous constraints, scenario steps express intent
- `modeling-vocabulary.md` -- domain events, markdown as wire format
- `context-lens.md` -- bounded contexts over shared models
- `DOMAIN-MODEL-ARTIFACTS.md` -- what artifacts to produce and when they emerge
- `models/marklauter/github-wiki-manager/domains/` -- all six bounded contexts and the domain events catalog
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- how bounded contexts and events fit into the catalog

---

## SWE02: From model to agentic system

### The core idea

Domain models map directly to agentic systems. Actor drives become system prompts, tool restrictions enforce single responsibility, and hooks enforce invariants.

### Drives become system prompts

In the foundation lessons you learned that supporting actors have drives -- behavioral tendencies that determine what they optimize for. When you implement an agentic system, those drives become system prompts.

But the way you express the drive matters.

**Task-oriented prompt:** "Review this page for errors."
**Drive-oriented prompt:** "Your job is to find what's wrong. Every claim is suspect until verified against source code."

The first produces compliance. The agent will scan the page, perhaps find some errors, and report.

The second produces vigilance. The agent identifies as a critic. It approaches every claim with suspicion. Same model, same tools, same data -- different behavior.

Every subagent's drive traces back to a tension involving the primary actor's goal. The proofreader's critique drive exists because the creator's production drive alone will not protect accuracy -- and accuracy is a value condition on the user's goal. If a subagent's drive cannot trace that genealogy back to a primary actor's goal, the agent should not exist.

Write prompts that express the drive first, then scope the work.

### Tool restrictions enforce single responsibility

"Separate judgment from execution" is not a guideline. It is structural. You enforce it by controlling which tools each agent can access.

In the wiki-agent system:

| Actor | Drive | Tools | Why |
|-------|-------|-------|-----|
| Researchers | Comprehension | Read, Grep, Glob | Read-only. Cannot modify what they study. |
| Proofreaders | Critique | Read, Grep, Glob | Read-only. Cannot fix what they find. |
| Creators | Production | Write, Edit | Must modify files. That is the drive. |
| Correctors | Remediation | Write, Edit | Must apply corrections. Targeted edits only. |
| Fact-checkers | Verification | Read, Grep, Glob | Read-only. Determines what is true, does not fix anything. |

Notice that researchers and proofreaders have the same tools. The tools do not define the actor. The drive does.

A researcher with Read/Grep comprehends. A proofreader with Read/Grep critiques. Same tools, different system prompt, different behavior.

If you give the proofreader Write access, it will start silently fixing issues instead of reporting them. It compromises between its critique drive and the newly available mutation capability. Removing the tool is not a limitation. It is focus.

### Orchestrators serve the primary actor's goal

Orchestrators are not subagents. They hold the primary actor's goal. They coordinate, delegate, and synthesize.

The commissioning orchestrator in UC-01 dispatches researchers, feeds their reports to the developmental editor, presents the plan for user approval, and dispatches creators. It does not comprehend source code (that is the researcher's drive). It does not synthesize structure (that is the developmental editor's drive). It does not write pages (that is the creator's drive).

The orchestrator ensures the drives, taken together, satisfy the user's goal.

### Hooks enforce invariants, prompts carry advice

Some rules require judgment. Some do not.

"Prefer concise headings" requires judgment. Put it in the system prompt. The agent applies it as best it can.

"Never write to the source repository" requires no judgment. Put it in a hook. A PreToolUse hook that blocks writes outside the wiki directory runs outside the agentic loop. The LLM cannot override it, negotiate with it, or forget it.

The rule of thumb: if a rule must hold with zero exceptions, it is a hook. If a rule requires judgment, it belongs in the system prompt.

### Scripts own deterministic behavior

Git operations, GitHub CLI calls, filesystem setup, config parsing -- these are deterministic. They do not require judgment.

The LLM decides what to do. The script does it reproducibly. A script that runs `git clone` will always clone the repository. An LLM that "clones a repo" might decide to do something creative instead.

Put deterministic behavior in shell scripts. Put judgment in LLM agents. Do not mix them.

### Model selection by cognitive demand

Not every drive demands the same model. Match the model to the cognitive demand of the work.

| Cognitive demand | Examples | Model |
|-----------------|----------|-------|
| Mechanical -- run scripts, file issues, move files | Script execution, issue creation, config parsing | Haiku |
| Coordination -- delegate, relay, synthesize status | Orchestrators dispatching agents, relaying events | Sonnet |
| Knowledge work -- comprehension, production, critique | Researchers, creators, proofreaders, fact-checkers | Opus |

Haiku can run scripts but cannot comprehend source code. Sonnet can coordinate agents but does not produce content at the quality bar for wiki pages. Opus is the floor for any agent whose drive involves reading, understanding, judging, or creating.

When in doubt, use Opus. A cheaper model that produces wrong output costs more in rework than the right model costs in tokens.

### Context isolation prevents drive contamination

Subagents do not share context with each other. A creator cannot see the proofreader's findings while writing. A researcher cannot see what another researcher found.

This is correct. Isolation prevents drives from contaminating each other.

If the creator could see the proofreader's critique drive at work, it might self-censor. If the proofreader could see the creator's production context, it might soften its critique. Separation produces better outcomes.

Communication happens through the orchestrator. Researchers return reports. The orchestrator extracts relevant content and passes it to the next agent.

The orchestrator is the relay. Agents never talk to each other directly.

### Try it

Take the elevator actor catalog from the foundation lessons. For the Owner, Inspector, and Scheduler agents, specify:
1. A system prompt fragment that embodies the drive (not a task description).
2. Tool restrictions (what the agent can read, what it can write).
3. Which invariants belong in hooks (hard enforcement) vs. prompts (advisory).
4. A model tier: Haiku, Sonnet, or Opus.

### Further reading

- `DOMAIN-IMPLEMENTATION-PRINCIPLES.md` -- all implementation principles with rationale
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- full actor definitions showing how drives map to agent types

---

## SWE03: The complete model

### The core idea

A use case model is an ecosystem of cross-referenced artifacts, discovered through iteration. The model is never constructed top-down -- it emerges from bottom-up Socratic interviews and continuous consolidation.

### The artifact ecosystem

A use case model is not a single document. It is an ecosystem of artifacts that reference each other.

| Artifact | Purpose | When it emerges |
|----------|---------|-----------------|
| Philosophy | Guiding principles every artifact must reflect | First. Before the first use case. |
| Template | Structural contract for individual use cases | Early. Draft before the first use case. |
| Individual use cases | Each describes one goal pursued by one primary actor | Iteratively through Socratic interviews |
| Actor catalog | Every actor, their goals or drives, where they appear | After 2-3 use cases, when actors repeat |
| Shared invariants | Cross-cutting rules referenced by multiple use cases | After 2-3 use cases, when invariants repeat |
| Use case catalog | The entry point. Frames goals, describes domain, lists everything. | After the first use case exists |
| Domain contexts | Each bounded context with its own language and rules | Late. After clustering becomes visible. |
| Domain events catalog | Published events that cross boundaries | Late. Alongside domain contexts. |
| Glossary | Canonical vocabulary for the entire model | Gradually, starting when vocabulary settles |

### The relationship map

Here is how the artifacts reference each other:

```
PHILOSOPHY.md
  | (principles encoded into)
  v
TEMPLATE.md
  | (structure followed by)
  v
UC-{id}-{slug}.md  <-->  UC-{id}-{slug}.md
  ^                        ^
  |                        |
  +-- SHARED-INVARIANTS.md (cross-cutting rules)
  +-- domains/DC-{id}-{slug}.md (bounded context)
  +-- domains/DOMAIN-EVENTS.md (published events)

ACTOR-CATALOG.md  <-- (consolidates actors from all UCs)
USE-CASE-CATALOG.md  <-- (indexes everything)
GLOSSARY.md  <-- (canonical vocabulary for all artifacts)
```

Every arrow is a reference, not a dependency. Any artifact can be read standalone. The model is richer when read as a whole.

### Five phases

The model emerges through five phases. They are numbered for exposition, not for compliance.

**Phase 1: Establish principles.** Write down what you believe about modeling. Philosophy and template. This happens before the first use case, even if it is only two principles.

**Phase 2: Design individual use cases.** The core of the work. One use case at a time, through Socratic interviews. The first use case takes the longest. It establishes vocabulary and discovers the first actors. By the third use case, the domain language is settling.

**Phase 3: Consolidate.** After several use cases exist, step back. Actor catalog gathers every actor. Shared invariants extract repeated constraints. Use case catalog indexes everything.

**Phase 4: Model the domain.** Bounded contexts and domain events become visible. Formalize what was implicit -- the natural clustering, the language boundaries, the events that cross those boundaries.

**Phase 5: Refine.** Make it consistent, precise, and honest about its gaps. Remove implementation leaks from scenarios. Verify cross-references. Check the philosophy against every use case.

### Backtracking is correct

Phase 2 will send you back to phase 1 repeatedly. The philosophy is not complete until the model is complete.

Phase 3 will send you back to phase 2 to reconcile use cases that consolidated poorly. Phase 4 will send you back to phase 3 when bounded contexts reveal that shared invariants were scoped wrong. Phase 5 will send you back anywhere.

This is the process. A use case model is discovered, not constructed. Each phase deepens understanding. Deeper understanding revises earlier assumptions.

When you go back, update the artifact. Do not leave stale assumptions in place because they were written first. The model must be internally consistent at all times.

### The use case catalog as entry point

The use case catalog answers three questions for someone new to the model: Who is this for? What problem does it solve? What are the pieces?

The wiki-agent catalog opens with the user's goals (Cooper's hierarchy: life goal, experience goal, end goals). It describes the domain (documentation accuracy, drift as the core problem). It lists all use cases with one-line summaries. It provides the bounded contexts table showing which use cases and domain events belong to which context.

Here is the wiki-agent bounded contexts table:

| Context | Use cases | Domain events |
|---------|-----------|---------------|
| DC-01 Wiki Creation | UC-01 | DE-01 WikiPopulated |
| DC-02 Editorial Review | UC-02 | DE-02 FindingFiled, DE-03 WikiReviewed |
| DC-03 Wiki Revision | UC-03 | DE-04 WikiRemediated |
| DC-04 Drift Detection | UC-04 | DE-05 WikiSynced |
| DC-05 Workspace Lifecycle | UC-05, UC-06 | DE-06 WorkspaceProvisioned, DE-07 WorkspaceDecommissioned |
| DC-06 Wiki Restructuring | UC-08 | (not yet designed) |

You can trace any thread through the model from this table. FindingFiled is produced by UC-02 in DC-02. It is consumed by UC-03 in DC-03. Follow the links and you find the full event definition, the producing use case, and the consuming use case.

### Cross-references are structural integrity

Every domain event referenced in a use case must exist in DOMAIN-EVENTS.md. Every bounded context referenced must have a file. Every actor must appear in the catalog. Every shared invariant referenced must exist in SHARED-INVARIANTS.md.

A broken reference means something was renamed or removed without updating dependents. It is a model defect.

When you update one artifact, trace its references. Update the dependents. The glossary is the canonical spelling. If a term is renamed there, it is renamed everywhere.

### Try it

Design a USE-CASE-CATALOG.md for the elevator system. Include:
- The Passenger's goals (from foundation lessons).
- A domain description.
- 3 use cases with one-line summaries (titles are verbs).
- 2 bounded contexts.
- 3 domain events (past-tense nouns).
- A bounded contexts table showing which use cases and events belong where.

Use the wiki-agent USE-CASE-CATALOG.md as a structural reference.

### Further reading

- `DOMAIN-MODEL-ARTIFACTS.md` -- full descriptions of every artifact type and when each emerges
- `SYSTEM-DESIGN-PHASES.md` -- the five phases in detail, including what triggers backtracking at each phase
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- the reference catalog to use as a structural model
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- reference actor catalog showing consolidation
- `models/marklauter/github-wiki-manager/SHARED-INVARIANTS.md` -- reference shared invariants showing extraction
