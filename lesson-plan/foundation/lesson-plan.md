# Foundation lessons — lesson plan

Four lessons shared across all tracks. These build the conceptual vocabulary that every track depends on.

---

## F01: Goals, not tasks

### Learning objectives

1. Distinguish a goal (desired end state) from a task (implementation path).
2. Apply the gift test to identify task-disguised-as-goal statements.
3. Identify value conditions on a goal and explain why they matter more than the destination.

### Key concepts

- **Conditional goal** — a desired end state plus value conditions. A value statement.
- **Gift test** — if a shortcut satisfies it, you wrote a task, not a goal.
- **Value conditions** — what the actor values about being in the desired state. Not specs. Not acceptance criteria.

### Activity sequence

1. **Teach** (20 min) — present the goal/task distinction using the elevator example. "Be on a different floor" is a goal. "Arrive at floor 5" leaks an implementation detail. Introduce the gift test with the guitar example: "I want to have a guitar" vs. "I want to buy a guitar." Introduce value conditions: safely, promptly, without trauma, intact.
2. **Demonstrate** (15 min) — show values vs. specs. "I don't want to lose my limbs" vs. "elevator must not free-fall." The spec is one implementation of the value. Designing from values keeps the solution space open.
3. **Exercise** (20 min) — students rewrite 5 task statements as goals and identify value conditions for each. See student notes for the exercise prompts.
4. **Debrief** (15 min) — review rewrites as a group. Apply the gift test to each. Discuss which value conditions emerged.

**Total: 70 min**

### Source material

- actor-lens.md, "Goals are conditional" section
- VISION.md, "Conditional Goals: The Foundational Concept" section

---

## F02: Actors and drives

### Learning objectives

1. Distinguish primary actors (goals) from supporting actors (drives).
2. Trace the derivation chain from value conditions through tensions to supporting actors.
3. Explain why every supporting actor must have a traceable genealogy.

### Key concepts

- **Primary actor** — has a conditional goal. The system exists to serve them.
- **Supporting actor** — has a drive. Born from tensions between value conditions and reality.
- **Drive** — a reason to participate. Not a job description.
- **Tension** — a value condition meeting the forces of reality.
- **Genealogy** — every supporting actor traces back to a specific value condition on a primary actor's goal.
- **Single responsibility** — one drive per actor. Separate judgment from execution.

### Activity sequence

1. **Teach** (25 min) — present the primary/supporting distinction using the elevator system. The Passenger is primary (conditional goal: be on a different floor — safely, promptly, without trauma, intact). Walk through the full derivation: "safely" collides with the Owner's economic drive → Inspector spawned by the tension. "Promptly" collides with building capacity → Scheduler spawned. Show the derivation chain diagram.
2. **Demonstrate** (15 min) — show the wiki-agent example. Creator's drive is production. Proofreader's drive is critique. The Proofreader exists because the Creator's production drive is insufficient to guarantee accuracy — and accuracy is a value condition on the User's goal. Trace the genealogy.
3. **Exercise** (20 min) — given the elevator Passenger's value conditions (safely, promptly, without trauma, intact), derive the full actor network. For each supporting actor: name them, state their drive, and trace which value condition spawned them.
4. **Debrief** (10 min) — review actor networks. Test each with the genealogy question: "What tension demands this actor, and what drive resolves it?"

**Total: 70 min**

### Source material

- modeling-vocabulary.md, "Primary actors have goals; supporting actors have drives"
- actor-lens.md, "Goal conditions create tensions; tensions spawn supporting actors" through "Goal conflicts spawn actors"
- VISION.md, "The Entry Point: Actors and Goals, From First Principles" (includes the full elevator derivation table)

---

## F03: Socratic extraction

### Learning objectives

1. Explain why extraction through questioning beats top-down declaration.
2. Apply the noun-refinement cycle (qualify → refine → separate) to split ambiguous actors.
3. Conduct a basic Socratic interview using the four-round structure.

### Key concepts

- **Socratic extraction** — drawing out structure the domain expert already knows but hasn't articulated.
- **The why-chain** — keep asking why until the domain's own structure emerges.
- **Noun refinement** — qualify → refine → separate. "Customer" becomes Sender, Recipient, Complainant. "Passenger" becomes Driver, Passenger.
- **Ubiquitous language** — domain vocabulary that emerges through dialogue, not design.
- **Extract, don't invent** — the facilitator structures; the expert knows.

### Activity sequence

1. **Teach** (20 min) — present the four rounds from Phase0. Round 1: "What is this thing?" Round 2: "Who touches this?" Round 3: "What goes wrong?" Round 4: Use cases emerge. Use the package delivery example from VISION.md — "the customer" splits into Sender, Recipient, Complainant through noun refinement.
2. **Demonstrate** (15 min) — live noun-refinement. Start with "passenger" in the elevator system. A driver is technically a passenger — the operator passenger. Qualify, refine, separate: "operator passenger" → Driver. Now you have a standalone noun with a clear goal. The qualifier vanished because the noun absorbed it.
3. **Exercise** (25 min) — pair up. One person describes a system they know well. The other conducts a 15-minute Socratic interview following the four rounds. The interviewer's job: discover at least 2 primary actors with conditional goals and 1 supporting actor with a traceable drive. Switch roles if time permits.
4. **Debrief** (10 min) — pairs report what they discovered. Discuss: what surprised you? Where did contradictions appear? What was hardest — asking or answering?

**Total: 70 min**

### Source material

- VISION.md, "The Natural Group Process" section (all four rounds)
- VISION.md, "Why Socratic Extraction Works"
- modeling-vocabulary.md, "Extract, don't invent"

---

## F04: Anatomy of a use case

### Learning objectives

1. Name every section of a use case and explain its purpose.
2. Distinguish intent-level scenario steps from mechanical ones.
3. Frame failures as goal obstacles with recovery strategies, not exceptions.

### Key concepts

- **Use case template** — Goal, Context, Actor responsibilities, Invariants, Success/failure outcomes, Scenario, Goal obstacles, Domain events, Protocols, Notes.
- **Intent over mechanics** — "wiki content is verified against current source" vs. "run grep on lines 1-50."
- **Obstacles over exceptions** — "source code is unreachable" (threat to goal) vs. "exit code 128" (error code).
- **Domain events** — meaningful state transitions that cross boundaries or are visible to the user.
- **Protocols** — actor boundary contracts at every crossing point.

### Activity sequence

1. **Teach** (20 min) — walk through usecase.md section by section. Explain why Goal comes first (goals over tasks), why Invariants precede Scenario (rules hold continuously), why Obstacles have recovery strategies (goals, not exceptions).
2. **Demonstrate** (25 min) — walk through UC-01 Populate New Wiki from the wiki-agent sample. Show how each template section looks when filled in. Point out: the goal is a desired state ("empty wiki → complete documentation"), scenario steps express intent ("commissioning orchestrator collects all exploration reports"), obstacles are threats to the goal ("developmental editor fails — synthesis cannot be completed"), domain events name what was produced ("WikiPopulated").
3. **Exercise** (20 min) — map the elevator system's "transport passenger" use case to the template. Write: goal statement with value conditions, 2-3 invariants, 3 scenario steps (intent, not mechanics), 2 obstacles with recovery strategies.
4. **Debrief** (10 min) — review use cases. Check: does the goal pass the gift test? Do scenario steps express intent? Are obstacles framed as threats to the goal?

**Total: 75 min**

### Source material

- usecase.md (full document)
- models/marklauter/github-wiki-manager/UC-01-populate-new-wiki.md
- usecase-lens.md, "Scenario steps express intent" and "Obstacles are threats to the goal"
