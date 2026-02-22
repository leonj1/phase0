# System engineer track (SE01--SE03)

Three lessons for system engineers on modeling boundaries, failure, and the complete domain model. Follows four shared foundation lessons covering conditional goals, actors/drives, Socratic extraction, and use case anatomy.

Running example: the elevator system (Passenger wants to be on a different floor -- safely, promptly, without trauma, intact; Owner has economic drive; Inspector spawned by safety tension; Scheduler spawned by promptness tension meeting capacity).

Case study: the wiki-agent model (6 use cases, 6 bounded contexts, 7 domain events).

---

## SE01: System boundaries and integration

### Learning objectives

1. Identify bounded contexts by finding contradictions -- the same word with different meanings in different parts of the domain.
2. Trace the flow of domain events across context boundaries and name the protocol at each crossing point.
3. Draw an integration map showing which contexts publish events, which consume them, and what connects them.

### Key concepts

- **Bounded context.** A region of the domain where a word has a specific meaning. Not an organizational unit, not a module, not a service. Two contexts exist when the same term means different things in each. "Correction" in Wiki Revision means applying a fix from a GitHub issue. "Correction" in Drift Detection means applying a fix from a fact-checker assessment. Same word, different context.

- **Domain event.** A meaningful state transition that crosses a bounded context boundary or is exposed to the user as an observable outcome. Named as past-tense nouns: WikiPopulated, FindingFiled, WikiSynced. Domain events are the published language between contexts.

- **Protocol.** The contract at every crossing point between contexts. Defines input spec, output spec, and format. In the wiki-agent model, the GitHub issue body conforming to the `documentation-issue.md` schema is the protocol between Editorial Review (DC-02) and Wiki Revision (DC-03). No internal state crosses the boundary -- only the protocol.

- **Contradiction test.** If the same word means different things in two areas of the domain, you have found a boundary. Contradictions reveal contexts; contexts do not create contradictions.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present bounded contexts, domain events, and protocols. Emphasize: contexts are linguistic regions, not architectural boxes. Use the contradiction test to find boundaries. | 15 |
| Demonstrate | Walk through the wiki-agent integration network. Show DC-05 (Workspace Lifecycle) feeding all operational contexts. Show DC-02 (Editorial Review) publishing FindingFiled, consumed by DC-03 (Wiki Revision) via GitHub Issues. Show the issue body as the published language -- the protocol between these two contexts. Show the correction assignment protocol shared between DC-03 and DC-04. | 15 |
| Exercise | Draw the integration map for the elevator system. Identify at least 3 bounded contexts. For each context, name the domain events it publishes and consumes. Define the protocol at each crossing point. | 20 |
| Debrief | Compare integration maps. Discuss where contradictions appeared. Ask: which crossing points have no protocol defined yet? What breaks when a protocol is missing? | 10 |

**Total: 60 minutes**

### Source material

- `.claude/modeling-contracts/principles/context-lens.md` -- bounded contexts over shared models, protocols at crossing points
- `.claude/modeling-contracts/principles/modeling-vocabulary.md` -- domain events
- `models/marklauter/github-wiki-manager/domains/` -- all 6 domain context files (DC-01 through DC-06)
- `models/marklauter/github-wiki-manager/domains/DOMAIN-EVENTS.md` -- the 7 published events
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- bounded contexts table

---

## SE02: Invariants and resilience

### Learning objectives

1. Express domain rules as invariants (rules that hold continuously) rather than preconditions (entry gates checked once).
2. Derive failure modes from value conditions on the primary actor's goal, without looking at the implementation.
3. Design recovery strategies that preserve what the actor values -- partial completion, fallback paths, user notification.

### Key concepts

- **Invariant.** A domain rule that must hold continuously -- before, during, and after execution. Not an entry gate you check once. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

- **Obstacle.** A threat to the goal, not an error code. "Source code is unreachable" tells you what is at risk. "Exit code 128" tells you nothing about what to do next. Obstacles are framed as goal threats with recovery strategies.

- **Value-condition-to-failure derivation.** Each value condition on the primary actor's goal predicts a category of failure. If the Passenger values safety, you can derive what threatens safety (mechanical failure, power failure, overcrowding) without examining the implementation. The goal tells you what can go wrong.

- **Recovery strategy.** How the system preserves what the actor values when an obstacle is encountered. Options include partial completion (successful work remains), fallback paths (degrade gracefully), and user notification (explain what happened and what to do next).

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present invariants vs. preconditions. Show how value conditions predict failure modes. Introduce obstacles as goal threats, not error codes. Introduce recovery strategies that preserve actor values. | 15 |
| Demonstrate | Walk through UC-04 (Sync Wiki with Source Changes). Show the invariants -- accuracy only, no new pages, targeted edits not rewrites. Show the obstacle handling: fact-checker can't reach external source (skip, don't guess -- invariant: unreachable sources are skipped, not guessed); corrector partially fails (successful corrections remain on disk); sync report as durable record of what happened. Show how each recovery strategy preserves what the User values: confidence in accuracy, no surprises, actionable information. | 15 |
| Exercise | For the elevator system's "transport passenger" use case, derive 4 obstacles from the Passenger's value conditions (safety, promptness, without trauma, intact). For each obstacle: name the value condition it threatens, describe the threat, and design a recovery strategy that preserves what the Passenger values. | 20 |
| Debrief | Compare obstacle sets. Ask: did anyone derive the same failure from different value conditions? Which recovery strategies sacrifice one value to preserve another? What happens when the recovery strategy itself fails? | 10 |

**Total: 60 minutes**

### Source material

- `.claude/modeling-contracts/principles/usecase-lens.md` -- invariants as continuous constraints, obstacles as threats to the goal
- `.claude/modeling-contracts/principles/actor-lens.md` -- value conditions drive system design
- `models/marklauter/github-wiki-manager/UC-04-sync-wiki-with-source-changes.md` -- invariants, goal obstacles, failure outcome, recovery strategies
- `models/marklauter/github-wiki-manager/SHARED-INVARIANTS.md` -- cross-cutting invariants

---

## SE03: The complete domain model

### Learning objectives

1. Describe the artifact ecosystem -- what each artifact is, when it emerges, and how it relates to the others.
2. Navigate a complete model starting from USE-CASE-CATALOG.md and following references through use cases, domain contexts, events, and actors.
3. Verify cross-reference integrity -- every reference resolves, every actor appears in the matrix, no orphans.

### Key concepts

- **Artifact ecosystem.** The set of documents that constitute a viable use case model: philosophy, template, individual use cases, actor catalog, shared invariants, use case catalog, domain contexts, domain events catalog, and glossary. Each has a purpose, a relationship to other artifacts, and a point in the process where it typically emerges.

- **Emergence timing.** Artifacts do not appear all at once. Philosophy and template come first. Individual use cases are designed one at a time. Shared invariants and the actor catalog emerge after 2--3 use cases when patterns repeat. Domain contexts and events formalize late, after natural clustering becomes visible. The model is discovered, not constructed.

- **Navigation structure.** USE-CASE-CATALOG.md is the entry point. From there, you follow references to individual use cases, which reference domain contexts, domain events, actors, and shared invariants. A newcomer understands the whole system by starting at the catalog and following links.

- **Cross-reference integrity.** Every domain event referenced in a use case exists in DOMAIN-EVENTS.md. Every bounded context referenced has a file. Every actor appears in the catalog. Every shared invariant referenced exists in SHARED-INVARIANTS.md. Broken references mean something was renamed or removed without updating dependents.

- **Consolidation.** The process of extracting shared actors, shared invariants, and catalogs from individual use cases. Consolidation is DRY applied to domain models -- no actor defined in two places, no invariant restated across use cases, no protocol described differently by producer and consumer.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Present the artifact ecosystem using the relationship map from DOMAIN-MODEL-ARTIFACTS.md. Show emergence timing -- what comes first, what comes late, what triggers each artifact. Emphasize: the model is discovered, not constructed. | 15 |
| Demonstrate | Full wiki-agent model walkthrough. Start at USE-CASE-CATALOG.md. Follow the bounded contexts table to DC-02 (Editorial Review). From DC-02, follow the FindingFiled event to DOMAIN-EVENTS.md. From the event, follow the consumer reference to DC-03 (Wiki Revision) and UC-03. From UC-03, follow the corrector to ACTOR-CATALOG.md. Show how every reference resolves. Show the appearance matrix. | 15 |
| Exercise | Given the elevator system's actors, use cases, and contexts from the previous two exercises, write an ACTOR-CATALOG.md. Include: each actor (primary and supporting) with their goal or drive, the use cases they appear in, and an appearance matrix. Verify that every actor referenced in your use cases from SE01 and SE02 appears in the catalog. | 20 |
| Debrief | Compare catalogs. Ask: did anyone discover an actor they had been using implicitly but never named? Did anyone find a reference that didn't resolve? What does a broken reference tell you about the model? | 10 |

**Total: 60 minutes**

### Source material

- `.claude/modeling-contracts/DOMAIN-MODEL-ARTIFACTS.md` -- artifact definitions, relationship map, emergence timing
- `.claude/modeling-contracts/SYSTEM-DESIGN-PHASES.md` -- how the design process unfolds across 5 phases
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- entry point for the walkthrough
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- appearance matrix, actor definitions
- `models/marklauter/github-wiki-manager/domains/DOMAIN-EVENTS.md` -- published event catalog
- `models/marklauter/github-wiki-manager/SHARED-INVARIANTS.md` -- cross-cutting invariants
