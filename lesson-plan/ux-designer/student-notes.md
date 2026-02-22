# UX designer track: student notes

Self-contained reading material for each lesson. You can read each section independently.

---

## UX01: Value conditions and the design space

### The core idea

Design decisions come from values, not features.

When you describe what a user wants, you probably reach for features: "they want search," "they want notifications," "they want a dashboard." But features are solutions. They close the design space to one answer. Values keep it open.

Consider an elevator. The Passenger's goal is to be on a different floor. But "be on a different floor" tells you nothing about how to design the elevator. The value conditions tell you everything:

- **Safely** -- the Passenger values their physical integrity
- **Promptly** -- the Passenger values their time
- **Without trauma** -- the Passenger values their psychological comfort
- **Intact** -- the Passenger values keeping all their limbs

A spec says "the elevator must not free-fall." That spec is one implementation of the "safely" value. It admits one category of solutions: mechanisms that prevent free-fall.

The value "I don't want to lose my limbs" admits far more. Parachutes. Airbags. Redundant brakes. Slow-speed limits. Padded interiors. Each is a valid response to the same value. Designing from the value keeps options open. Designing from the spec closes them.

### The derivation chain

Everything in a well-designed system traces back to values:

```
Primary actor
  -> conditional goal (desired state + value conditions)
    -> value conditions meet reality -> tensions
      -> tensions spawn supporting actors (each with a drive)
        -> system design (invariants, use cases, bounded contexts)
```

The primary actor has a conditional goal. "Conditional" because the goal is not just the destination -- it includes the values the actor holds about being in that state. A Passenger who reaches floor 5 missing an arm did not achieve their goal. Physical integrity was part of the goal, not an optional extra.

### Cooper's goal hierarchy

Alan Cooper distinguishes three levels of goals. Each drives different design decisions:

- **Life goals** -- who you want to be. "Be a responsible steward of the project's knowledge." Life goals shape brand and positioning.
- **Experience goals** -- how you want to feel. "Feel confident that the wiki is accurate." "Feel in control of what gets published." Experience goals shape interaction patterns.
- **End goals** -- what you want to accomplish. "Wiki is accurate, is current, reflects the source." End goals shape features.

In the wiki-agent system, the User's experience goals drove specific design decisions:

| Experience goal | Design decision |
|----------------|----------------|
| Feel in control -- no surprises from autonomous agents | Plan approval before content is written (UC-01) |
| Feel confident the wiki is accurate | Post-hoc review via git diff after autonomous corrections (UC-04) |
| Feel that the system respects their judgment | Type-to-confirm before destructive actions (UC-06) |

Each experience goal produced a specific interaction pattern. The features are consequences of values, not the starting point.

### Actor refinement

Users are not monoliths. When someone says "the customer," they might mean three different actors:

- The customer who sends packages (goal: package is at its destination -- safely, on time, intact)
- The customer who receives packages (goal: package is in their possession -- predictably, conveniently)
- The customer who complains (goal: problem is resolved -- fairly, promptly)

These are three different conditional goals with different value conditions. Calling them all "customer" hides design-critical distinctions.

The refinement process: qualify, refine, separate.

1. **Qualify:** "customer who sends things"
2. **Refine:** the qualifier tells you the noun is too broad. Absorb the qualifier into a new noun.
3. **Separate:** "Customer who sends things" becomes **Sender**. The qualifier vanished because the noun absorbed it.

Apply the gift test to check your goals. "I want to have a guitar" is a goal. "I want to buy a guitar" is a task disguised as a goal.

If someone gifts you the guitar, you do not care that you did not buy it. If your goal statement would be satisfied by a shortcut that skips the described action, you wrote a task, not a goal.

### Try it

Pick a product you use daily -- a phone app, a tool at work, a household appliance. List 5 value conditions you hold about using it. For each one, describe a design decision in the product that traces back to that value. Then find one value condition the product violates, and describe a design change that would honor it.

### Further reading

- `.claude/modeling-contracts/principles/actor-lens.md` -- "Goals are conditional," the derivation chain, and why value conditions drive system design
- `phase0/VISION.md` -- "Conditional Goals: The Foundational Concept"
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- User goals and experience goals

---

## UX02: Tension mapping and actor genealogy

### The core idea

Tensions are not problems to fix. They are the generative force of system design.

A tension is what happens when a value condition meets reality. The Passenger values safety. The building Owner's drive is to minimize cost. Those two forces collide. That collision is a tension.

The tension is not a sign that something is broken. The Owner is not trying to hurt the Passenger. But a single drive cannot serve competing concerns.

The Owner's cost-minimization drive will, left unchecked, underinvest in safety. Not out of malice -- out of optimization. Every actor optimizes for its own drive. That is what makes actors predictable, and it is why you need more than one.

The tension between the Passenger's safety value and the Owner's cost drive demands resolution. That resolution is a new actor: the **Inspector**, whose drive is public safety. The Inspector exists because no existing actor's drive protects the Passenger's safety value. The Inspector's genealogy traces directly to the Passenger's "safely" value condition.

### Tension mapping

Start from the primary actor's value conditions. For each one, ask: what force of reality does this collide with?

**The elevator, fully mapped:**

| Value condition | Collides with | Tension | Actor spawned | Drive |
|----------------|--------------|---------|---------------|-------|
| Safely | Owner's cost-minimization drive | Cost-cutting could compromise safety measures | Inspector | Public safety |
| Promptly | Building capacity and demand patterns | More passengers than elevators can serve at peak times | Scheduler | Efficiency (optimize throughput) |
| Without trauma | Mechanical wear, power failures | Equipment can malfunction mid-ride, trapping or frightening passengers | Maintainer | Reliability |
| Intact | Door mechanics, movement physics | Moving machinery operates near human bodies | Safety Engineer | Harm prevention |

Each row follows the same pattern: a value condition on the primary actor's goal meets a force of reality. The collision demands a supporting actor whose drive addresses what no existing actor can protect.

### Actor genealogy

Every supporting actor has a genealogy. You can trace why they exist back to a specific value condition on a specific primary actor's goal.

The Inspector exists because:
1. The Passenger has a conditional goal: be on a different floor -- **safely**
2. The Owner's drive is cost-minimization
3. The Owner's drive, left unchecked, will underinvest in safety
4. The state's interest in public welfare demands a third party
5. The Inspector is born, with a drive toward public safety

If you cannot trace an actor's genealogy to a value condition, that actor should not exist in the model.

### The wiki-agent parallel

The same pattern appears in the wiki-agent system:

1. The User has a conditional goal that includes accuracy as a value condition
2. The Creator's drive is production -- fill pages with content
3. The Creator's production drive, left unchecked, is insufficient to guarantee accuracy. Not because the Creator is careless, but because production and critique are different skills. An actor that both writes and evaluates what it wrote has two jobs and will do both poorly.
4. The Proofreader is born, with a drive toward critique

Four proofreading lenses exist because no single pass catches everything:

| Lens | What it checks |
|------|---------------|
| Structure | Organization, flow, gaps, redundancies across the whole wiki |
| Line | Sentence-level clarity, tightening, transitions on each page |
| Copy | Grammar, formatting, terminology consistency across pages |
| Accuracy | Claims verified against source code on each page |

Each lens is the critique drive applied to a different concern.

Structure problems require reading the wiki as a whole. Accuracy problems require reading each page against its source. These are different reading strategies. One pass cannot do both well.

### Separation of concerns as conflict resolution

When you find a tension, the structural answer is separation. Not trust. Not "be more careful." Separation.

The Owner and the Inspector have opposing drives. That opposition is the point. Two actors with opposing drives produce better outcomes than one actor trying to balance competing concerns.

The Creator and the Proofreader have opposing drives. The Creator optimizes for production. The Proofreader optimizes for critique. An actor that both produces and critiques will compromise between them -- producing content that is "good enough" rather than content that is excellent and then separately verified.

A system with no tensions has no supporting actors. And a system with no supporting actors has no protection against single-drive failure.

### Try it

Return to the elevator system. Start from the Passenger's four value conditions: safely, promptly, without trauma, intact. For each one:

1. Name the force of reality it collides with.
2. Describe the tension.
3. Name the supporting actor it spawns.
4. State that actor's drive.

Present your tension map as a table. Then check each actor's genealogy: can you trace it back to a specific value condition?

### Further reading

- `.claude/modeling-contracts/principles/actor-lens.md` -- "Goal conditions create tensions; tensions spawn supporting actors," "Goal conflicts spawn actors," "Single responsibility for actors"
- `phase0/VISION.md` -- "The Entry Point: Actors and Goals, From First Principles" (includes the elevator derivation table), "Round 3: What goes wrong?"
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- Proofreaders (four editorial lenses), Content Mutator separation rationale

---

## UX03: From discovery to design

### The core idea

Phase0 is the zeroth thing before anything else makes sense.

Before you can design use cases, you need actors. Before you can map tensions, you need value conditions. Before you can write value conditions, you need to know who the primary actors are. And before you can identify primary actors, someone needs to ask: "What problem are you trying to solve?"

Phase0 is the domain discovery process. Its product is a vision statement that answers three questions:

1. **Who does this system serve?** -- primary actors
2. **What do they value?** -- conditional goals (desired end states + value conditions)
3. **What forces are at play?** -- tensions, and the supporting actors those tensions spawn

Everything downstream -- use cases, bounded contexts, domain events -- is elaboration of the vision.

### The four rounds

Phase0 uses a natural group process. Four rounds, each looking at the domain through a different lens.

**Round 1: "What is this thing?"**

A facilitator asks domain experts: "What problem are you trying to solve?" The answers are messy, overlapping, contradictory. One person says "we need to track shipments." Another says "customers keep calling about late deliveries." A third says "our warehouse doesn't know what's coming."

These are all symptoms of the same system. The facilitator keeps asking why until the group converges on something like: "We need visibility into the lifecycle of a package from warehouse to doorstep." That is a system boundary.

**Round 2: "Who touches this?"**

The facilitator asks: "Who interacts with this?" The first answers are sloppy. "The customer." But "the customer" might be three actors:

- **Sender** -- goal: package is at its destination, safely, on time, intact
- **Recipient** -- goal: package is in their possession, predictably, conveniently
- **Complainant** -- goal: problem is resolved, fairly, promptly

The refinement process is the qualify-refine-separate cycle from UX01. "Customer who sends things" becomes Sender. The qualifier vanishes when the noun absorbs it. This is how domain vocabulary emerges -- not designed, but extracted through dialogue.

**Round 3: "What goes wrong?"**

This is Cooper's question: "What keeps you up at night?" The answers reveal where values collide with reality:

- "Packages get lost between warehouse and truck." -- the Sender's "intact" value is threatened
- "Two drivers show up for the same route." -- the Recipient's "predictably" value is threatened
- "Customer calls and nobody knows where the package is." -- the Sender's "on time" value and the Complainant's "fairly" value are both threatened

Each answer is a tension. And tensions reveal two things: supporting actors (the "nobody knows where the package is" tension demands a Tracker), and bounded context boundaries (the "lost package" problem lives at the boundary between warehouse and logistics).

**Round 4: Use cases emerge naturally.**

By now the group has primary actors with conditional goals, supporting actors with drives, tensions at boundaries, and a rough sense of the system's shape. Use cases are not invented. They fall out. "The Dispatcher assigns routes" is something the domain experts have been doing. Now it has a name.

### Lenses, not pipelines

The four rounds are not sequential steps. They are lenses. Looking through one lens changes what you see through another:

- Actor discovery surfaces use cases: "If the Driver's drive is 'complete route efficiently,' there must be a route-assignment process."
- Use case design spawns actors: "Wait -- who makes this decision? That is not the same person who..."
- Tension mapping redefines system boundaries: "The lost-package problem means logistics and warehouse are separate contexts."
- Domain narrative suggests actors: "In our warehouse, the night crew does receiving and the day crew does picking."

Backtracking is correct. If Round 3 reveals a new actor that changes your understanding from Round 2, go back. That is not failure. That is depth.

### The facilitator and the historian

Two roles. Two different skills.

**The facilitator** drives the conversation. Asks why. Notices contradictions. Decides what to explore next.

The facilitator does not need domain expertise. In fact, domain expertise can be a liability -- an expert facilitator may project their own model instead of extracting the domain expert's. The facilitator's power comes from not knowing the answers. That is what makes the questions genuine.

**The historian** captures what matters. Silently. Without being prompted. The historian writes down:

- **Decisions** -- not just discussions
- **Contradictions** -- not just statements
- **New terms** -- when vocabulary shifts or a new word is coined
- **Open questions** -- things explicitly deferred
- **Raw insights** -- things that are not ready to become formal artifacts

The historian's most important captures are the raw insights. "Alice's insight: 'we don't track packages, we track promises.'"

That sentence might become a design principle. It might become a domain narrative. It might remain a note forever. But formal processes have no place for it. The historian does.

Here is what the historian captures vs. what specialist agents later produce:

| Historian writes | Specialist produces |
|-----------------|-------------------|
| "We discussed splitting Customer into Sender and Recipient" | Actor catalog entry for Sender |
| "Open question: does Driver belong in Logistics or Fleet?" | Domain context definition |
| "Contradiction: 'shipment' means different things to warehouse and delivery" | Glossary entries |
| "Decision: bounded context boundary between Warehouse and Logistics" | Domain context definitions |
| "Alice's insight: 'we don't track packages, we track promises'" | Nothing -- not yet an artifact |

The last row is the point. The historian preserves the seeds that formal processes would discard.

### Try it

Groups of 3. One person is the domain expert -- pick a domain you know well (your workplace, a hobby, a system you use daily). One is the facilitator. One is the historian.

Conduct a 30-minute Phase0 discovery session:

1. The facilitator runs the four rounds. Start with "What problem are you trying to solve?" and follow wherever it leads.
2. The historian captures decisions, contradictions, new terms, open questions, and raw insights. Timestamp each entry.
3. At the end, the historian reads back their notes.

Count what you surfaced: how many primary actors? How many value conditions? How many tensions? Which historian notes are not yet ready to become anything formal?

### Further reading

- `phase0/VISION.md` -- "The Natural Group Process" (all four rounds), "Who Holds the Threads?" (the historian role), "Why Socratic Extraction Works"
- `.claude/modeling-contracts/principles/modeling-vocabulary.md` -- "Extract, don't invent"
- `.claude/modeling-contracts/SYSTEM-DESIGN-PHASES.md` -- "On backtracking"
