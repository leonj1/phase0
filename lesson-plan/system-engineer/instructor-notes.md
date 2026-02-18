# Instructor notes -- system engineer track

Lesson-by-lesson guidance for instructors. Each lesson includes the aha moment to aim for, common misconceptions with explanations, how to handle the case study, exercise guidance, and the transition to the next lesson.

---

## SE01: System boundaries and integration

### Aha moment

Bounded contexts are not organizational units, not modules, not services. They are regions where a word has a specific meaning. The moment students grasp this is when you show "correction" meaning two different things:

- In Wiki Revision (DC-03), a "correction" is applying a fix from a GitHub issue -- a proofreader found something wrong, and the corrector applies the recommendation.
- In Drift Detection (DC-04), a "correction" is applying a fix from a fact-checker assessment -- the source code changed, and the corrector updates the wiki.

Same word. Same corrector actor. Different context. The corrector is reusable because the protocol is structurally compatible -- but the contexts are separate because the word "correction" carries different meaning in each.

If students are nodding but not quite there, ask: "If I say 'the correction failed,' which correction? What went wrong?" The answer depends entirely on which context you are in.

### Common misconceptions

1. **"Bounded contexts are microservices."** No. A bounded context is a linguistic boundary, not a deployment boundary. Two contexts might run in the same process. They might be two sections of the same document. The boundary is semantic -- the same word means different things -- not architectural. Push back when students draw box-and-arrow diagrams before they have found contradictions.

2. **"Domain events are API calls."** No. A domain event is a fact -- something happened. FindingFiled means a GitHub issue now exists. WikiSynced means the sync report is on disk. The event is the durable record, not the call that produced it. In the wiki-agent model, events materialize as files and issues, not as HTTP requests. Ask students: "If the receiving system is down when the event is produced, does the event disappear?" If the answer is no, it is a durable fact, not an API call.

3. **"You design bounded contexts top-down."** No. Contexts emerge from contradictions discovered during use case design. You do not sit down and say "we need 6 contexts." You design use cases, notice that the same word means different things in different use cases, and the boundaries appear. In the wiki-agent model, contexts were not formalized until phase 4 -- after 4 use cases had been designed. The tool is the contradiction test, not an architecture diagram.

### Case study guidance

Walk through the wiki-agent integration network in this order:

1. Start with DC-05 (Workspace Lifecycle). Show that it feeds every operational context. Every use case begins by resolving a workspace. This is the foundation -- not a bounded context boundary in the interesting sense, but the prerequisite that makes everything else possible.

2. Move to DC-02 and DC-03. This is the richest integration example. DC-02 (Editorial Review) publishes FindingFiled events. DC-03 (Wiki Revision) consumes them. The crossing point is the GitHub issue body conforming to the `documentation-issue.md` schema. The issue body is the published language. No internal state crosses the boundary.

3. Show the DC-03 / DC-04 corrector reuse. Both contexts use a structurally compatible correction assignment protocol. The corrector does not know which context dispatched it. This is protocol-based integration -- shared structure, independent contexts.

4. Point out the gap between DC-02 and DC-04. If DC-04 independently corrects an accuracy issue that DC-02 filed, the GitHub issue becomes stale. This is an accepted trade-off. Ask students whether they would design it differently and why.

### Exercise guidance

**What good answers look like:**

Students should identify at least 3 bounded contexts for the elevator system. Reasonable contexts include:

- Passenger transport (the core domain -- getting people between floors)
- Maintenance / inspection (ensuring the system is safe to operate)
- Scheduling / dispatch (deciding which elevator serves which request)
- Building management (capacity planning, floor assignments)

For each context, they should name at least one domain event. Examples:
- FloorReached (Passenger transport publishes; Scheduling consumes to update availability)
- InspectionCompleted (Maintenance publishes; Passenger transport consumes to determine if the elevator can operate)
- RequestQueued (Scheduling publishes internally or is consumed by dispatch)

For protocols, look for specificity. "The inspection report" is too vague. "A report containing: elevator ID, inspection date, pass/fail status, deficiency list, next inspection due" is a protocol.

**How to debrief:**

Ask: "Where did contradictions appear?" Students should have found at least one word that means different things. "Transport" in the passenger context means moving a person. "Transport" in the maintenance context might mean moving the elevator car to a service position. "Available" means ready for passengers in one context and ready for inspection in another.

Ask: "Which crossing points have no protocol defined?" This is where the model is incomplete. A missing protocol is not a mistake -- it is a discovery opportunity.

### Transition to SE02

Close by noting that you now know where the boundaries are and what crosses them. The next question is: what goes wrong at those boundaries? And more broadly, what threatens the goals that the system exists to serve? That is SE02.

---

## SE02: Invariants and resilience

### Aha moment

Value conditions predict failure modes. You do not need to look at the implementation to know what can go wrong. If the Passenger values safety, you can derive what threatens safety: mechanical failure, power failure, overcrowding, entrapment. If the Passenger values promptness, you can derive what threatens promptness: peak demand, mechanical delay, long queue. The goal tells you what can go wrong. The implementation tells you how to detect it.

The aha lands when a student derives an obstacle purely from a value condition and then realizes the recovery strategy must preserve that same value. Safety is threatened by free-fall. The recovery strategy (emergency brakes, redundant cables) preserves safety. If your recovery strategy for a safety threat sacrifices safety, you have a contradiction.

### Common misconceptions

1. **"Invariants are preconditions you check at the start."** No. An invariant holds continuously -- before, during, and after execution. "Source repo is readonly" is not checked once at the start. It is a rule that must hold throughout the entire operation. An actor that writes to the source repo mid-scenario has violated the invariant, even if it cleans up afterward. Ask students: "If the invariant is only checked at the door, what happens to violations that occur inside?"

2. **"Obstacles are exceptions with try/catch blocks."** No. An obstacle is a threat to the goal, described in domain language. "Source code is unreachable" tells you what is at risk -- the sync cannot verify claims. "ConnectionTimeoutException" tells you nothing about what the actor should do. Frame obstacles as threats, not errors. Ask students: "If I told the Passenger 'error code 7,' would they know what to do? If I told them 'the elevator cannot verify it is safe to move,' they would know to wait or take the stairs."

3. **"Recovery means rollback."** Not always, and often not preferably. In UC-04, when a corrector fails, successful corrections from other correctors remain on disk. The recovery strategy is partial completion, not rollback. The user gets the value of everything that succeeded. Rollback would destroy completed work to maintain an all-or-nothing illusion. Ask students: "Would the Passenger prefer that three of four floors get elevator service, or that all four floors lose service because one elevator is broken?"

### Case study guidance

Walk through UC-04's failure handling in this order:

1. **Show the invariants first.** Accuracy only -- no editorial changes. No new pages. Targeted edits, not rewrites. Unreachable sources are skipped, not guessed. These invariants constrain the recovery space. A recovery strategy that violates an invariant is not valid.

2. **Show the fact-checker failure path (step 7a).** One fact-checker crashes. The pages it was responsible for are not checked. But pages with successful assessments proceed. The report notes which pages were not covered. This is partial completion -- the system does not stop because one agent failed.

3. **Show the unreachable source path (step 7b / invariant).** When a fact-checker cannot reach an external URL, it records the claim as unverifiable and moves on. It does not guess. This preserves accuracy (guessing would violate the accuracy-only invariant). The report's errata section surfaces the gap. The user decides what to do.

4. **Show the corrector failure path (step 9a).** A corrector crashes. Successfully applied corrections from other correctors remain on disk. The report notes which pages failed. The user retries to pick up uncorrected drift.

5. **Show the sync report as durable record.** The report captures everything that happened -- corrections, verifications, skips, failures. This supports trend analysis across runs. The report is how the system preserves the User's value of confidence: you may not have full coverage, but you know exactly what you have.

### Exercise guidance

**What good answers look like:**

Students should derive 4 obstacles from the Passenger's 4 value conditions. Each obstacle names the value it threatens:

| Value condition | Obstacle | Recovery strategy |
|----------------|----------|-------------------|
| Safely | Mechanical failure (e.g., cable stress, brake wear) | Redundant cables, emergency brakes engage automatically, car stops at nearest floor |
| Promptly | Excessive demand exceeds capacity (peak hours, event traffic) | Scheduler prioritizes by wait time, communicates expected wait, overflow to adjacent elevators |
| Without trauma | Power failure during transit (trapped in dark, unknown state) | Emergency lighting activates, communication link to building staff, automatic descent to nearest floor on backup power |
| Intact (physically) | Door malfunction during boarding (doors close on passenger) | Sensors detect obstruction, doors reopen, system will not move until doors are fully closed and clear |

The key is that each obstacle traces back to a specific value condition. Students who write generic obstacles ("something breaks") have not done the derivation. Push them: "Which value does this threaten? What does the Passenger lose if this happens?"

For recovery strategies, look for: (a) the strategy preserves the threatened value, and (b) the strategy acknowledges trade-offs. Emergency brakes preserve safety but sacrifice promptness. That trade-off is acceptable because safety outranks promptness in the Passenger's value hierarchy.

**How to debrief:**

Ask: "Did anyone derive the same failure from two different value conditions?" This is common. Power failure threatens both safety and comfort. The recovery strategy must address both -- emergency brakes for safety, emergency lighting and communication for comfort. This reveals that recovery strategies are multi-dimensional.

Ask: "Which recovery strategies sacrifice one value to preserve another?" All of them do, at some level. The question is whether the trade-off is acceptable. Safety almost always outranks promptness. But does promptness outrank comfort? These are design decisions, and the model should make them explicit.

### Transition to SE03

Close by noting that you now have boundaries (SE01) and resilience (SE02). Individual use cases are well-designed. But a system is not a collection of well-designed parts -- it is the relationships between them. SE03 is about seeing the whole: the artifact ecosystem, the navigation structure, and the integrity of cross-references.

---

## SE03: The complete domain model

### Aha moment

The navigation structure lets a newcomer understand the whole system by starting at USE-CASE-CATALOG.md and following references. Every link resolves. Every actor in the catalog appears in at least one use case. Every domain event has a producer and a consumer (or is user-facing). Cross-reference integrity means no dead links and no orphaned actors.

The aha lands when you demonstrate navigation live. Start at USE-CASE-CATALOG.md. Pick a bounded context from the table. Follow the link to the DC file. Pick a domain event from the DC file. Follow the link to DOMAIN-EVENTS.md. Pick a consumer from the event. Follow the link to the consuming use case. Pick an actor from the use case. Follow the link to ACTOR-CATALOG.md. Every reference resolves. The model is a connected graph, not a pile of documents.

Then break it. Show what happens if you rename an actor in one use case but not the catalog. Show what happens if you add a domain event to a use case but not DOMAIN-EVENTS.md. The broken reference is immediately visible. That is the value of cross-reference integrity.

### Common misconceptions

1. **"You build the model top-down from the catalog."** No. You discover the model bottom-up from Socratic interviews. Individual use cases come first. The catalog, actor catalog, shared invariants, domain contexts, and event catalog are all consolidation artifacts -- they emerge after enough use cases exist to reveal patterns. USE-CASE-CATALOG.md is the last artifact to become complete, not the first to be designed. Ask students: "If you write the catalog before the use cases, what are you indexing?"

2. **"Consolidation is a one-time cleanup phase."** No. Consolidation happens continuously. The first time an invariant appears in two use cases, you extract it to SHARED-INVARIANTS.md. The first time an actor appears under different names, you settle the name in ACTOR-CATALOG.md. Phase 3 (consolidation) in SYSTEM-DESIGN-PHASES.md is a tendency, not a gate. Backtracking is the process, not an exception to it.

3. **"More artifacts means a better model."** No. Each artifact exists because it serves a specific purpose. The philosophy document is short and stable. The glossary has one-sentence entries. If a design conversation document is longer than all the use cases combined, something has gone wrong. The test is: does a newcomer need this artifact to understand the system? If not, it is noise.

### Case study guidance

Walk through the full wiki-agent model in navigation order:

1. **Start at USE-CASE-CATALOG.md.** Read the primary actor's goals. Read the domain description. Show the use case list with one-line summaries. Show the bounded contexts table. This is the entry point for everything.

2. **Follow DC-02 (Editorial Review) from the table.** Read the purpose, ubiquitous language, domain events produced (FindingFiled, WikiReviewed), and integration points. Point out that DC-02 publishes to DC-03.

3. **Follow FindingFiled to DOMAIN-EVENTS.md.** Read the event definition: producer (UC-02), consumer (DC-03 via UC-03), materialization (GitHub issue with `documentation` label). Point out the payload fields.

4. **Follow the consumer to UC-03 (Revise Wiki).** Show how it consumes FindingFiled events by reading GitHub issues. Show the corrector's role.

5. **Follow the corrector to ACTOR-CATALOG.md.** Read the corrector definition: drive is remediation, appears in UC-03 and UC-04, reusable because the protocol is structurally compatible. Show the appearance matrix.

6. **Point out the relationship map from DOMAIN-MODEL-ARTIFACTS.md.** The map shows how every artifact references every other. Philosophy encodes into template. Template structures use cases. Use cases reference shared invariants, domain contexts, and events. Catalogs consolidate.

7. **Point out emergence timing.** Philosophy and template come first. Use cases come next. Shared invariants and actor catalog emerge after 2--3 use cases. Domain contexts and events formalize late. The glossary grows throughout. This is not a build plan -- it is how understanding deepens.

### Exercise guidance

**What good answers look like:**

Students write an ACTOR-CATALOG.md for the elevator system using actors from SE01 and SE02. A good catalog includes:

- **Passenger** (primary actor): goal is to be on a different floor -- safely, promptly, without trauma, intact. Appears in all transport use cases.
- **Owner** (supporting actor): drive is economic -- minimize maintenance cost. Appears in maintenance/inspection use cases.
- **Inspector** (supporting actor): drive is public safety -- spawned by tension between Owner's cost-minimization and Passenger's safety value. Appears in inspection use cases.
- **Scheduler** (supporting actor): drive is efficiency -- spawned by tension between Passenger's promptness value and building capacity. Appears in dispatch/scheduling use cases.

The appearance matrix should have rows for each actor and columns for each use case identified in SE01 and SE02. Every actor that appears in a use case should have a mark. Every actor with a mark should have a definition above.

Look for:
- Every actor has either a goal (primary) or a drive (supporting)
- Every supporting actor's drive traces back to a tension on the primary actor's goal
- The matrix has no orphan actors (defined but never appearing) and no phantom actors (appearing but never defined)

**How to debrief:**

Ask: "Did anyone discover an actor they had been using implicitly but never named?" This happens frequently. The "door sensor" might have been treated as a mechanical thing, but if it makes decisions about when to reopen, it might be an actor with a drive (safety). Or it might be a sub-system with no drive. The distinction matters.

Ask: "Did anyone find a reference that didn't resolve?" This is the cross-reference integrity check. If an obstacle from SE02 mentions an actor that is not in the catalog, the model has a broken reference. This is normal at this stage -- the point is to see the gap and know how to fix it.

Ask: "What does the appearance matrix tell you that the individual use cases do not?" The matrix shows coverage and reuse at a glance. You can see which actors are overloaded (appearing everywhere) and which are specialized (appearing once). You can see which use cases have many actors (complex coordination) and which have few (simple operations).

### Closing the track

End by returning to the derivation chain from the foundation lessons:

```
Primary actor
  -> conditional goal (desired state + value conditions)
    -> value conditions meet reality -> tensions
      -> tensions spawn supporting actors (each with a drive)
        -> system design (invariants, use cases, bounded contexts)
```

SE01 showed how system design produces bounded contexts and integration protocols. SE02 showed how value conditions produce invariants and obstacles. SE03 showed how the whole model fits together in a navigable, cross-referenced artifact ecosystem.

The model is discovered, not constructed. Every artifact traces back to the primary actor's conditional goal. If it does not trace back, it should not exist.
