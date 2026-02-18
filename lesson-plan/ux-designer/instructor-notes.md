# UX designer track: instructor notes

Lesson-by-lesson guidance for instructors. Each section covers the target "aha moment," common misconceptions, how to handle the examples and case study, exercise guidance, and the transition to the next lesson.

---

## UX01: Value conditions and the design space

### The aha moment

The moment students realize that value conditions -- not features, not specs, not requirements -- drive design. "Floor 5" tells you nothing about design. "Safely, promptly, without trauma" tells you everything. Every design decision in a well-designed system traces back to a value condition on a primary actor's goal.

Watch for the shift. Students arrive thinking about features. The aha happens when someone says something like: "So the entire notification system exists because of the 'without trauma' value -- the passenger needs to know what is happening." That is the moment. Reinforce it.

### Common misconceptions

**1. "Value conditions are user requirements."**

No. Value conditions are what the user values. Requirements are derived from values. The value "I don't want to lose my limbs" generates requirements about speed limits, brake systems, redundancy. But designing from the value keeps options open that requirements close. A requirement says "install redundant brakes." The value admits redundant brakes, speed governors, airbags, parachute systems, or slow-speed-only designs. Requirements are one implementation of a value. Designing from values keeps the solution space open. Designing from requirements closes it.

If a student writes "the system must respond within 2 seconds" as a value condition, redirect. The value is "promptly" or "without wasting my time." The 2-second SLA is a spec that implements the value.

**2. "The goal hierarchy is just personas with extra steps."**

Cooper's goal hierarchy (life goals, experience goals, end goals) is not a persona template. Personas describe who someone is. The goal hierarchy describes what they want to be, how they want to feel, and what they want to accomplish -- and critically, each level drives different design decisions. Life goals shape brand and positioning. Experience goals shape interaction patterns. End goals shape features. If students collapse all three into "user needs," push back. Ask: "Which level is that? What kind of design decision does it drive?"

**3. "Actor refinement is just making personas more specific."**

Actor refinement is not about specificity. It is about separation. The point of the qualify-refine-separate cycle is to reach standalone nouns with singular goals or drives. "Customer who sends things" and "customer who receives things" have different goals -- the Sender wants the package to be there; the Recipient wants the package to be in their possession. Those are different conditional goals with different value conditions. Collapsing them into "Customer" hides a design-critical distinction. The test is: do these two actors have the same goal with the same value conditions? If not, they are separate actors.

### Handling the case study

The wiki-agent User's goal hierarchy is the anchor. Show it from the actor catalog:

- **Life goals:** Be a responsible steward of the project's knowledge (effectiveness and autonomy).
- **Experience goals:** Feel confident the wiki is accurate. Feel in control -- no surprises from autonomous agents. Feel that the system respects their judgment.
- **End goals:** Wiki is accurate, is current, reflects the source.

Then trace experience goals to design decisions. "Feel in control" led to plan approval before content is written (UC-01). "Feel confident" led to post-hoc review via git diff (UC-04) rather than blind trust in autonomous corrections. "System respects their judgment" led to type-to-confirm before destructive actions (UC-06). Each experience goal produced a specific interaction pattern. That is the derivation chain in action.

Do not get lost in the wiki-agent's technical details. Students do not need to understand GitHub issues or git diffs. They need to see that experience goals drove interaction design decisions.

### Exercise guidance

**What good answers look like:**

A strong answer names a genuine value (not a disguised spec), and traces it to a visible design decision. Example: "I value not feeling lost when using Google Maps. That value drives the persistent blue dot, the auto-recentering, and the 'you have arrived' confirmation. All three features exist because of the same value condition."

A weak answer names a feature as a value: "I value the blue dot on Google Maps." That is a feature, not a value. Redirect: "What does the blue dot give you? What would you lose without it?"

**How to debrief:**

Go around the room. For each example, ask: "Is that a value or a spec?" Apply the test: does the stated value condition admit multiple design solutions, or does it describe one? If it admits only one, it is a spec. If it admits many, it is a value.

Highlight the best example of a violated value condition. This is where design improvement lives -- in the gap between what the user values and what the product delivers.

### Transition to UX02

Close with this: "You now know that value conditions drive design. But values do not exist in a vacuum. They collide with reality. Next lesson, we look at what happens at those collision points -- and why the resulting tensions are the most generative force in system design."

---

## UX02: Tension mapping and actor genealogy

### The aha moment

Tensions are not problems to fix. They are the generative force of system design. The Owner's cost-minimization drive is not a bug. It is the tension that, combined with the Passenger's safety value, demands the Inspector's existence. Without the tension, the Inspector has no reason to exist. Without the Inspector, the Passenger's safety value is unprotected.

Watch for the shift from "tension = problem" to "tension = design force." It often happens when a student maps a tension and realizes that removing the tension would remove a critical actor. "If the Owner didn't minimize cost, we wouldn't need the Inspector -- but then who protects safety?" That is the moment.

### Common misconceptions

**1. "Tensions mean the system is broken."**

Tensions are healthy. They are the forces that produce well-designed systems. A system with no tensions has no supporting actors -- and no protection against single-drive failure. If one actor's drive could serve all concerns, there would be no need for other actors. The elevator system with only an Owner and a Passenger is a system where cost-minimization is unchecked. The Inspector exists because the tension between cost and safety is real, permanent, and productive.

If a student tries to "resolve" a tension by eliminating one side, push back. Ask: "What happens to the system if you remove that force?" The answer is always: an unprotected value condition.

**2. "Every tension needs exactly one new actor."**

Not always. Some tensions are resolved by existing actors whose drives already cover the concern. Some tensions spawn multiple actors. Some actors are spawned by the intersection of multiple tensions. The Scheduler in the elevator system is spawned by the "promptly" value colliding with building capacity -- but a more complex system might have a Scheduler spawned by both "promptly" and "without trauma" (managing crowd flow to prevent overcrowding, which is both an efficiency concern and a comfort concern).

The test is not "one tension, one actor." The test is: does this tension demand a drive that no existing actor possesses? If yes, a new actor. If an existing actor's drive already covers it, no new actor is needed.

**3. "Actor genealogy is just stakeholder mapping."**

Stakeholder maps ask "who is affected." Actor genealogy asks "why does this actor exist." The answer must trace to a specific value condition on a specific primary actor's goal. "The Inspector is a stakeholder in elevator safety" is stakeholder mapping. "The Inspector exists because the tension between the Passenger's safety value and the Owner's cost-minimization drive demands a party whose drive is public welfare" is actor genealogy. The genealogy explains the actor's existence. The stakeholder map merely lists their presence.

### Handling the case studies

Run the elevator and wiki-agent examples side by side to show the same pattern in two domains.

**Elevator:**
- Passenger's "safely" + Owner's cost drive = Inspector (public safety drive)
- Passenger's "promptly" + building capacity = Scheduler (efficiency drive)

**Wiki-agent:**
- User's accuracy value + Creator's production drive = Proofreader (critique drive)
- Show that four proofreading lenses exist because a single critique pass cannot catch everything. Structure problems (whole-wiki organization), line problems (sentence-level clarity), copy problems (formatting and terminology consistency), and accuracy problems (claims vs. source code) require different reading strategies. This is separation of concerns within a single drive -- the critique drive applied through four distinct lenses.

The parallel is: in both systems, a single drive (economic, production) is insufficient to protect a value condition (safety, accuracy). A new actor with a complementary drive is the structural answer.

Do not overload the wiki-agent details. The students need to see the pattern (value + existing drive = tension -> new actor with new drive), not memorize the wiki-agent's architecture.

### Exercise guidance

**What good answers look like:**

A complete tension map for the elevator system. The minimum set:

| Value condition | Collides with | Tension | Actor spawned | Drive |
|----------------|--------------|---------|---------------|-------|
| Safely | Owner's cost-minimization | Cost-cutting could compromise safety | Inspector | Public safety |
| Promptly | Building capacity and demand patterns | More passengers than elevators can serve efficiently | Scheduler | Efficiency |
| Without trauma | Mechanical wear, power failures | Equipment can fail mid-ride | Maintainer (or similar) | Reliability |
| Intact (limbs) | Door mechanics, movement physics | Moving machinery can injure | (May fold into Inspector or spawn a Safety Engineer) | Harm prevention |

Accept variation in actor names. The point is the genealogy, not the label. If a student maps "without trauma" to a Maintainer whose drive is reliability, that is valid. If they map it to the Inspector, ask: "Is public safety the same drive as reliability? Could one actor serve both, or do they optimize for different things?"

**How to debrief:**

Focus on genealogies. For each actor in each student's map, ask: "Trace it back. Which value condition on which primary actor's goal demanded this actor?" If the student cannot trace the lineage, the actor may not belong in the model.

Discuss the edge cases: actors that serve multiple tensions, tensions that fold into existing actors, and -- most interesting -- tensions that reveal system boundaries. "The 'without trauma' tension might mean we need a separate maintenance context from an inspection context." That is a bounded context boundary discovered through tension mapping.

### Transition to UX03

Close with this: "You now know how to map tensions and trace actor genealogies. But in a real project, you do not start with a neat list of value conditions. You start with a room full of domain experts who disagree about what the system even is. Next lesson, we learn the facilitation method that extracts all of this from conversation."

---

## UX03: From discovery to design

### The aha moment

The historian captures what is not ready to become an artifact. "Alice's insight: 'we don't track packages, we track promises'" -- this raw material may never become a formal artifact, but losing it would be a loss. The historian preserves the seeds that formal processes would discard.

Watch for the moment when a student (especially the one playing historian) captures something that surprises the domain expert. The domain expert says something offhand. The historian writes it down. Later, the group realizes it was the most important thing said in the session. That is the aha -- the historian's value is capturing what nobody else recognized as important in the moment.

### Common misconceptions

**1. "The facilitator needs to be a domain expert."**

The facilitator needs to know the method, not the domain. In fact, domain expertise can be a liability. An expert facilitator may project their own model onto the domain instead of extracting the domain expert's. The facilitator's job is to ask "why" and "what keeps you up at night" -- not to answer those questions. A facilitator who already knows the domain tends to skip questions whose answers they think they know. Those skipped questions are where the surprises live.

If students resist this, point to the Socratic method itself. Socrates did not claim to know the answers. He claimed to know the questions. That is the facilitator's role.

**2. "The four rounds are sequential steps."**

The four rounds are lenses, not a pipeline. In practice, Round 3 ("What goes wrong?") will send you back to Round 2 ("Who touches this?") because a tension revealed a new actor. Round 2 will send you back to Round 1 ("What is this thing?") because a new actor redefined the system boundary. This is correct. The rounds describe what you are looking at, not what order you look at things.

If a group's exercise session follows the rounds in strict order, they probably did not go deep enough. Backtracking is a sign of depth, not failure.

**3. "The historian just takes meeting minutes."**

Meeting minutes record what happened. The historian records what matters -- and the distinction is critical. The historian captures decisions (not just discussions), contradictions (not just statements), new terms (not just conversations), open questions (not just answers), and raw insights (not just conclusions).

The test: if you read the historian's notes six months later, can you reconstruct not just what was decided, but why, what was debated, and what remains open? Meeting minutes fail this test. Historian notes pass it.

### Handling the demonstration

The side-by-side comparison (historian captures vs. specialist output) is the heart of the demonstration. Use the table from the vision document:

| Historian writes | Specialist writes |
|-----------------|-------------------|
| "We discussed splitting Customer into Sender and Recipient" | ACTOR-CATALOG.md entry for Sender |
| "Open question: does Driver belong in Logistics or Fleet?" | DC-03-fleet-management.md |
| "Contradiction: 'shipment' means different things to warehouse and delivery" | GLOSSARY.md entries |
| "Decision: bounded context boundary between Warehouse and Logistics" | Domain context definitions |
| "Alice's insight: 'we don't track packages, we track promises'" | Nothing -- raw material, not yet an artifact |

Linger on the last row. That insight might become a design principle. It might become a domain narrative. It might remain a note forever. The point is that formal processes have no place for it -- but the historian does.

### Exercise guidance

**Setup (5 min before the exercise):**

- Groups of 3. One domain expert, one facilitator, one historian.
- The domain expert picks a domain they know well. Their workplace is ideal, but a hobby, a sport, or a system they use daily all work.
- Give the facilitator a cheat sheet: Round 1 (what is this?), Round 2 (who touches it?), Round 3 (what goes wrong?), Round 4 (what use cases emerge?). Remind them: these are lenses, not steps.
- Give the historian a capture template: decisions, contradictions, new terms, open questions, raw insights. Each entry gets a timestamp (approximate is fine).

**What to watch for during the exercise:**

- Facilitators who lecture instead of ask. Redirect: "You are asking questions, not giving answers."
- Historians who stop writing. Nudge: "What did the domain expert just say that was new?"
- Domain experts who describe solutions instead of problems. The facilitator should catch this, but intervene if needed: "That is how you do it today. What would happen if you could not do it that way?"
- Groups that never backtrack. They are probably being too orderly. Ask: "Did anything in Round 3 change who you identified in Round 2?"

**What good output looks like:**

At minimum, the group should surface:
- 1--3 primary actors with conditional goals (desired state + at least 2 value conditions each)
- 2--5 tensions (value conditions colliding with reality)
- 1--3 supporting actors with traceable genealogies
- 3+ historian notes that are not yet ready to become artifacts

The historian's notes are the most important output. Good historian notes contain at least one contradiction, one open question, and one raw insight.

**How to debrief:**

Have each historian read their notes aloud. Not the facilitator -- the historian. This reinforces that the historian captured the process, not just the conclusions.

Ask each group:
- "How many times did you backtrack?" (Zero means they went too linearly.)
- "What did the historian capture that the facilitator missed?" (This surfaces the historian's unique value.)
- "Which raw insight feels most important but is least ready to become an artifact?" (This is where future design lives.)

### Transition (closing the track)

Close the track with this: "You now have three tools. Value conditions open the design space. Tension mapping populates it with actors. Phase0 discovery extracts both from real domain experts. These are not UX research replacements -- they are UX research amplifiers. The next time you sit with a user and they describe what they want, listen for values, not features. Listen for tensions, not complaints. And write down the things that are not ready to become anything yet -- because those are the seeds."
