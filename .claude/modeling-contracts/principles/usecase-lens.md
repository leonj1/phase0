## Use case lens

The use case lens examines what interactions the design demands. Depth on continuous invariants, goal obstacles with recovery strategies, intent-driven scenarios, step ordering by value, actor responsibilities, and observable outcomes.

## Use cases are discovered, not invented

Use cases fall out of actors, goals, and tensions. "The Dispatcher assigns routes" is not something you design — it is something the domain experts have been doing, and now you have given it a name. The use case lens examines the actors, goals, and tensions produced by the actor lens and asks: what does the system actually need to do?

Each use case describes one goal pursued by one primary actor. It is a desired end state and the conditions under which that state is achieved, threatened, or failed.

## Goals are desired states

A use case goal is a state of the world the actor wants to exist in. "The wiki is populated with accurate documentation" is a goal — it describes a desired state. "Run the documentation pipeline" names a mechanism, and mechanisms change. Goals survive model upgrades, tool rewrites, and prompt changes.

Apply the gift test from the actor lens: if someone could magically produce the desired state, would the actor be satisfied? "A complete, well-structured set of documentation pages that accurately reflect the source code" passes the gift test — the actor does not care whether researchers or creators or a single monolithic script produced it. "Execute the init-wiki command" fails the gift test — it names a path, not a destination.

Goal statements include the value conditions that matter. "The wiki is ready for human review — every page serves the configured audience in the configured tone, and no page exists for a feature that does not exist in the source." The conditions after the dash — audience, tone, no speculative content — are the values the actor holds. They constrain the solution space without prescribing a solution.

## Invariants are continuous constraints

Traditional use cases have preconditions and postconditions. Preconditions are entry gates — checked once before the scenario begins. Postconditions are exit assertions — verified after the scenario ends. Between entry and exit, anything goes.

Phase0 expresses constraints as invariants — rules that hold continuously, before, during, and after execution. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

An elevator that free-falls for three floors and then catches itself has violated the safety invariant — even though the Passenger arrives at the correct floor. A precondition "elevator is operational" checked at entry would not have caught this. The constraint is continuous: the elevator must be safe at every moment of the journey.

"Source code is the single source of truth" is not a gate at step 1 — it governs every step where content is produced. A creator that reads source code at step 5 but writes from training data at step 11 has violated the invariant, even though the precondition was technically satisfied.

### Structural invariants vs. behavioral invariants

Some invariants describe structural truths about the system: "Source clones are reference material. No use case may stage, commit, or push to a source repo." This invariant holds because the architecture enforces it — the source repo is readonly by design.

Other invariants describe behavioral expectations: "Every claim in a wiki page must be grounded in the actual source code. No page may be authored from the agent's training data alone." This invariant depends on the actor following the rule. Both kinds appear in the Invariants section. Both must hold continuously.

### Invariants have scope and migrate

An invariant applies to specific use cases. "New wikis only — the wiki directory must contain no content pages" applies to populate-new-wiki but not to sync or revise. "Source repo is readonly" applies across four use cases. The invariant's scope section names where it holds. If an invariant applies everywhere, it is a system-level truth.

Invariants migrate. A constraint stated in one use case turns out to apply to another. Extract it to a shared invariant the second time it appears. Replace the duplicates with references.

### Writing invariants

Express constraints as invariants that hold at every moment of the interaction. State what must be true, not what to check. "No page exists for a feature that does not exist in the source" is an invariant. "Verify that all pages correspond to real features" is an implementation step masquerading as a constraint.

## Obstacles are threats to the goal

Traditional use case modeling describes exceptions and alternate flows. An exception is a branch point — a condition that diverts the scenario to a different path. "If the PIN is incorrect, go to step 3a." The framing is structural: what path does the scenario take?

Phase0 frames failures as goal obstacles. An obstacle is a threat to goal satisfaction. "The actor cannot authenticate" is not a branch point — it is a threat to the actor's goal of having cash. The framing is intentional: what is at risk?

This distinction matters because it changes what you describe. An alternate flow describes a different sequence of steps. A goal obstacle describes what is threatened and how to recover. "Source code is unreachable" tells you what is at risk — comprehension cannot happen, so the downstream plan will be uninformed. "Exit code 128" tells you what branched.

### Obstacles are keyed to scenario steps

Each obstacle names the step it threatens, using a letter-suffix convention: Step 2a, Step 2b, Step 5a. The step number anchors the obstacle in the interaction timeline. The letter distinguishes multiple obstacles at the same step. When reading an obstacle, you know exactly where in the scenario it can occur.

### Recovery strategies

Each obstacle includes a recovery strategy — not a branch to a different path, but a way to protect the goal or degrade gracefully when it cannot be fully achieved. The question is not "where does the flow go?" but "what can still be salvaged?" Recovery strategies fall into patterns:

- Stop and report. The goal cannot be satisfied from this state. Tell the user what happened and what to do. "Reports that no workspace exists and directs the user to run `/up` first." The actor stops. No partial output is produced.

- Degrade gracefully. Part of the work can proceed. "Proceeds with the reports that succeeded. The gaps are visible to the user during plan approval, where they can account for missing coverage by adjusting the plan." The goal is partially satisfied and the user knows what is missing.

- Retry then fallback. Try again, and if that fails, fall to a different output path. "Retries the failed proofreader once. If the retry fails, records the failure. Findings from other proofreaders proceed through the pipeline." The system tries to self-heal, then degrades gracefully.

- Alternative path. Route to a different mechanism that satisfies the same goal. "Writes all findings as local fallback files, one file per finding, using the issue frontmatter format." The durable output still exists — just in a different location.

The recovery strategy tells the next actor in the chain what to expect. If a researcher fails and the orchestrator degrades gracefully, the downstream editor receives incomplete input and must be told what is missing.

### Writing obstacles

Name the threat, not the mechanism. "One or more researchers fail to produce a report" names the threat — comprehension of some source facets is lost. Describe the observable failure state, then describe recovery. If the obstacle is unrecoverable, say so — the actor stops and reports.

## Scenario steps express intent

Scenario steps express what is accomplished, not how. "Wiki content is verified against current source" gives the actor room to find the best path. "Run `diff` between the source hash and the wiki hash" prescribes a mechanism. Mechanisms change — the intent survives.

### Step ordering comes from value, not mechanics

A task-based scenario orders steps by mechanical logic — the sequence in which operations naturally occur. Insert card, enter PIN, select amount, dispense cash, return card. The order follows the machine's workflow.

A goal-directed scenario orders steps by what the actor values. The ATM actor's goal is: *have cash — and still have my card.* Once the cash is in the actor's hand, the goal *feels* achieved. The actor's attention shifts. If the card is still in the machine, the actor walks away without it.

The goal-directed ordering: return the card *before* dispensing cash. The actor cannot forget what they already have.

Step ordering is a design decision, not a chronological accident. When two steps could occur in either order, the ordering reveals which value takes priority. If the actor values safety, verification steps come before production steps. If the actor values user control, approval gates come before irreversible actions. "The user refines it through iterative conversation until satisfied. No pages are written until the user approves the plan." User control is protected before production begins.

### Actor attribution

Every step names the actor responsible. "actors/03-commissioning-orchestrator — Dispatches researchers to comprehend the source code from distinct angles." The actor attribution makes the produce/consume chain visible. When you read a scenario, you can trace who produces what and who consumes it.

### Domain events mark transitions

Domain events appear inline in the scenario using the `-->` marker. "--> WikiPopulated" signals that the scenario has crossed a meaningful boundary. The event is the fact — something happened that other use cases or bounded contexts may care about.

Published events get their own files in `events/`. Internal events coordinate within the use case and are defined only in the Domain events section. The distinction matters: published events are contracts with the rest of the system. Internal events are coordination mechanisms.

## Actor responsibilities define the produce/consume chain

The Actor responsibilities section makes the internal data contracts explicit. Each entry names what the actor owns, what it produces, and what it consumes. "Consumes explorer reports produced by researchers. Produces the wiki plan consumed by the commissioning orchestrator." This is a data flow declaration — it tells you where information enters and exits each actor's scope.

Actor responsibilities also declare what judgment the actor applies — and what it does not. "The commissioning orchestrator makes no editorial judgments — it delegates comprehension to researchers, synthesis to the developmental editor, and production to creators." The boundary is explicit. An orchestrator that starts editing content has violated its declared responsibility.

## Success and failure outcomes are observable states

Success and failure outcomes describe the observable state of the world after the use case completes. They do not describe internal state or implementation details. "The wiki directory contains a complete set of documentation pages" is observable — someone can check this. "The internal cache was properly cleaned" is an implementation concern.

Failure outcomes describe what is preserved and what the user is told. Partial failure is distinct from total failure. "If failure occurs during writing, successfully written pages remain on disk. The user is told which pages were written and which failed." The system degrades visibly — the user is never left guessing.
