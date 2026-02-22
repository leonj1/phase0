# Foundation lessons — student notes

Reading material for lessons F01 through F04. Each section is self-contained. You can read ahead or revisit after the workshop.

---

## F01: Goals, not tasks

### The core idea

A goal is a desired end state. A task is a path to get there. Most requirements are tasks disguised as goals.

Consider an elevator. What does the passenger want?

- **Task version:** "Ride the elevator to floor 5."
- **Goal version:** "Be on floor 5."

The difference matters. "Ride the elevator" prescribes a solution — it says *how*. "Be on floor 5" describes a desired state — it says *where*. If a genie could teleport the passenger, the goal is satisfied. The task is not — because nobody rode anything.

### The gift test

Apply this test to any goal statement: if a shortcut could satisfy it, would the actor care that the shortcut skipped the described action?

- "I want to have a guitar." → If someone gifts you the guitar, are you satisfied? Yes. This is a goal.
- "I want to buy a guitar." → If someone gifts you the guitar, do you care that you didn't buy it? No. This was a task disguised as a goal. The goal was *having*, not *buying*.

If your goal statement would be satisfied by skipping the action it describes, you wrote a task.

### Value conditions

"Be on floor 5" is the desired state, but it is not the whole goal. The passenger also values their physical integrity. They value their time. They value their psychological comfort.

The full goal: **be on a different floor — safely, promptly, without trauma, with all my limbs.**

These conditions are not acceptance criteria bolted on by an engineer. They are what the actor *values*. A passenger who reaches floor 5 missing an arm did not achieve their goal — because physical integrity was part of what they valued.

### Values vs. specs

A spec says "elevator must not free-fall." A value says "I don't want to lose my limbs."

The spec is one implementation of the value. You can satisfy the value in ways the spec never imagined. Designing from values keeps the solution space open. Designing from specs closes it prematurely.

The value conditions are where the entire system design comes from. "Floor 5" tells you nothing about system design. The values tell you everything.

### The vocabulary

- **Conditional goal** — a desired end state plus value conditions. Defined as a value statement.
- **Value conditions** — what the actor values about being in the desired state.
- **Gift test** — if a shortcut satisfies it, you wrote a task, not a goal.

### Try it

Rewrite each task statement as a goal. Then identify 2-3 value conditions for each.

1. "Process the customer's payment."
2. "Send the notification email."
3. "Deploy the application to production."
4. "Run the backup script."
5. "Authenticate the user."

For each, ask: what state does the actor want to be in? What do they value about being in that state?

### Further reading

- actor-lens.md, "Goals are conditional" section — the full treatment of conditional goals, the gift test, and why value conditions drive system design.
- VISION.md, "Conditional Goals: The Foundational Concept" — the elevator derivation in full.

---

## F02: Actors and drives

### The core idea

A **primary actor** has a goal — a desired end state the system exists to serve. A **supporting actor** has a drive — a reason to participate, born from tensions between the primary actor's value conditions and reality.

The system exists to serve the primary actor. Supporting actors exist because a single actor's drive cannot serve all the concerns a goal creates.

### The elevator derivation

Start with the Passenger — the primary actor. Their conditional goal: be on a different floor — safely, promptly, without trauma, intact.

Now watch what happens when each value condition meets reality:

**"Safely"** — elevators are mechanical systems that can fail. They cost money to maintain. Someone must own them. The **Owner** is a supporting actor with an economic drive: minimize maintenance cost.

But the Owner's economic drive creates a tension with the Passenger's safety value. An owner optimizing for cost alone might defer maintenance. This tension *demands* resolution by a party whose drive is public welfare. The **Inspector** is spawned — a supporting actor whose drive is public safety.

**"Promptly"** — a building has many passengers and limited elevators. Capacity is finite. This tension spawns the **Scheduler** — a supporting actor whose drive is efficiency: optimize throughput so passengers reach their floors without excessive waiting.

### The derivation chain

Everything traces back to the primary actor's value conditions:

```
Primary actor (Passenger)
  → conditional goal (be on a different floor — safely, promptly, ...)
    → value conditions meet reality → tensions
      → tensions spawn supporting actors (Owner, Inspector, Scheduler)
        → system design (invariants, use cases, bounded contexts)
```

### Genealogy

Every supporting actor has a genealogy — you can trace why they exist back to a specific value condition on a specific primary actor's goal.

- Inspector → exists because of the tension between Owner's economic drive and Passenger's *safety* value
- Scheduler → exists because Passenger's *promptness* value collides with building capacity
- Owner → exists because elevators cost money (economic reality meeting the need for a maintained system)

If you cannot trace an actor's genealogy, the actor does not belong in the model.

### Single responsibility

An actor has one drive. A Creator's drive is production. A Proofreader's drive is critique. These must be different actors.

Why? An actor with both drives will compromise between them. It will produce content that is "good enough" rather than content that is excellent and then separately verified. Two actors with opposing drives produce better outcomes than one actor trying to balance competing concerns.

This is not about malice. The Owner is not trying to hurt passengers. But a single drive cannot serve competing concerns. Separation of actors is the structural answer to conflicts of interest.

### The vocabulary

- **Primary actor** — has a conditional goal. The system exists to serve them.
- **Supporting actor** — has a drive. Born from tensions.
- **Drive** — a reason to participate. What the actor optimizes for — and therefore where it falls short.
- **Tension** — a value condition colliding with the forces of reality.
- **Genealogy** — every supporting actor traces back to a value condition on a primary actor's goal.
- **Single responsibility** — one drive per actor. Separate judgment from execution.

### Try it

Given the elevator Passenger's value conditions (safely, promptly, without trauma, intact), derive the full actor network.

For each supporting actor:
1. Name them.
2. State their drive.
3. Trace which value condition (or tension between value conditions and reality) spawned them.

Test each with: "What tension demands this actor, and what drive resolves it?"

### Further reading

- modeling-vocabulary.md, "Primary actors have goals; supporting actors have drives" — the shared vocabulary for goals and drives.
- actor-lens.md, "Goal conditions create tensions; tensions spawn supporting actors" through "Goal conflicts spawn actors" — tension-to-actor genealogy.
- VISION.md, "The Entry Point: Actors and Goals, From First Principles" — includes the complete elevator derivation table and chain.

---

## F03: Socratic extraction

### The core idea

Domain experts know more than they can articulate unprompted. Asking "tell me everything about your system" produces a fraction of what targeted questioning extracts.

The Socratic method works because:
- It draws out knowledge the expert has but has not structured.
- Contradictions between experts reveal real boundaries.
- The why-chain prevents the facilitator from projecting their model onto the domain.
- Noun refinement produces unambiguous vocabulary.

### The four rounds

Discovery follows a natural pattern — the same pattern a facilitator uses at a whiteboard with domain experts.

**Round 1: "What is this thing?"**

Ask: "What problem are you trying to solve?" Not "what system do you want" — what *problem*. The answers are messy, overlapping, contradictory. That is expected.

The facilitator keeps asking *why* until the group converges on something like a system boundary.

**Round 2: "Who touches this?"**

Ask: "Who interacts with this?" The first answers are sloppy. "The customer" might be three different actors with conflicting goals. This is where noun refinement happens.

**Round 3: "What goes wrong?"**

Ask: "What keeps you up at night?" The answers reveal where value conditions collide with reality. Each collision is a tension. Each tension points toward a supporting actor or a bounded context boundary.

**Round 4: Use cases emerge naturally**

By now you have primary actors with conditional goals, supporting actors with drives, tensions at boundaries, and a rough sense of the system's shape. Use cases are not invented — they fall out of the structure you have discovered.

### Noun refinement

Domain experts use imprecise nouns. "The customer" might be three different actors:

- The **Sender** — goal: package is at its destination (safely, on time, intact)
- The **Recipient** — goal: package is in their possession (predictably, conveniently)
- The **Complainant** — goal: problem is resolved (fairly, promptly)

The refinement cycle: qualify → refine → separate.

1. **Qualify:** "Customer who sends things." "Customer who receives things."
2. **Refine:** The qualifier tells you the distinction. "Customer who sends things" becomes Sender.
3. **Separate:** Now Sender and Recipient are standalone nouns with singular goals. The qualifier vanished because the noun absorbed it.

Another example: "passenger" in the elevator system. A driver is technically a passenger — the operator passenger. Qualify: "operator passenger." Refine: Driver.

Now Driver and Passenger are standalone nouns with distinct goals. The Driver wants to be at the destination via a route they control. The Passenger wants to be there without having to operate the vehicle.

This is how ubiquitous language emerges naturally. You do not design it. You extract it through dialogue until every name carries its own meaning.

### Extract, don't invent

The facilitator's job is to draw out goals, constraints, and events that the expert already knows but has not structured. Not to fabricate domain knowledge. Not to infer requirements from silence.

If you find yourself inventing actors or suggesting goals the expert did not mention, you have switched from facilitator to designer. Stop. Ask another question.

### The vocabulary

- **Socratic extraction** — drawing out structure through questioning.
- **The why-chain** — repeated "why" questions until structure emerges.
- **Noun refinement** — qualify → refine → separate.
- **Ubiquitous language** — precise domain vocabulary extracted through dialogue.

### Try it

Pair up with someone. One of you describes a system you know well. The other conducts a 15-minute interview using the four rounds.

The interviewer's goal: discover at least 2 primary actors with conditional goals and 1 supporting actor with a traceable drive.

Rules for the interviewer:
- Ask questions. Do not assert.
- When you hear a sloppy noun ("the user," "the admin"), refine it.
- When you hear a task ("it processes the order"), redirect to intent ("what state does that achieve?").
- When you hear a contradiction, name it. Do not resolve it.

### Further reading

- VISION.md, "The Natural Group Process" — the four rounds described in full with examples.
- VISION.md, "Why Socratic Extraction Works" — four reasons the method outperforms top-down declaration.
- modeling-vocabulary.md, "Extract, don't invent" — the Socratic principle in modeling terms.

---

## F04: Anatomy of a use case

### The core idea

A use case describes one goal pursued by one primary actor. It is a self-contained document. A reader should understand the goal, constraints, happy path, failure modes, and integration points without reading any other use case.

A use case is not a feature spec, a user story, or a task list. It describes a desired end state and the conditions under which that state is achieved, threatened, or failed.

### The template

Every use case follows the same template. Here are the sections, in order:

1. **Goal** — the desired end state. Express *why*, not *what*. Goals are stable — they survive tool changes, model upgrades, and prompt rewrites. Ask: "What state of the world does the actor want?"

2. **Context** — which bounded context this lives in, who the primary actor is, which supporting actors participate, and what triggers the goal pursuit.

3. **Actor responsibilities** — who owns each concern. Creators write. Researchers explore. Proofreaders review. Orchestrators coordinate. No actor holds two roles.

4. **Invariants** — domain rules that hold continuously. Not entry gates. Not preconditions. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

5. **Success outcome** — observable state when the goal is satisfied. In domain terms, not implementation details.

6. **Failure outcome** — observable state when the goal cannot be satisfied. What is preserved? What does the user see?

7. **Scenario** — steps that express intent and outcomes, not mechanics. Each step says what is accomplished, not how. Domain events (marked with →) signal meaningful state transitions.

8. **Goal obstacles** — conditions that threaten goal satisfaction. Keyed to scenario steps. Describe the threat to the goal, not the error code. Each obstacle has a recovery strategy.

9. **Domain events** — all events this use case produces. Named, defined, meaningful. These are the integration points.

10. **Protocols** — actor boundary contracts. Every crossing point between actors has a protocol defining input, output, and ownership.

11. **Notes** — design decisions, open questions, cross-references.

### A concrete example

UC-01 from the wiki-agent sample: Populate New Wiki.

**Goal:** An empty wiki becomes complete documentation grounded in source code.

This is a desired state, not a task. It passes the gift test — if someone could magically populate the wiki, the User does not care that the process was skipped.

**Scenario steps (intent, not mechanics):**
- "Commissioning orchestrator collects all exploration reports" — what is accomplished, not how.
- "Developmental editor synthesizes exploration reports into a wiki structure" — intent, not implementation.
- "Creators read source files and write wiki pages" — what the actor does, not which functions it calls.

**Obstacles (threats to goals, not exceptions):**
- "Developmental editor fails — synthesis of exploration reports cannot be completed." The threat is to the goal (structured wiki plan). The recovery: orchestrator reports planning failure, user retries.
- "One or more creators fail — some wiki pages cannot be written." The threat is partial completion. The recovery: successful pages remain on disk, orchestrator reports which pages failed.

**Domain events:**
- WikiPopulated — signifies the wiki now exists with approved content. Other bounded contexts (editorial review, drift detection) react to this fact.

### Intent over mechanics

Compare:
- **Intent:** "Wiki content is verified against current source."
- **Mechanics:** "Run grep on lines 1-50 of each source file and compare against wiki page content."

The intent version gives the actor room to find the best path. The mechanics version prescribes a specific implementation. When the implementation changes, the intent statement survives. The mechanical one breaks.

### Obstacles over exceptions

Compare:
- **Obstacle:** "Source code is unreachable — wiki content cannot be verified against its source of truth."
- **Exception:** "Exit code 128 — git clone failed."

The obstacle describes the threat to the goal and implies what is at risk. The exception describes a technical failure and tells you nothing about what to do next.

Every obstacle has a recovery strategy. The recovery preserves what can be preserved and communicates what the actor needs to know.

### The vocabulary

- **Use case** — one goal, one primary actor. Self-contained.
- **Invariant** — a rule that holds continuously, not just at entry.
- **Scenario step** — expresses intent and outcome, not mechanics.
- **Goal obstacle** — a threat to goal satisfaction with a recovery strategy.
- **Domain event** — a meaningful state transition. The published language between contexts.
- **Protocol** — an actor boundary contract. Input, output, ownership.

### Try it

Map the elevator system's "transport passenger" use case to the template. Write:

1. A goal statement that passes the gift test. Include value conditions.
2. Two or three invariants that hold continuously.
3. Three scenario steps that express intent, not mechanics.
4. Two obstacles — one for each of two different value conditions. Include a recovery strategy for each.

Check your work:
- Does the goal describe a state, not an action?
- Do your scenario steps say what is accomplished, not how?
- Are your obstacles framed as threats to the goal?
- Do your recovery strategies explain what is preserved?

### Further reading

- usecase.md — the complete structural contract.
- models/marklauter/github-wiki-manager/UC-01-populate-new-wiki.md — a fully designed use case.
- usecase-lens.md, "Scenario steps express intent" and "Obstacles are threats to the goal" — the principles behind the template.
