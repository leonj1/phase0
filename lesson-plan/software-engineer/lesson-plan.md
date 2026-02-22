# Software engineer track: lesson plan

Three lessons (SWE01--SWE03) for software engineers who have completed the four shared foundation lessons on conditional goals, actors/drives, Socratic extraction, and use case anatomy.

Students already know how to build software. This track teaches them domain-driven design and how domain models become agentic systems.

---

## SWE01: Domain-driven design foundations

### Learning objectives

1. Identify bounded context boundaries by finding contradictions in domain language.
2. Define domain events as the published language between bounded contexts.
3. Distinguish invariants (continuous constraints) from preconditions (entry gates).

### Key concepts

- **Bounded context.** A region of the domain with its own language, its own rules, and its own truth. The same word can mean different things in different contexts. A "correction" in Issue Resolution is an applied fix from a GitHub issue. A "correction" in Drift Detection is an applied fix from a fact-checker assessment. You do not design boundaries. You discover them through contradictions.
- **Domain event.** A meaningful state transition that crosses a bounded context boundary or is visible to the user as an observable outcome. Named as past-tense nouns: WikiPopulated, FindingFiled, WikiSynced. Domain events are the published language between contexts.
- **Invariant.** A domain rule that holds continuously -- before, during, and after execution. Not an entry gate you check once. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.
- **Intent over mechanics.** Scenario steps express what is accomplished, not how. "Wiki content is verified against current source" gives an actor room. "Run grep on lines 1-50 of each file" does not.
- **Markdown as wire format.** Protocols, events, reports, and assessments are all materialized as markdown. The consumers are humans and LLM agents. Both read markdown natively.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present bounded contexts through the "shipment" contradiction: warehouse means "items picked and boxed," delivery means "items loaded on a truck." Same word, different truth. That contradiction IS the boundary. | 15 min |
| Teach | Present domain events as the published language. Show how invariants differ from preconditions using the elevator: "elevator must not move with doors open" holds continuously, not just at departure. | 10 min |
| Demonstrate | Walk through the wiki-agent context map (DC-01 through DC-06). Show how each context owns its own ubiquitous language. Highlight that "correction" means different things in DC-03 (Issue Resolution) and DC-04 (Drift Detection). Show domain events DE-01 through DE-07 and how they cross boundaries. | 20 min |
| Exercise | Students identify 3 bounded context candidates in the elevator system. For each context, they define one domain event. Good candidates: Passenger Transport (ElevatorDispatched), Safety Inspection (InspectionCompleted), Scheduling (ScheduleOptimized). | 25 min |
| Debrief | Compare student answers. Focus on: did they find boundaries through contradictions in language? Are their events meaningful state transitions, not function returns? Do their context names reflect the domain, not technical layers? | 15 min |

**Total: 85 min**

### Source material

- `usecase-lens.md` -- invariants as continuous constraints, scenario steps express intent
- `modeling-vocabulary.md` -- domain events, markdown as wire format
- `context-lens.md` -- bounded contexts over shared models
- `DOMAIN-MODEL-ARTIFACTS.md` -- artifact types and when they emerge
- `models/marklauter/github-wiki-manager/domains/` -- DC-01 through DC-06, DOMAIN-EVENTS.md
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- bounded contexts table

---

## SWE02: From model to agentic system

### Learning objectives

1. Translate actor drives into system prompts that produce behavioral orientation, not task compliance.
2. Use tool restrictions to enforce single responsibility structurally, not advisorily.
3. Match model selection (Haiku/Sonnet/Opus) to cognitive demand of the work.

### Key concepts

- **Drives become system prompts.** A system prompt that says "review this page for errors" describes a task. A system prompt that says "your job is to find what's wrong -- every claim is suspect until verified against source code" embodies a drive. The first produces compliance. The second produces vigilance.
- **Tool restrictions enforce single responsibility.** A researcher gets Read, Grep, Glob -- no Write or Edit. A creator gets Write and Edit. The tool boundary is where drive separation becomes real. If an agent can both assess and mutate, it will compromise between the two.
- **Orchestrators serve the primary actor's goal.** Orchestrators hold the goal. Subagents have drives. The orchestrator ensures the drives, taken together, satisfy the goal's value conditions.
- **Hooks enforce invariants.** Advisory rules go in system prompts. Hard rules go in hooks. "Prefer concise headings" is advisory. "Never write to the source repo" is an invariant -- enforce it with a PreToolUse hook.
- **Scripts own deterministic behavior.** Git operations, CLI calls, filesystem setup -- these do not require judgment. They belong in shell scripts, not in LLM reasoning. The LLM decides what to do. The script does it reproducibly.
- **Model selection by cognitive demand.** Haiku: mechanical (run scripts, file issues). Sonnet: coordination (dispatch agents, relay events). Opus: knowledge work (comprehension, production, critique, decision-making).
- **Context isolation prevents drive contamination.** A creator cannot see the proofreader's findings while writing. Isolation prevents drives from contaminating each other.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present each implementation principle with its bridge from model to code. Start with drives becoming system prompts -- show the difference between "review this page" (task) and "your job is to find what's wrong" (drive). | 15 min |
| Teach | Present tool restrictions, hooks vs. prompts, scripts vs. LLM reasoning, and model selection. Use the cognitive demand table. | 10 min |
| Demonstrate | Walk through how wiki-agent actors map to Claude Code agents. The Creator gets Write/Edit tools. The Proofreader gets Read/Grep. Show how the Oversight orchestrator dispatches proofreaders across four editorial lenses. Show how context isolation means a creator in UC-01 never sees a proofreader's findings from UC-02. | 20 min |
| Exercise | Given the elevator actor catalog from foundation lessons, students specify for Owner, Inspector, and Scheduler agents: (a) system prompt fragment that embodies the drive, (b) tool restrictions, (c) which invariants are advisory (prompt) vs. hard (hook), (d) model tier (Haiku/Sonnet/Opus). | 25 min |
| Debrief | Compare student answers. Focus on: do their system prompts express drives or tasks? Are tool restrictions aligned with single responsibility? Did they put safety invariants in hooks, not prompts? | 15 min |

**Total: 85 min**

### Source material

- `DOMAIN-IMPLEMENTATION-PRINCIPLES.md` -- all implementation principles
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- actor definitions with drives and tool assignments

---

## SWE03: The complete model

### Learning objectives

1. Describe the full artifact ecosystem and the relationships between artifacts.
2. Navigate the 5 design phases and explain why backtracking is correct.
3. Produce a use case catalog that serves as an entry point to a model.

### Key concepts

- **The artifact ecosystem.** Philosophy, template, individual use cases, actor catalog, shared invariants, use case catalog, domain contexts, domain events catalog, glossary. Each has a purpose, a relationship to other artifacts, and a point in the process where it typically emerges.
- **5 phases.** Establish principles, design individual use cases, consolidate, model the domain, refine. Phases are numbered for exposition, not for compliance. Backtracking is correct and expected.
- **Consolidation.** After several use cases exist, step back. Actor catalog gathers every actor into one document. Shared invariants extract repeated constraints. Use case catalog indexes everything.
- **Cross-references.** Every artifact links to relevant others. Domain events reference their bounded contexts. Use cases reference shared invariants. The catalog references everything. Broken references mean something was renamed without updating dependents.
- **The model is discovered, not constructed.** Each phase deepens understanding. Deeper understanding revises earlier assumptions. A use case designed in phase 2 may reveal a new principle for phase 1.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present the artifact ecosystem. Show the relationship map from DOMAIN-MODEL-ARTIFACTS.md. Explain when each artifact typically emerges and what triggers backtracking at each phase. | 15 min |
| Teach | Present the 5 phases. Emphasize that phase 2 will send you back to phase 1 repeatedly. The philosophy is not complete until the model is complete. | 10 min |
| Demonstrate | Walk through the wiki-agent USE-CASE-CATALOG.md as the entry point. Follow the links: catalog to use cases, use cases to domain contexts, domain contexts to domain events. Show how the bounded contexts table ties everything together. | 20 min |
| Exercise | Students design a USE-CASE-CATALOG.md for the elevator system covering: 3 use cases (e.g., Dispatch Elevator, Inspect Elevator, Optimize Schedule), 2 bounded contexts (e.g., Passenger Transport, Safety Compliance), and 3 domain events (e.g., ElevatorDispatched, InspectionCompleted, ScheduleOptimized). Include the bounded contexts table. | 25 min |
| Debrief | Compare student answers. Focus on: does the catalog serve as an entry point? Are use case titles verbs? Are domain events past-tense nouns? Does the bounded contexts table show which events belong where? Are cross-references present? | 15 min |

**Total: 85 min**

### Source material

- `DOMAIN-MODEL-ARTIFACTS.md` -- artifact types, relationships, emergence points
- `SYSTEM-DESIGN-PHASES.md` -- the 5 phases and backtracking
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- reference catalog
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- reference actor catalog
- `models/marklauter/github-wiki-manager/SHARED-INVARIANTS.md` -- reference shared invariants
