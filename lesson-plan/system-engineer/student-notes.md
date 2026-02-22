# System engineer track -- student notes

Self-contained reading material for SE01 through SE03. Each section covers the key ideas, walks through examples, and gives you an exercise prompt. You can read these notes before or after the lesson.

These lessons follow the 4 shared foundation lessons. You already know conditional goals, actors and drives, Socratic extraction, and use case anatomy. This track builds on those ideas to address what system engineers care about: boundaries, failure, and the coherence of the whole.

---

## SE01: System boundaries and integration

### The core idea

A bounded context is a region of the domain where a word has a specific meaning. It is not a module. It is not a service. It is not an organizational unit.

Two bounded contexts exist when the same term means different things in different areas of the domain.

This is the contradiction test: if you find the same word carrying different meaning in two places, you have found a boundary.

Contexts communicate through domain events -- meaningful state transitions that cross boundaries. At every crossing point, there is a protocol: a contract that defines the input spec, the output spec, and the format. No internal state crosses a boundary. Only the protocol does.

### The wiki-agent integration network

The wiki-agent model has 6 bounded contexts. Here is how they connect.

**DC-05 (Workspace Lifecycle) feeds everything.** Every operational context requires a provisioned workspace. The workspace config file (`workspace.config.md`) is the contract. It contains repo identity, source directory, wiki directory, audience, and tone. All other contexts read this config at startup.

**DC-02 (Editorial Review) publishes to DC-03 (Wiki Revision).** This is the richest integration in the model. Here is how it works:

1. UC-02 (Review Wiki Quality) dispatches proofreaders across 4 editorial lenses. Proofreaders find problems and produce findings.
2. The oversight orchestrator deduplicates findings against existing GitHub issues and files new issues. Each issue body conforms to the `documentation-issue.md` schema.
3. Each filed issue is a FindingFiled event -- a durable fact stored in GitHub.
4. UC-03 (Revise Wiki) reads those GitHub issues. The fulfillment orchestrator parses each issue body against the same schema, groups actionable issues by page, and dispatches correctors.

The GitHub issue body is the published language between DC-02 and DC-03. It is the protocol at the crossing point. DC-02 writes issues in this format. DC-03 reads issues in this format.

Neither context knows the other's internal state. They share only the protocol.

**DC-03 and DC-04 share a corrector protocol.** The corrector in DC-03 (Wiki Revision) receives a correction assignment: page, finding, recommendation, source reference. The corrector in DC-04 (Drift Detection) receives the same structure -- but the finding comes from a fact-checker assessment, not a GitHub issue.

The protocol is structurally compatible. The corrector is reusable. The contexts are separate.

This is where the contradiction test matters. A "correction" in DC-03 means applying a fix from a proofreader's finding via a GitHub issue. A "correction" in DC-04 means applying a fix from a fact-checker's assessment of source code drift. Same word. Different meaning. Different context.

### The elevator example

Think about the elevator system. Where do contradictions appear?

- "Transport" in the passenger context means moving a person between floors. "Transport" in the maintenance context might mean moving the empty car to a service position for inspection.
- "Available" in the passenger context means the elevator is ready to carry passengers. "Available" in the maintenance context means the elevator is free for scheduled inspection.
- "Request" in the passenger context means a floor call. "Request" in the building management context might mean a capacity allocation.

Each contradiction is a boundary. Each boundary needs a protocol.

### Try it

Draw the integration map for the elevator system.

1. Identify at least 3 bounded contexts. Use the contradiction test to find them.
2. For each context, name the domain events it publishes and the domain events it consumes.
3. Define the protocol at each crossing point: what data crosses the boundary, in what format?

Ask yourself: which crossing points have no protocol defined yet? That is where the model is incomplete.

### Further reading

- `.claude/modeling-contracts/principles/context-lens.md` -- bounded contexts and protocols at crossing points
- `.claude/modeling-contracts/principles/modeling-vocabulary.md` -- domain events
- `models/marklauter/github-wiki-manager/domains/` -- DC-01 through DC-06
- `models/marklauter/github-wiki-manager/domains/DOMAIN-EVENTS.md` -- all 7 published events
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- the bounded contexts table

---

## SE02: Invariants and resilience

### The core idea

Value conditions on the primary actor's goal predict failure modes. You do not need to look at the implementation.

If the Passenger values safety, you can derive what threatens safety. If the Passenger values promptness, you can derive what threatens promptness. The goal tells you what can go wrong.

Three concepts make this work:

**Invariants** are domain rules that hold continuously. They are not entry gates you check once. "Source repo is readonly" is not checked at the start and forgotten.

It must hold throughout the entire operation. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

**Obstacles** are threats to the goal, described in domain language. "Source code is unreachable" tells you what is at risk. "Exit code 128" tells you nothing useful. An obstacle names the value it threatens and describes what happens to the actor's goal.

**Recovery strategies** preserve what the actor values. When something goes wrong, the system does not simply stop. It degrades in a way that protects the actor's most important values. Options include partial completion (successful work remains), fallback paths (degrade gracefully), and user notification (explain what happened and what to do next).

### Value conditions predict failures

The Passenger's conditional goal is: be on a different floor -- safely, promptly, without trauma, intact.

Each value condition predicts a category of threat:

- **Safely** predicts threats to physical safety: mechanical failure, cable stress, brake failure, free-fall. The recovery must preserve safety above all else.

  Emergency brakes engage. The car stops at the nearest floor. The system does not try to complete the trip if safety is in question.

- **Promptly** predicts threats to timeliness: peak demand, mechanical delays, long queues. The recovery preserves timeliness where possible.

  The scheduler adjusts priority. The system communicates expected wait times. But promptness never overrides safety.

- **Without trauma** predicts threats to psychological comfort: power failure during transit (trapped in the dark), sudden stops, lack of information. The recovery preserves comfort.

  Emergency lighting activates. Communication opens to building staff. The system explains what is happening.

- **Intact** predicts threats to physical integrity: door malfunctions during boarding, entrapment. The recovery preserves integrity.

  Sensors detect obstruction. Doors reopen. The car does not move until doors are fully closed and clear.

Notice: you derived all of this from the goal, not from the implementation. A spec says "elevator must not free-fall." A value says "I want to be safe."

The spec is one implementation of the value. The value predicts entire categories of failure that no single spec can cover.

### UC-04: failure handling in practice

UC-04 (Sync Wiki with Source Changes) shows these principles in a real use case. Here is how it handles failure.

**The invariants constrain everything.** UC-04 has 8 invariants. Three matter most for resilience:

- Accuracy only -- no editorial changes. A fact-checker that flags a style problem has exceeded its mandate. A corrector that "improves" a sentence while fixing a fact has exceeded its mandate.
- Targeted edits, not rewrites. Correctors use surgical edits. The existing page structure, voice, and content are preserved.
- Unreachable sources are skipped, not guessed. When an external URL is unreachable, the fact-checker records it as unverifiable and moves on. It does not fabricate an answer.

**Fact-checker cannot reach an external source.** The fact-checker skips that verification and records the claim as unverifiable. The sync report's errata section surfaces the gap. The recovery preserves accuracy: it is better to leave an unverified claim in place than to guess wrong.

**One fact-checker crashes.** The pages it was responsible for are not checked. But assessments from successful fact-checkers proceed normally. Pages with drift are sent to correctors.

The report notes unchecked pages. The recovery is partial completion: everything that succeeded is preserved. Everything that failed is recorded.

**One corrector crashes.** Successfully applied corrections from other correctors remain on disk. The failed corrections are noted in the report.

The user retries to pick up uncorrected drift. Again, partial completion. The system does not roll back successful corrections to maintain an all-or-nothing illusion.

**The sync report as durable record.** The report captures everything: corrections applied, pages verified, claims skipped, failures encountered. Reports accumulate across runs. The user can track accuracy trends. This preserves the User's value of confidence: you may not have full coverage, but you know exactly what you have and what you do not.

Notice the pattern. Every recovery strategy preserves what the actor values most:
- Accuracy is preserved by skipping instead of guessing.
- Completed work is preserved by partial completion instead of rollback.
- Confidence is preserved by the durable report that captures exactly what happened.

### Try it

For the elevator system's "transport passenger" use case, derive 4 obstacles from the Passenger's value conditions.

For each obstacle:
1. Name the value condition it threatens (safely, promptly, without trauma, intact).
2. Describe the threat in domain language, not error codes.
3. Design a recovery strategy that preserves the threatened value.
4. Note any trade-offs: does the recovery sacrifice one value to preserve another?

### Further reading

- `.claude/modeling-contracts/principles/usecase-lens.md` -- invariants as continuous constraints, obstacles as threats to the goal
- `.claude/modeling-contracts/principles/actor-lens.md` -- value conditions drive system design
- `models/marklauter/github-wiki-manager/UC-04-sync-wiki-with-source-changes.md` -- invariants, goal obstacles, failure and success outcomes

---

## SE03: The complete domain model

### The core idea

A use case model is not a pile of documents. It is a connected graph of artifacts, each with a purpose, a relationship to the others, and a point in the process where it emerges. The model is discovered, not constructed. And when it is complete, a newcomer can understand the whole system by starting at one document and following references.

### The artifact ecosystem

Here are the artifacts that constitute a viable use case model, in rough order of emergence:

1. **Philosophy** (`PHILOSOPHY.md`). The constitution. Guiding principles that every other artifact must reflect. Short, opinionated, stable. Emerges first.

2. **Template** (`TEMPLATE.md`). The structural contract for individual use cases. Encodes philosophy into structure. Emerges early.

3. **Individual use cases** (`UC-{id}-{slug}.md`). The core of the model. Each describes one goal pursued by one primary actor. Designed one at a time through Socratic interviews.

   The first takes the longest because it establishes vocabulary. By the third, the domain language is settling.

4. **Actor catalog** (`ACTOR-CATALOG.md`). Consolidates every actor -- who they are, what drives them, where they appear. Includes the appearance matrix. Emerges after 2--3 use cases when actors start repeating.

5. **Shared invariants** (`SHARED-INVARIANTS.md`). Cross-cutting rules that apply to every use case. Extracted when the same constraint appears in two places. Emerges after 2--3 use cases.

6. **Use case catalog** (`USE-CASE-CATALOG.md`). The entry point. Frames the primary actor's goals, describes the domain, lists all use cases, provides the bounded contexts table. Starts simple after the first use case. Grows as the model matures.

7. **Domain contexts** (`domains/DC-{id}-{slug}.md`). Each bounded context gets its own file. Purpose, ubiquitous language, use cases, events produced and consumed, integration points. Emerges late -- after natural clustering becomes visible.

8. **Domain events catalog** (`domains/DOMAIN-EVENTS.md`). Every event that crosses a boundary or is user-visible. Producer, consumer, materialization, payload. Emerges late, alongside domain contexts.

9. **Glossary** (`GLOSSARY.md`). Every term with precise meaning. One-sentence entries. Grows throughout.

### The relationship map

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

Every arrow is a reference, not a dependency. Any artifact can be read standalone. But the model is richer when read as a whole.

### Navigation in practice

Here is how you navigate the wiki-agent model, starting from USE-CASE-CATALOG.md.

**Step 1: Start at USE-CASE-CATALOG.md.** You see the primary actor's goals (the User wants accurate, trustworthy wiki documentation). You see the domain (documentation accuracy -- the core problem is drift). You see 6 use cases listed with one-line summaries. You see the bounded contexts table with 6 contexts and 7 domain events.

**Step 2: Pick a bounded context.** Choose DC-02 (Editorial Review) from the table. Follow the link to `domains/DC-02-editorial-review.md`. You see the purpose (critique of existing content across four editorial lenses), the ubiquitous language (finding, severity, editorial lens, deduplication), the events produced (FindingFiled, WikiReviewed), and the integration points (publishes to DC-03, requires DC-05).

**Step 3: Follow an event.** Pick FindingFiled. Follow the link to `domains/DOMAIN-EVENTS.md`, entry DE-02. You see the producer (UC-02), the consumer (DC-03 Wiki Revision via UC-03), the materialization (GitHub issue with `documentation` label), and the payload (issue number, page, lens, severity, finding text, recommendation, source citation).

**Step 4: Follow the consumer.** Follow the link to UC-03 (Revise Wiki). You see the goal (apply recommended corrections so wiki content is fixed), the actors (fulfillment orchestrator, correctors), the scenario, the obstacles.

**Step 5: Follow an actor.** Follow the corrector link to `ACTOR-CATALOG.md`. You see the definition: drive is remediation, agent type is `wiki-writer` (reused), appears in UC-03 and UC-04. The appearance matrix confirms this.

Every reference resolved. Every link led to a real artifact with real content. This is cross-reference integrity.

### Cross-reference integrity

Integrity means:
- Every domain event referenced in a use case exists in DOMAIN-EVENTS.md.
- Every bounded context referenced has a file in `domains/`.
- Every actor referenced appears in ACTOR-CATALOG.md.
- Every shared invariant referenced exists in SHARED-INVARIANTS.md.
- The appearance matrix in ACTOR-CATALOG.md matches the actors that actually appear in each use case.

When a reference breaks -- someone renamed an actor in one place but not the catalog, or added an event to a use case but not the event catalog -- the model has a dead link. The fix is simple: update the dependents. The discipline is: when you change an artifact, trace every reference and update them all.

### Consolidation

Consolidation is how the model goes from a collection of individual use cases to a coherent whole. It is not a one-time cleanup. It happens continuously.

- The first time an invariant appears in two use cases, you extract it to SHARED-INVARIANTS.md.
- The first time an actor appears under different names in different use cases, you settle the name in ACTOR-CATALOG.md.
- The first time you notice natural clustering (these 2 use cases share vocabulary and domain rules, those 3 share different vocabulary), you have bounded contexts waiting to be formalized.

The wiki-agent model consolidated actors from 4 editorial use cases into an actor catalog with 3 abstract families (orchestrators, assessors, content mutators) and 11 concrete actors. The appearance matrix shows at a glance which actors participate in which use cases. You can spot coverage gaps (is any use case missing an orchestrator?) and reuse opportunities (the corrector appears in both UC-03 and UC-04).

### The model is discovered, not constructed

Everything traces back to the derivation chain:

```
Primary actor
  -> conditional goal (desired state + value conditions)
    -> value conditions meet reality -> tensions
      -> tensions spawn supporting actors (each with a drive)
        -> system design (invariants, use cases, bounded contexts)
```

You do not design 6 bounded contexts and then fill them with use cases. You design use cases one at a time.

Boundaries emerge from contradictions. Actors emerge from tensions. Invariants emerge from repetition. The artifacts formalize what was already implicit.

This means the model is never wrong in a permanent way. When consolidation reveals an inconsistency -- two use cases describe the same actor with different drives, or a shared invariant contradicts a local one -- the inconsistency is a discovery opportunity. Fix it, update the dependents, and the model becomes more coherent.

### Try it

Using the actors, use cases, and contexts from SE01 and SE02, write an ACTOR-CATALOG.md for the elevator system.

Include:
1. Each actor (primary and supporting) with their goal or drive.
2. For supporting actors, the tension that spawned them (which value condition on which primary actor's goal).
3. The use cases each actor appears in.
4. An appearance matrix (rows = actors, columns = use cases, marks = participation).

Check your work: does every actor referenced in your SE01 integration map and SE02 obstacle list appear in the catalog? Does every row in the matrix correspond to a defined actor? If not, you have found a gap.

### Further reading

- `.claude/modeling-contracts/DOMAIN-MODEL-ARTIFACTS.md` -- artifact definitions, relationship map, emergence timing
- `.claude/modeling-contracts/SYSTEM-DESIGN-PHASES.md` -- the 5 phases of model design
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- entry point for navigation
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- actor definitions and appearance matrix
- `models/marklauter/github-wiki-manager/domains/DOMAIN-EVENTS.md` -- published events
- `models/marklauter/github-wiki-manager/SHARED-INVARIANTS.md` -- cross-cutting invariants
