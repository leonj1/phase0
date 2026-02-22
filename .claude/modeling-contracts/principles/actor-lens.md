# Discovering actors

The actor lens discovers who the system serves and why each participant exists. Depth on conditional goals, value conditions, the tensions that spawn supporting actors, actor genealogy, and the single-responsibility principle for actors.

## Goals and drives — examples

Consider an elevator system. The Passenger is the primary actor. Their goal is to be on a different floor — safely, promptly, comfortably, with full physical integrity. The system exists to serve that goal. The desired state is *being there* — presence on the target floor. The conditions on the goal (safely, promptly, intact) are where system design comes from.

The building Owner is a supporting actor — elevators cost money, so someone must own and maintain them. The Owner's drive is economic: minimize maintenance cost. The government Inspector is also a supporting actor, spawned by the conflict between the Owner's economic drive and the Passenger's safety condition. The Inspector's drive is public safety, born from the state's interest in public welfare.

Now consider this system. The User is the primary actor with a goal. The Creator is a supporting actor whose drive is production — fill pages with content. The Proofreader is a supporting actor whose drive is critique — verify accuracy and consistency. The Proofreader exists because accuracy demands a drive beyond the Creator's production orientation.

## Goal conditions create tensions; tensions spawn supporting actors

It is the **conditions** on a primary actor's goal that create tensions. The Passenger wants to be on a different floor *safely*, *promptly*, *with comfort and dignity*. Each condition meets reality and produces a tension. "Safely" collides with the Owner's economic drive to minimize cost. "Promptly" collides with building capacity and demand patterns. Each tension spawns supporting actors with drives that address the gap.

The Passenger's safety condition demands a drive beyond the Owner's cost-minimization — so the Inspector exists, with a drive born from the state's interest in public welfare. Accuracy demands a drive beyond the Creator's production orientation — so the Proofreader exists, with a drive toward critique.

Each actor optimizes for its own drive in good faith. The Owner optimizes for cost. The Creator optimizes for production. A single drive serves one concern. Separation of actors is the structural answer when concerns compete.

Every supporting actor has a genealogy — you can trace *why* they exist back to a tension involving a primary actor's goal. Every actor in the model has a traceable lineage.

Ask "what tension demands this actor, and what drive resolves it?"

## Goal conflicts spawn actors

Supporting actors emerge from tensions between a primary actor's goal and the drives of existing actors.

The Inspector exists because the Passenger's safety condition demands a drive beyond the Owner's economic optimization. The Proofreader exists because accuracy demands a drive beyond the Creator's production orientation. In each case, the supporting actor is born from a specific, nameable conflict.

A new actor earns its place by resolving a tension — a gap between what existing actors optimize for and what the primary actor's goal requires.

## Conditional goals — deep treatment

### Desired state

The end state describes where the actor wants to *be*. "Be on the 5th floor" is a desired state — it keeps the solution space open. If a genie could teleport the Passenger, the goal is satisfied. The state holds regardless of the path.

Apply the gift test: "I want to have a guitar" is a goal — the desired state is possession. "I want to buy a guitar" names a path, and the path is one of many. If someone gifts you the guitar, the goal is satisfied. When a goal statement is satisfied by any path that reaches the desired state, it describes a true goal.

### The conditions are values

"Be on the 5th floor" is the desired state, and the conditions complete it. The Passenger also values their physical integrity. They value their time. They value their psychological comfort. The conditional goal is: be on the 5th floor, safely, promptly, comfortably, with full physical integrity. These conditions are expressions of what the actor **values**. They *are* the goal — a conditional goal includes them.

A Passenger who reaches the 5th floor having lost an arm has failed the conditional goal — physical integrity is part of what they valued, integral to the goal itself.

### Value conditions drive the entire system design

The value conditions shape the system more than the destination does:

- **"Safely"** collides with the Owner's economic drive → spawns the Inspector
- **"Promptly"** collides with building capacity → produces elevator scheduling (why hotels bias upper floors in the morning and offices bias lower)
- **"Comfortably"** demands maintenance standards, emergency protocols, communication during delays
- **"With freedom of movement"** demands redundancy, monitoring, rescue procedures

A value says "I want to retain my physical integrity." A spec says "the elevator decelerates within tolerance." The spec is one implementation of the value. Values keep the solution space open — they can be satisfied in ways a single spec may anticipate only partially. Design from values.

### The derivation chain

Everything in the system traces back to conditional goals:

```
Primary actor
  → conditional goal (desired state + value conditions)
    → value conditions meet reality → tensions
      → tensions spawn supporting actors (each with a drive)
        → system design (invariants, use cases, bounded contexts)
```

Ask "what state of the world does the actor want to be in, and what do they value about being in that state?"

## Single responsibility for actors

Creators write. Researchers explore. Proofreaders review. Orchestrators coordinate. Each actor serves one drive.

This is a corollary of the goal/drive distinction. A primary actor has one goal. A supporting actor has one drive. A Creator's drive is production. A Proofreader's drive is critique. Two actors with distinct drives produce better outcomes than one actor balancing competing concerns — the Creator produces freely, the Proofreader verifies thoroughly.

Separate judgment from execution. Separate analysis from mutation.
