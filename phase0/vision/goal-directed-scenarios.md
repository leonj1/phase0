# Goal-directed scenarios

Traditional use case scenarios describe tasks — a sequence of operations that actors perform. Phase0 scenarios describe interactions shaped by goals. The distinction produces three specific departures from conventional use case modeling.

---

## Invariants are continuous constraints

Traditional use cases have preconditions and postconditions. Preconditions are entry gates — checked once before the scenario begins. Postconditions are exit assertions — verified after the scenario ends. Between entry and exit, anything goes.

Phase0 expresses constraints as invariants — rules that hold continuously, before, during, and after execution. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

An elevator that free-falls for three floors and then catches itself has violated the safety invariant — even though the Passenger arrives at the correct floor. A precondition "elevator is operational" checked at entry would not have caught this. The constraint is continuous: the elevator must be safe at every moment of the journey.

Express constraints as invariants, not as preconditions or postconditions.

---

## Step ordering comes from value, not mechanics

A task-based scenario orders steps by mechanical logic — the sequence in which operations naturally occur. Insert card, enter PIN, select amount, dispense cash, return card. The order follows the machine's workflow.

A goal-directed scenario orders steps by what the actor values. The ATM actor's goal is: *have cash — and still have my card.* Once the cash is in the actor's hand, the goal *feels* achieved. The actor's attention shifts. If the card is still in the machine, the actor walks away without it.

The goal-directed ordering: return the card *before* dispensing cash. The actor cannot forget what they already have.

It is a direct consequence of designing from goals. If you understand what the actor values, you can predict where their attention will be at each step. If you order steps mechanically, you cannot.

The scenario section of a use case expresses intent, not mechanics. But it also orders steps to protect the actor's values at each point — not just at the end.

---

## Obstacles are threats to the goal

Traditional use case modeling describes exceptions and alternate flows. An exception is a branch point — a condition that diverts the scenario to a different path. "If the PIN is incorrect, go to step 3a." The framing is structural: what path does the scenario take?

Phase0 frames failures as goal obstacles. An obstacle is a threat to goal satisfaction. "The actor cannot authenticate" is not a branch point — it is a threat to the actor's goal of having cash. The framing is intentional: what is at risk?

This distinction matters because it changes what you describe. An alternate flow describes a different sequence of steps. A goal obstacle describes what is threatened and how to recover. "Source code is unreachable" tells you what is at risk. "Exit code 128" tells you what branched.

Each obstacle includes a recovery strategy — not a branch to a different path, but a way to protect the goal or degrade gracefully when it cannot be fully achieved. The question is not "where does the flow go?" but "what can still be salvaged?"

---

## Further reading

- [Conditional goals](conditional-goals.md) — the foundation: desired end states coupled with value conditions
- [The design cycle](design-cycle.md) — the three lenses and the feedback loop
- [The Socratic method](socratic-method.md) — the facilitation technique that draws out goals, values, and constraints
