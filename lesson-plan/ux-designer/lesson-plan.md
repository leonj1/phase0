# UX designer track: lesson plan

Three lessons (UX01--UX03) for UX design practitioners. This track follows four shared foundation lessons covering conditional goals, actors and drives, Socratic extraction, and use case anatomy. Students already know how to research users. This track teaches Cooper's goal-directed approach -- conditional goals with value conditions, how tensions spawn actors, and how Socratic extraction surfaces domain structure that interviews alone miss.

Running example: an elevator system. Case study: the wiki-agent model at `models/marklauter/github-wiki-manager/`.

---

## UX01: Value conditions and the design space

### Learning objectives

1. Distinguish value conditions from specifications and explain why designing from values keeps the solution space open.
2. Trace the derivation chain from a primary actor's conditional goal through value conditions to system design decisions.
3. Apply actor refinement (qualify, refine, separate) to decompose vague user labels into standalone nouns with singular goals.

### Key concepts

- **Value condition** -- what the actor values about being in the desired state. Not a spec, not a requirement. The value "I don't want to lose my limbs" admits parachutes, airbags, redundant brakes, slow-speed limits. The spec "elevator must not free-fall" admits only one solution category.
- **Derivation chain** -- primary actor -> conditional goal -> value conditions meet reality -> tensions -> supporting actors -> system design. Everything traces back to values.
- **Cooper's goal hierarchy** -- life goals (who you want to be), experience goals (how you want to feel), end goals (what you want to accomplish). Each level shapes design differently.
- **Actor refinement** -- the qualify-refine-separate cycle. "Customer" becomes "customer who sends things" becomes Sender. The qualifier vanishes when the noun absorbs it.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Values vs. specs. Walk through the elevator example: "safely" is a value; "must not free-fall" is a spec that implements it. Show how the value admits solutions the spec never imagined. Introduce the derivation chain. | 15 min |
| Demonstrate | Wiki-agent case study. Show the User's goal hierarchy from the actor catalog: life goals (effectiveness, autonomy), experience goals (feeling in control, feeling confident), end goals (wiki is accurate, is current, reflects the source). Walk through how each experience goal shaped a design decision -- plan approval before content is written (UC-01), post-hoc review via git diff (UC-04), type-to-confirm before destructive actions (UC-06). | 15 min |
| Exercise | Pick a product you use daily. List 5 value conditions you hold about using it. For each value condition, describe one design decision in the product that traces back to that value. Then: identify one value condition the product violates, and describe a design change that would honor it. | 20 min |
| Debrief | Share examples. Test each value condition: is it a value or a disguised spec? Apply the gift test -- if a shortcut satisfies it, you wrote a task. Highlight the best examples of values that open design space vs. specs that close it. | 10 min |

**Total: 60 min**

### Source material

- `actor-lens.md` -- "Goals are conditional," the derivation chain, and why value conditions drive system design
- `phase0/VISION.md` -- "Conditional Goals: The Foundational Concept," the full elevator derivation table
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- the User's goals section
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- User goals and experience goals, actor appearance matrix

---

## UX02: Tension mapping and actor genealogy

### Learning objectives

1. Identify tensions as intersections of value conditions and reality, and explain why tensions are generative forces rather than problems to fix.
2. Trace every supporting actor's genealogy back to a specific value condition on a primary actor's conditional goal.
3. Use separation of concerns as a design response to conflicting drives.

### Key concepts

- **Tension** -- what happens when a value condition meets reality. "Safely" collides with the Owner's economic drive. "Promptly" collides with building capacity. Each collision demands resolution.
- **Actor genealogy** -- every supporting actor traces back to a specific value condition on a specific primary actor's goal. If you cannot trace the lineage, the actor should not exist in the model.
- **Separation of concerns** -- when a single drive cannot serve competing concerns, separate actors with complementary drives resolve the conflict. The Owner's cost-minimization drive is insufficient to protect the Passenger's safety value, so the Inspector exists.
- **"What keeps you up at night?"** -- Cooper's question that surfaces tensions domain experts live with but have not named.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | Tensions as generative forces. Walk through Round 3 of the natural group process: "What keeps you up at night?" Show how each answer maps to a value condition under threat. Introduce actor genealogy -- every supporting actor has a birth certificate traceable to a value condition. | 15 min |
| Demonstrate | Two case studies side by side. **Elevator:** Passenger's "safely" value + Owner's cost-minimization drive = tension -> Inspector (drive: public safety). Passenger's "promptly" value + building capacity = tension -> Scheduler (drive: efficiency). **Wiki-agent:** User's accuracy value + Creator's production drive = tension -> Proofreader (drive: critique). Show that four proofreading lenses exist because no single lens catches everything -- structure, line editing, copy editing, accuracy. Each lens is a separate application of the critique drive to a different concern. | 20 min |
| Exercise | Return to the elevator system. Start from the Passenger's four value conditions (safely, promptly, without trauma, intact). For each value condition: name the force of reality it collides with, describe the tension, name the supporting actor it spawns, and state that actor's drive. Present your tension map as a table. | 20 min |
| Debrief | Compare tension maps. Look for: actors spawned by multiple tensions (legitimate -- some actors resolve more than one). Actors with no traceable genealogy (cut them). Tensions with no actor (either the tension is resolved by an existing actor's drive, or you have found a gap). Discuss: what happens to a system that has no tensions? | 15 min |

**Total: 70 min**

### Source material

- `actor-lens.md` -- "Goal conditions create tensions; tensions spawn supporting actors," "Goal conflicts spawn actors"
- `phase0/VISION.md` -- "Round 3: What goes wrong?", "The Entry Point: Actors and Goals, From First Principles" (includes the elevator derivation table and chain)
- `models/marklauter/github-wiki-manager/ACTOR-CATALOG.md` -- Proofreaders section (four editorial lenses), separation rationale for Content Mutators
- `models/marklauter/github-wiki-manager/USE-CASE-CATALOG.md` -- domain description, actor drives paragraph

---

## UX03: From discovery to design

### Learning objectives

1. Describe the four rounds of the natural group process and explain why they are lenses rather than sequential stages.
2. Distinguish the facilitator role from the historian role and explain why raw insights must be captured before they are ready for formalization.
3. Conduct a Phase0 discovery session using Socratic extraction to surface actors, goals, tensions, and domain vocabulary.

### Key concepts

- **Phase0** -- the zeroth thing before anything else makes sense. The process is domain discovery. The product is a vision statement answering: who does this serve, what do they value, what forces are at play.
- **The four rounds** -- (1) "What is this thing?" surfaces the system boundary. (2) "Who touches this?" surfaces actors with conditional goals. (3) "What goes wrong?" surfaces tensions. (4) Use cases emerge naturally from the accumulated material.
- **Lenses, not pipelines** -- looking through one lens changes what you see through another. Actor discovery surfaces use cases. Use case design spawns actors. Tension mapping redefines system boundaries. Backtracking is correct.
- **The facilitator** -- drives the conversation. Asks why. Notices contradictions. Decides what to explore next. Does not need domain expertise -- in fact, domain expertise can be a liability.
- **The historian** -- captures what matters without being prompted. Decisions, contradictions, new terms, open questions, raw insights. Writes things down that are not ready to become formal artifacts.
- **Raw insights vs. structured artifacts** -- "We don't track packages, we track promises" is a raw insight. It may never become a formal artifact, but losing it would be a loss. The historian preserves the seeds that formal processes would discard.

### Activity sequence

| Phase | Activity | Time |
|-------|----------|------|
| Teach | The Phase0 process. Walk through the four rounds using the package delivery example from the vision document. Show how "the customer" became three actors (Sender, Recipient, Complainant) through noun refinement. Show how "packages get lost between warehouse and truck" revealed a bounded context boundary. Introduce the facilitator/historian division of labor. | 15 min |
| Demonstrate | Show the historian's capture vs. specialist output. Side-by-side comparison: the historian writes "Alice said 'shipment' means what leaves the warehouse; Bob contradicted -- he means what the customer ordered." The specialist later writes the GLOSSARY.md entries. The historian captures the contradiction; the specialist resolves it. Highlight the last row: "Alice's insight: 'we don't track packages, we track promises'" -- raw material that no specialist agent formalizes, but that the historian preserves. | 10 min |
| Exercise | Groups of 3. One person is the domain expert (pick a domain you know well -- your workplace, a hobby, a system you use daily). One is the facilitator. One is the historian. Conduct a 30-minute Phase0 discovery session. The facilitator runs the four rounds. The historian captures decisions, contradictions, new terms, open questions, and raw insights. At the end, the historian reads back their notes. The group identifies: how many primary actors, how many value conditions, and how many tensions they surfaced. | 30 min |
| Debrief | Each group shares their historian's notes (not the facilitator's conclusions). Discuss: what did the historian capture that the facilitator missed? Where did backtracking happen (a later round changed what was understood from an earlier round)? Which raw insights feel important but are not yet ready to become artifacts? | 15 min |

**Total: 70 min**

### Source material

- `phase0/VISION.md` -- "The Natural Group Process" (all four rounds), "Who Holds the Threads?" (the historian role), "The Agentic Architecture," "Why Socratic Extraction Works"
- `modeling-vocabulary.md` -- "Extract, don't invent"
- `SYSTEM-DESIGN-PHASES.md` -- "On backtracking"
