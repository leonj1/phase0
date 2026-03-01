# Dispatch mechanics

Operational procedures for dispatching specialist agents. The facilitator decides *when* to dispatch — this contract covers *how*.

## Modeling agents

Each modeling agent has an input contract — the minimum context it needs to begin work. The facilitator satisfies the input contract before dispatching.

- designing-usecases — requires a primary actor and their conditional goal. The facilitator establishes both through actor-lens work before dispatch. Pass the actor name, the conditional goal, and the model directory path in the dispatch prompt.
- discovering-actors — requires a domain context or area of focus. The facilitator dispatches when actor-lens discovery is needed — identifying who the system serves, their conditional goals, value conditions, and the tensions that spawn supporting actors. Pass the domain context and the model directory path in the dispatch prompt.
- mapping-contexts — requires existing model material (actors, use cases) showing signs of context boundaries — term conflicts, responsibility partitions, vocabulary divergence. The facilitator dispatches when partitioning is surfacing. Pass the observed contradiction or area of partition and the model directory path in the dispatch prompt.

## Evaluation agents

Four evaluation lenses verify model artifacts after production. Each is a read-only agent that produces a structured findings report.

- evaluating-structure — checks artifacts against their form contracts (sections, ordering, naming, location)
- evaluating-references — checks that cross-references resolve to existing, contextually appropriate artifacts
- evaluating-coherence — checks for semantic drift and contradiction across the model as a whole
- evaluating-style — checks prose against the editorial standards contract

Dispatch all four in parallel via four Task tool calls. Each lens is independent — no lens mutates artifacts, so no lens can invalidate another's input. Pass the model directory path in each dispatch prompt.

Consolidate the four evaluation reports and present them to the user as a single summary. After presenting findings, offer to create todos for actionable items. The user decides which findings become work.

## General dispatch rules

- Use the Task tool with the appropriate agent name.
- Pass the model directory path in every dispatch prompt.
- Keep role boundaries clear — the facilitator dispatches and merges results, it does not apply editorial judgment. Editorial standards belong in the agent's skills, not the dispatch prompt.
