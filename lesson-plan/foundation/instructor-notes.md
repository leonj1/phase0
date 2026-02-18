# Foundation lessons — instructor notes

Facilitation guide for lessons F01 through F04. These notes help you run the workshop, anticipate where students struggle, and land the key insights.

---

## General facilitation approach

You are a facilitator, not a lecturer. The method you teach — Socratic extraction — is the method you use. Ask questions. Let students discover contradictions in their own thinking. Redirect task-oriented answers to intent-oriented ones.

When a student gives a mechanical answer ("the elevator moves to floor 5"), ask: "What state does the passenger want to be in?" When they give a task disguised as a goal ("process the order"), ask: "If someone could skip that step and still get the result, would the actor care?"

The elevator example threads through every lesson. Each lesson reveals more of the system. Do not front-load the full derivation in F01. Let it unfold.

---

## F01: Goals, not tasks

### The aha moment

The moment students realize that "arrive at floor 5" contaminates the goal with a solution path. The passenger does not want to travel. They want to *be there*. If a genie could teleport them, the goal is satisfied.

### Common misconceptions

- **"But the goal IS to ride the elevator."** No. Riding the elevator is one path to the goal. The goal is being on a different floor. Push with the gift test: if you could just appear on floor 5, would you still need the elevator ride?
- **"Value conditions are just acceptance criteria."** They are not bolted on by an engineer. They are expressions of what the actor values. A passenger who reaches floor 5 missing an arm did not achieve their goal — physical integrity was part of what they valued.
- **"Safely is obvious — why state it?"** Because "safely" is where the entire system design comes from. It spawns the Inspector. Without stating value conditions explicitly, you cannot trace the derivation chain. What seems obvious becomes invisible.

### Handling the elevator example

Start simple: "A passenger wants to get to floor 5." Let students accept this. Then challenge it: "Is the goal to get there, or to be there? What's the difference?" Introduce the gift test. Then add value conditions one at a time: safely, promptly, without trauma, intact. Each condition will become a tension in F02 — do not explain this yet. Just plant the seed: "Notice that the destination tells you nothing about system design. The values tell you everything."

### Exercise guidance

The 5 task statements to rewrite (provided in student notes):
1. "Process the customer's payment" → goal: the customer has paid (securely, with confirmation, without excessive friction)
2. "Send the notification email" → goal: the recipient knows what happened (promptly, reliably, without ambiguity)
3. "Deploy the application to production" → goal: the new version is running in production (without downtime, without data loss, reversibly)
4. "Run the backup script" → goal: the data is protected against loss (completely, recoverably, without impacting live operations)
5. "Authenticate the user" → goal: the system knows who the user is (reliably, without excessive friction, without exposing credentials)

Good rewrites state a desired end state, not a process. Value conditions vary — accept any that express what the actor genuinely values. If a student writes "the payment is processed," push back: that's still a task verb wrapped in passive voice. "The customer has paid" is a state.

### Transition to F02

End with: "Now you can state goals and name value conditions. Next lesson, we ask: what happens when those value conditions meet reality? The answer is where actors come from."

---

## F02: Actors and drives

### The aha moment

The moment students realize that the Inspector does not exist because "regulations require inspections." The Inspector exists because the Passenger's safety value collides with the Owner's economic drive to minimize cost. That tension *demands* resolution by a party whose drive is public welfare. The regulation is an implementation detail. The tension is the modeling concept.

### Common misconceptions

- **"The Owner is a bad actor."** No. The Owner is not trying to hurt passengers. But a single drive (economic interest) cannot serve competing concerns (economy AND safety). Separation of actors is the structural answer to conflicts of interest. This is not about malice — it is about structural insufficiency.
- **"Can't the Owner just be responsible for safety too?"** They can try. But an actor with two competing drives will compromise between them. The Owner optimizing for both cost AND safety will do both poorly. Two actors with opposing drives produce better outcomes than one actor trying to balance competing concerns.
- **"Drives are just job descriptions."** A job description says what you do. A drive says what you optimize for — and therefore where you fall short. A Creator's drive is production. You know they will optimize for coverage, not accuracy. That prediction is the power of drives.

### Handling the elevator example

Build the derivation chain step by step. Start with the Passenger's conditional goal. Take "safely" first — ask: "Who else is involved when safety is at stake?" Students will say "maintenance" or "the building." Push deeper: "Why does maintenance exist? What tension created it?" Lead them to the Owner (elevators cost money → economic drive). Then: "The Owner wants to minimize cost. The Passenger wants to be safe. What happens when those collide?" Lead them to the Inspector.

Draw the derivation chain on the board:

```
Passenger (primary)
  → safely (value condition)
    → collides with Owner's economic drive
      → tension demands Inspector (drive: public safety)
```

Then do the same for "promptly" → Scheduler. The derivation chain diagram from VISION.md is your teaching tool.

### Exercise guidance

Students should produce something like:

| Actor | Type | Drive | Spawned by |
|-------|------|-------|------------|
| Passenger | Primary | Goal: be on a different floor — safely, promptly, without trauma, intact | — |
| Owner | Supporting | Economic interest (minimize cost) | Elevators cost money; someone must own them |
| Inspector | Supporting | Public safety | Tension: Owner's cost-minimization vs. Passenger's safety value |
| Scheduler | Supporting | Efficiency (optimize throughput) | Tension: Passenger's promptness value vs. building capacity |
| Emergency responder | Supporting | Rescue (restore passenger safety) | Tension: Passenger's "without being trapped" value vs. mechanical failure |
| Maintenance technician | Supporting | Reliability (prevent failure) | Tension: Passenger's safety + Owner's economic drive (deferred maintenance) |

Accept variations. The key test: can each supporting actor trace its genealogy to a specific value condition? If a student proposes an actor but cannot trace it, the actor does not belong in the model.

### Transition to F03

End with: "You derived actors from value conditions. But you did it analytically — from a description I gave you. In practice, nobody hands you the actor list. You extract it through conversation. That's next."

---

## F03: Socratic extraction

### The aha moment

The moment students realize that the domain expert knows far more than they can articulate unprompted. The 15-minute interview produces actors, goals, and tensions that the expert didn't think to mention. Targeted questioning extracts what "tell me about your system" never would.

### Common misconceptions

- **"I need to understand the domain before I can ask good questions."** No. You need to understand the *method*. The domain expert understands the domain. Your job is to structure what they know. The facilitator asks: "What state do you want to be in?" The expert has the answer — they just haven't framed it that way.
- **"Contradictions mean someone is wrong."** Contradictions are gold. When Alice says "shipment" means "what leaves the warehouse" and Bob says "shipment" means "what the customer ordered," you have discovered a context boundary. Do not resolve it by picking a winner. Name both meanings.
- **"Noun refinement is just renaming things."** It is discovering that what you thought was one concept is actually two. "Customer" is not renamed to Sender — the Sender is extracted from "Customer" because Sender has a distinct goal. The qualifier ("customer who sends things") vanishes when the noun absorbs it.

### Handling the interview exercise

Before the exercise, demonstrate noun refinement live using the elevator system's "passenger" example. Start with "passenger." Note that a driver is technically a passenger — the operator passenger. Qualify: "operator passenger." Refine: drop the qualifier by absorbing it into a new noun — "Driver." Now Driver and Passenger are standalone nouns with distinct goals.

For the paired exercise:
- Circulate and listen. If an interviewer is asking "what features does your system have," redirect: "Try asking what state the actor wants to be in."
- If a pair gets stuck, suggest the Round 3 question: "What keeps you up at night about this system?" Tensions are often easier to discover than goals.
- Remind interviewers: you are extracting, not inventing. If you are suggesting actors, you have switched from facilitator to designer.

### Exercise debrief

Ask each pair to share:
1. Who are the primary actors and what are their conditional goals?
2. Did any supporting actors emerge? What tensions spawned them?
3. Where did contradictions appear?

Highlight pairs where the interview produced something the expert hadn't thought of. That is the method working.

### Transition to F04

End with: "You can now discover goals, actors, and drives through conversation. Next, we learn the container that holds what you discover — the use case template."

---

## F04: Anatomy of a use case

### The aha moment

The moment students see that obstacles are not error handling — they are threats to the actor's goal, with recovery strategies that try to preserve what the actor values. "Developmental editor fails — synthesis cannot be completed" is a threat. "Commissioning orchestrator reports planning failure. Stops. User retries." is a recovery strategy. The pattern is: what is at risk, and what can be preserved.

### Common misconceptions

- **"Scenario steps should describe the implementation."** No. "Commissioning orchestrator collects all exploration reports" (intent) gives the actor room to find the best path. "Orchestrator iterates through the researcher results cache" (mechanics) prescribes a specific implementation that will break when the architecture changes.
- **"Invariants are just preconditions you check at the start."** Invariants hold continuously. "Source code is readonly" is not checked once — it must hold during every step. An actor that writes to the source repo mid-scenario has violated the invariant, even if it restores the original state.
- **"Domain events are return values."** Domain events are meaningful state transitions. "WikiPopulated" is not a return value from a function — it is a published fact that other bounded contexts react to. It crosses boundaries.

### Handling the template walkthrough

Use UC-01 Populate New Wiki as your concrete example. For each template section:

- **Goal** — point out "empty wiki → complete documentation grounded in source code." This is a desired state, not a task. It passes the gift test.
- **Context** — note bounded context, primary actor (User), supporting actors, and trigger. Trigger is what prompts the goal pursuit, not what starts the code.
- **Actor responsibilities** — show how each actor owns one concern. Commissioning orchestrator coordinates. Researchers explore. Developmental editor synthesizes. Creators write. No actor has two jobs.
- **Invariants** — highlight "new wikis only" and "source code is single source of truth." These hold continuously.
- **Success/failure outcomes** — note that failure outcomes describe what is preserved, not what went wrong.
- **Scenario** — walk through 3-4 steps. Point out intent language. Note the domain event arrow (→ WikiPopulated).
- **Obstacles** — show the partial-completion obstacle. Recovery: successful pages remain, report identifies failures.
- **Domain events** — WikiPopulated: what it means, who cares.
- **Protocols** — show the explorer report and wiki plan protocols. Input, output, who owns each side.

### Exercise guidance

For the elevator "transport passenger" use case, students should produce something like:

**Goal:** Passenger is on the requested floor — safely, promptly, without trauma, with physical integrity preserved.

**Invariants:**
- Maximum occupancy is never exceeded
- Emergency stop is always available
- Door does not open between floors

**Scenario (intent, not mechanics):**
1. Passenger indicates desired floor
2. Elevator transports passenger to requested floor (safely, without exceeding speed limits, without free-fall)
3. Passenger exits on requested floor

**Obstacles:**
- Step 2a: Mechanical failure during transport. Elevator stops safely between floors. Emergency communication activates. Emergency responder dispatched. Passenger is extracted safely.
- Step 2b: Power failure. Emergency power engages. Elevator completes travel to nearest floor. Doors open.

Push back on mechanical scenario steps. If a student writes "elevator motor engages, cables pull car upward, brakes release," redirect: "What is accomplished? The passenger is transported. How it happens is the elevator's business, not the use case's."

### Transition to track lessons

End with: "You now have the full conceptual toolkit — goals, actors, drives, extraction, and the template. The next three lessons apply these ideas to your discipline."
