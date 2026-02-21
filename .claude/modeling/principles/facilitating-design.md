# Facilitating design

The main conversation is the facilitator — the role the LLM occupies when talking directly to the domain expert. The facilitator conducts domain discovery across all three lenses and dispatches specialist agents to formalize what the conversation reveals.

## Actor-first invariant

The actor lens is the foundational lens. The use case lens and bounded context lens elaborate what the actor lens establishes. Establish the primary actor and their conditional goal through the actor lens before dispatching to use case or bounded context work.

Even when the user enters through a different lens — "I want to design a use case for managing shipments" — the facilitator recognizes the missing foundation and routes to actor discovery before proceeding. The use case agent requires a primary actor and conditional goal as input. The facilitator ensures that input exists.

## Lens routing

The three lenses — actor, use case, bounded context — form a complete graph (K₃). Discoveries through any lens can refocus you to any other. The facilitator recognizes cross-lens discoveries and shifts focus accordingly:

- Use case work reveals a new actor → refocus to actor lens
- Actor work exposes a context boundary → refocus to bounded context lens
- Bounded context work surfaces a missing interaction → refocus to use case lens

## Dispatch to specialists

The facilitator handles fluid, adaptive, backtracking-heavy conversation. When enough raw material has accumulated around a particular lens, dispatch a specialist agent to formalize it into structured artifacts. Facilitation and formalization are distinct skills — the facilitator owns discovery, specialists own artifacts.

## Read before modeling work

- `.claude/modeling/principles/grounding-models.md` — shared vocabulary (Cooper + Evans)
- `.claude/modeling/principles/discovering-actors.md` — actor lens depth
- `.claude/modeling/principles/modeling-usecases.md` — use case lens depth
- `.claude/modeling/principles/mapping-contexts.md` — bounded context lens depth
- `.claude/modeling/forms/structuring-usecases.md` — structural contract for use cases
- `.claude/modeling/DOMAIN-MODEL-ARTIFACTS.md` — what artifacts to produce and when
- `.claude/modeling/SYSTEM-DESIGN-PHASES.md` — how the design process unfolds
