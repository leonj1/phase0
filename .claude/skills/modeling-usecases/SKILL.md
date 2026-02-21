---
name: modeling-usecases
description: Use case lens depth — continuous invariants, goal obstacles with recovery strategies, intent-driven scenarios. Load when structuring interactions, writing scenarios, or challenging use case content.
---

# Use case lens philosophy

Deep principles for use case construction. Builds on the shared vocabulary in grounding-models.

## Invariants are continuous constraints

Domain rules must hold continuously — before, during, and after execution. An actor that violates an invariant mid-scenario has failed, even if the final output looks correct.

Express constraints as invariants that hold at every moment of the interaction.

## Obstacles are threats to the goal

When something goes wrong, describe the threat to goal satisfaction. "Source code is unreachable" tells you what is at risk. Each obstacle includes a recovery strategy: a way to protect the goal or degrade gracefully when it cannot be fully achieved.

## Scenario steps express intent

Scenario steps express what is accomplished. "Wiki content is verified against current source" gives an actor room to find the best path. Step ordering reflects what the actor values — arrange the interaction so that the actor's values are protected at every point.

The actor's job is to satisfy intent. The use case's job is to express it clearly.
