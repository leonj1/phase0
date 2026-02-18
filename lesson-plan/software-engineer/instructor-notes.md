# Software engineer track: instructor notes

Teaching guidance for SWE01--SWE03. Each section covers the target "aha moment," common misconceptions, how to handle examples, exercise guidance, and the transition to the next lesson.

---

## SWE01: Domain-driven design foundations

### The aha moment

Students realize that the same word meaning different things in different contexts IS the context boundary. You do not design boundaries. You discover them through contradictions.

When a student says "but a correction is just a correction" -- that is the setup. Push back: a correction in Issue Resolution comes from a GitHub issue filed by a proofreader. A correction in Drift Detection comes from a fact-checker's assessment against source code. The authority is different. The trigger is different. The workflow is different. The word is the same. That contradiction reveals the boundary.

If you get this moment right, students stop thinking of bounded contexts as architecture decisions and start seeing them as discoveries about how the domain actually works.

### Common misconceptions

**1. "Bounded contexts are modules."**
Students who have worked with microservices will map bounded contexts to service boundaries or code folders. A bounded context is not a deployment unit. It is a region of the domain with its own language. Two contexts can live in the same codebase. The boundary is semantic, not structural. Redirect by asking: "What word means something different on each side?"

**2. "Domain events are just callbacks or webhooks."**
Engineers hear "event" and think pub/sub or event-driven architecture. Domain events in this model are meaningful state transitions -- facts about the domain that are worth naming. WikiPopulated is not a message on a queue. It is the fact that the wiki went from empty to populated. The event has a name, a payload, and consumers. It is the published language. If students start drawing message broker diagrams, slow them down: "What happened in the domain? Name the fact."

**3. "Invariants are just validation at the start."**
Students will conflate invariants with preconditions or input validation. An invariant holds continuously. "The elevator must not move with doors open" is not checked once at departure. It must hold at every moment. If the doors malfunction mid-transit, the invariant is violated even though it was satisfied at departure. Ask: "When would checking this only once be dangerous?"

### Handling the examples

**The shipment contradiction.** Use this as the opening. Ask students: "What is a shipment?" Let them answer. Then ask: "What does the warehouse team mean by 'shipment'?" (items picked and boxed, ready to leave) versus "What does the delivery team mean by 'shipment'?" (items loaded on a truck, in transit). Point out that both teams are right -- inside their own context. The contradiction is the boundary.

**The wiki-agent context map.** Walk through DC-01 through DC-06. Spend time on the DC-03/DC-04 language overlap: both use "correction assignment" as a protocol, but the contexts are separate because the authority, trigger, and workflow differ. The shared protocol enables agent reuse (corrector agents work in both contexts) without merging the contexts.

**Domain events DE-01 through DE-07.** Show the DOMAIN-EVENTS.md file. Highlight the difference between published events (FindingFiled crosses from DC-02 to DC-03) and user-visible events (WikiReviewed is consumed only by the User). Ask students which events cross boundaries and which do not.

### Exercise guidance

Students identify 3 bounded context candidates in the elevator system and define one domain event for each.

**What good answers look like:**
- **Passenger Transport** (or similar): owns the experience of moving between floors. Event: ElevatorDispatched (an elevator has been assigned to a passenger's request).
- **Safety Compliance** (or Inspection): owns the regulatory relationship between the Inspector and the system. Event: InspectionCompleted (a safety inspection has been performed and the result is recorded).
- **Scheduling** (or Capacity Management): owns the optimization of elevator allocation across demand patterns. Event: ScheduleOptimized (the scheduling algorithm has produced a new allocation plan).

**What to watch for:**
- Students naming contexts after technical layers ("Database," "API," "Frontend"). Redirect: "What part of the domain does this own?"
- Events named as commands ("DispatchElevator") instead of facts ("ElevatorDispatched"). Redirect: "This is what happened, not what you want to happen."
- Missing the language contradiction test. If a student proposes a boundary, ask: "What word means something different on each side?" If they cannot answer, the boundary may be artificial.

**Debrief focus:** Did the boundaries emerge from contradictions, or were they imposed from technical architecture? Are the events facts about the domain, or messages in a system?

### Transition to SWE02

Close with the question: "You now have actors with drives and contexts with their own language. How do you turn these into running software?" Preview that drives become system prompts, tool restrictions enforce separation, and the domain model maps directly to agent architecture.

---

## SWE02: From model to agentic system

### The aha moment

Students see that drives becoming system prompts changes agent behavior fundamentally. "Your job is to find what's wrong" produces vigilance. "Review this page for errors" produces compliance. The same model, the same tools, the same data -- but a different prompt orientation changes what the agent actually does.

When you demonstrate this, use concrete language. Show two prompt fragments side by side. Ask students: "Which agent will catch more bugs?" Then ask: "Why?" The answer is that the first prompt tells the agent what it IS (a critic), not what it should DO (review). Identity produces behavior. Instructions produce compliance.

### Common misconceptions

**1. "More tools means more capable."**
Engineers default to giving agents every tool available. The opposite is correct. A researcher that can write files will start "helping" by fixing what it finds. A proofreader that can edit will silently correct instead of reporting. Removing tools is not limiting the agent -- it is focusing the drive. Ask: "If the proofreader could fix the page, would it still file the finding?"

**2. "Hooks are just input validation."**
Students will see hooks as glorified middleware or request validators. Hooks enforce invariants -- constraints that must hold continuously, not just at invocation. A PreToolUse hook that blocks writes outside the wiki directory is not validating input. It is enforcing the invariant "source code is readonly" at every moment, including moments the LLM did not anticipate. The LLM cannot negotiate with a hook. That is the point.

**3. "The orchestrator is just a router."**
Students may reduce the orchestrator to a task dispatcher. The orchestrator holds the primary actor's goal. It does not just route messages -- it ensures the drives of its subagents, taken together, satisfy the goal's value conditions. When the commissioning orchestrator dispatches researchers and then feeds their reports to the developmental editor, it is not routing. It is managing the progressive refinement of understanding in service of the user's goal.

### Handling the examples

**Wiki-agent actor-to-agent mapping.** Walk through the ACTOR-CATALOG.md. For each actor family, show the tool restrictions:
- Researchers (assessors): Read, Grep, Glob. No Write, no Edit. The read-only constraint IS the behavioral trait.
- Creators (content mutators): Write, Edit. They need mutation tools because their drive is production.
- Proofreaders (assessors): Read, Grep, Glob. Same tools as researchers, but the drive is different. The researcher comprehends. The proofreader critiques. Same tools, different behavior, because the system prompt embodies a different drive.

**The Creator/Proofreader separation.** This is the strongest demonstration of drive separation. Both agents read the same wiki pages. Both read the same source code. The creator has Write tools and a production drive. The proofreader has only Read tools and a critique drive. If you gave both drives to one agent, it would produce "good enough" content -- compromising between production speed and critical thoroughness. Two agents with opposing drives produce better outcomes than one agent balancing competing concerns.

**Model selection table.** Show the cognitive demand table from DOMAIN-IMPLEMENTATION-PRINCIPLES.md. Use concrete examples: a script that runs `git clone` does not need Opus. An orchestrator that dispatches agents and relays events does not need Opus either -- Sonnet is sufficient for coordination. But a fact-checker that reads source code and evaluates whether a wiki claim is accurate? That is knowledge work. Opus is the floor.

### Exercise guidance

Students specify tool restrictions and system prompt fragments for Owner, Inspector, and Scheduler agents in the elevator system.

**What good answers look like:**

**Owner agent:**
- Drive: economic optimization (minimize cost while maintaining service).
- System prompt fragment: "You manage the economic health of the elevator system. Every maintenance decision, every equipment choice, every service contract is evaluated through the lens of cost-effectiveness. Your job is to find the cheapest path that still meets all obligations."
- Tool restrictions: Read access to maintenance logs, cost reports, service contracts. Write access to budget allocations and maintenance schedules. No write access to safety inspection records.
- Invariants: "Maintenance budget must not fall below regulatory minimum" -- hook, not prompt.
- Model tier: Sonnet (coordination and budget optimization, not deep knowledge work).

**Inspector agent:**
- Drive: public safety (find what is wrong, assume nothing is safe until proven).
- System prompt fragment: "You exist because economic pressure alone cannot protect passengers. Every component is suspect. Every maintenance log is a claim that must be verified. Your job is to find what is unsafe -- a clean report means you looked hard and found nothing, not that you looked quickly."
- Tool restrictions: Read access to all system records, maintenance logs, safety test results. Write access only to inspection reports. No write access to maintenance schedules or budgets.
- Invariants: "Inspection records must not be modified by the entity being inspected" -- hook.
- Model tier: Opus (knowledge work -- reading, evaluating, judging safety).

**Scheduler agent:**
- Drive: promptness optimization (minimize wait time across all passengers given capacity).
- System prompt fragment: "You own the allocation of elevators to demand. Every idle elevator is wasted capacity. Every long wait is a failure of prediction. Your job is to anticipate demand patterns and position resources before they are needed."
- Tool restrictions: Read access to demand patterns, building occupancy data, elevator positions. Write access to dispatch schedules. No write access to safety or maintenance records.
- Invariants: "Elevators under maintenance must not be dispatched" -- hook.
- Model tier: Sonnet (coordination and optimization, pattern-based).

**What to watch for:**
- System prompts that describe tasks instead of drives. "Check the elevators for safety issues" is a task. "Your job is to find what is unsafe" is a drive.
- Tool restrictions that are too broad. If the Inspector can write to maintenance schedules, it has two responsibilities. Push back: "Can this agent both judge safety AND decide what to fix?"
- All agents assigned to Opus. Not every drive requires deep knowledge work. The Scheduler optimizes patterns -- that is coordination, not comprehension.

**Debrief focus:** Do the system prompts express identity or instructions? Would removing a tool from any agent change its behavior in a way that contradicts its drive?

### Transition to SWE03

Close with: "You can now turn individual actors into agents. But a system is not a collection of agents -- it is a model. How do all the pieces fit together? How do you know when the model is complete? And what does 'complete' even mean when the model is discovered, not constructed?"

---

## SWE03: The complete model

### The aha moment

Students realize the model is discovered, not constructed. Phases are numbered for exposition, not compliance. Backtracking is correct and expected.

The moment usually lands when you show a concrete example of backtracking: designing UC-03 (Revise Wiki) reveals that the proofreader's finding format in UC-02 (Review Wiki Quality) must include quoted text and a source reference -- information UC-02 did not originally capture. So you go back to UC-02 and revise it. This is not a failure of planning. It is the process working correctly.

Students who have spent careers in waterfall or even agile processes may feel uncomfortable. They want to "get it right the first time." The model says: you cannot get it right the first time, because you do not understand the domain well enough until you have designed several use cases. Understanding deepens through iteration.

### Common misconceptions

**1. "The phases are a pipeline."**
Students will try to complete each phase before starting the next. The phases describe a tendency, not a procedure. Phase 2 will send you back to phase 1 repeatedly. Phase 3 will send you back to phase 2. Phase 5 will send you back anywhere. If a student asks "when is phase 1 done?" the answer is: "When the model is done." The philosophy is not complete until the model is complete.

**2. "The use case catalog is just a table of contents."**
The catalog is the entry point for someone new to the model. It frames the primary actor's goals, describes the domain, lists use cases, and provides the bounded contexts table. It answers: who is this for, what problem does it solve, what are the pieces. A table of contents lists files. A catalog tells a story. Show students the wiki-agent USE-CASE-CATALOG.md and ask: "Could a new team member understand the system from this document alone?" The answer should be "enough to navigate, not enough to implement."

**3. "Cross-references are nice-to-have."**
Students may skip cross-references as documentation polish. Cross-references are structural integrity. Every domain event referenced in a use case must exist in DOMAIN-EVENTS.md. Every bounded context referenced must have a file. Every actor must appear in the catalog. A broken reference means something was renamed or removed without updating dependents. It is a model defect, not a style issue. Ask: "If I follow this link, will I find what it promises?"

### Handling the examples

**The wiki-agent USE-CASE-CATALOG.md as entry point.** Start here. Read it aloud (or have a student read it). Follow the links: catalog to use cases, use cases to domain contexts, domain contexts to domain events. Show how the bounded contexts table ties everything together. Count the cross-references. Ask students to trace a single domain event (e.g., FindingFiled) from the catalog to the domain event definition to the producing use case to the consuming use case. This trace demonstrates that the model is navigable.

**The relationship map.** Show the diagram from DOMAIN-MODEL-ARTIFACTS.md. Walk through each arrow. Philosophy encodes into template. Template structures use cases. Use cases reference shared invariants, domain contexts, and domain events. Actor catalog consolidates actors from all use cases. Use case catalog indexes everything. Glossary provides canonical vocabulary. Every arrow is a reference, not a dependency -- any artifact can be read standalone, but the model is richer when read as a whole.

**Backtracking example.** Use the DC-03/DC-04 shared protocol as a concrete case. The "correction assignment" protocol is structurally compatible between Issue Resolution and Drift Detection. This was not designed upfront. It was discovered when UC-04 was designed and the team noticed the corrector agent could be reused. That discovery sent them back to UC-03 to formalize the protocol and extract it. Phase 4 sent them back to phase 2.

### Exercise guidance

Students design a USE-CASE-CATALOG.md for the elevator system covering 3 use cases, 2 bounded contexts, and 3 domain events.

**What good answers look like:**

The catalog should include:
- A framing of the Passenger's goals (from foundation lessons): be on a different floor -- safely, promptly, without trauma, intact.
- A domain description: the domain is vertical transportation in buildings. The core problem is serving competing value conditions (safety, promptness, comfort) under physical constraints (capacity, gravity, maintenance requirements).
- 3 use cases with one-line summaries. Titles are verbs:
  - UC-01: Dispatch Elevator -- Assign an elevator to a passenger's floor request considering current load and position.
  - UC-02: Inspect Elevator -- Conduct safety inspection against regulatory standards, file findings.
  - UC-03: Optimize Schedule -- Adjust elevator allocation based on demand patterns and building occupancy.
- 2 bounded contexts:
  - Passenger Transport: owns the experience of moving between floors. Contains UC-01, UC-03.
  - Safety Compliance: owns the regulatory relationship. Contains UC-02.
- 3 domain events in a bounded contexts table:
  - ElevatorDispatched (Passenger Transport, UC-01)
  - InspectionCompleted (Safety Compliance, UC-02)
  - ScheduleOptimized (Passenger Transport, UC-03)
- Cross-references between contexts showing integration points.

**What to watch for:**
- Use case titles that are nouns instead of verbs. "Elevator Dispatch" is a noun. "Dispatch Elevator" is a verb. Use cases are verbs.
- Domain events named as commands. "DispatchElevator" is a command. "ElevatorDispatched" is a fact.
- Missing the domain description. The catalog is not just a list. It tells a reader what problem this system solves.
- Bounded contexts table missing. The table is what makes the catalog an entry point, not a list of links.
- No cross-references. If the use cases do not reference their bounded contexts, and the contexts do not reference their events, the model is a collection of isolated documents.

**Debrief focus:** Could a new team member pick up this catalog and understand the elevator system well enough to find any artifact? Does the catalog tell a story or just list files?

### Transition (course close)

This is the final lesson in the software engineer track. Close by returning to the foundation: conditional goals drive everything. The Passenger's value conditions (safely, promptly, without trauma, intact) spawned actors, which spawned bounded contexts, which spawned domain events, which became the architecture of an agentic system.

The complete chain:
1. Conditional goal (foundation lesson 1)
2. Actors and drives (foundation lesson 2)
3. Socratic extraction (foundation lesson 3)
4. Use case anatomy (foundation lesson 4)
5. Bounded contexts and domain events (SWE01)
6. Agent architecture from drives (SWE02)
7. The complete model (SWE03)

Every step traces back to what the primary actor values. That is the through-line of the entire curriculum.
