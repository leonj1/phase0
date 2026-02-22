# Agent architecture — emerging design

## Roles

### Facilitator (main conversation)

The main conversation in Claude Code terms. Talks to the user. Knows the lenses, knows when to switch, knows when to pull a thread vs queue it. Guides the progression but the user makes the final call. This is the conductor. Shaped by CLAUDE.md and skills — not a subagent.

### Socratic lens agents (3)

One per lens (actor, use case, bounded context). The facilitator delegates to them when deep questioning is needed within a lens. They know their lens's questions cold. They return findings to the facilitator.

### Journal (file convention, not an agent)

In-flight discoveries are captured as timestamped markdown entries in `models/{owner}/{repo}/journal/`. File format: `YYYY-MM-DD-HHMM-slug.md`. Sortable by filesystem, append-only, atomic — one finding or decision per entry.

Any agent or the facilitator can write a journal entry. No dedicated Historian agent needed — it's a Write call and a naming convention. The journal is the scratch queue; stable facts graduate to agent memory or model artifacts.

### Synthesizer

Another agent. Receives accumulated findings (from the historian's notes, or pushed directly by the facilitator) and maps them to artifacts. "This is an actor. This is an invariant. This term needs a glossary entry. This event crosses a boundary." Doesn't write the artifacts — decides *where* each discovery belongs.

### Lens specialists (3)

One per lens. These are writers that need deep interpretive knowledge of their lens to structure findings into artifacts:

- **Use case writer** — use case lens. Structures individual use cases (UC-{id}-{slug}.md). Needs the philosophy and template deeply.
- **Actor cataloger** — actor lens. Maintains the actor catalog (ACTOR-CATALOG.md). Needs to understand goals, drives, tensions, separation rationale.
- **Domain context writer** — bounded context lens. Writes domain context definitions (DC-{id}-{slug}.md) and the domain events catalog. Needs to understand term boundaries, ubiquitous language, event crossing.

### Lens proofreaders (3)

One per lens. The lens specialist's drive is production — write the artifact. The proofreader's drive is critique — find what violates the lens principles. They hold the negative space that the template deliberately omits.

The template guides authors with positive assertions: "expressed in domain terms," "steps express intent and outcomes," "invariants hold continuously." The proofreader catches what those assertions leave unsaid:

- **Use case proofreader** — scans for implementation detail leaks in goals and outcomes, mechanical step ordering (steps follow system workflow rather than actor values), precondition/postcondition framing instead of continuous invariants, alternate-flow framing instead of goal obstacles with recovery strategies.
- **Actor proofreader** — scans for actors without genealogy (no traceable tension), goals that are tasks (fail the gift test), missing value conditions, actors holding competing responsibilities.
- **Bounded context proofreader** — scans for shared language across contexts that should be partitioned, missing protocols at crossing points, events that cross boundaries without being named as domain events.

### Librarian

A single cross-cutting agent that maintains all reference and catalog artifacts. Its drive is keeping the model's reference artifacts current and consistent.

Carries **artifact contract skills** — one per artifact type. Each contract skill defines the structure of that artifact for both reading and writing. The structure doesn't change depending on direction — a contract is a contract. This means the Librarian doesn't spend tokens guessing how to parse a file it's already written, and any structural drift between artifacts is caught by the contract.

**Artifact contract skills:**

- **Use case contract** — sections, ordering, what each section contains. (Also used by the use case writer lens specialist.)
- **Actor catalog contract** — actor entries, goals/drives, appearance matrix, separation rationale.
- **Use case catalog contract** — index structure, one-line summaries, bounded context mapping.
- **Domain context contract** — purpose, ubiquitous language, use case references, events produced/consumed, integration points.
- **Domain events catalog contract** — what qualifies as a domain event vs internal event, producer/consumer, payload structure.
- **Glossary contract** — one-sentence entries, canonical spelling, when a term outgrows a glossary entry.
- **Shared invariants contract** — the repetition test for promotion from local to shared, cross-cutting rule structure.
- **Design conversations contract** — append-only, informal, capture reasoning behind non-obvious decisions.

## Flow

Two modes, controlled by the user with guidance from the facilitator:

1. **Real-time**: facilitator → lens agent → finding → facilitator decides to push to synthesizer immediately
2. **Batched**: facilitator → lens agent → finding → journal entry written → facilitator continues questioning → later, facilitator pushes accumulated journal entries to synthesizer

## Implementation status

The `designing-usecases` agent (`.claude/agents/designing-usecases.md`) is the first implementation. It combines the use case lens Socratic interviewer and use case writer into a single agent — will split as the architecture matures. Preloads four skills: `grounding-models`, `modeling-usecases`, `structuring-usecases`, `writing-documentation`.

## Actors map to skills

An actor is a role — goals, drives, responsibilities. A skill is a behavioral contract an agent loads. Loading a skill is putting on a hat. The agent adopts the actor's goals and judgment alongside its own.

This resolves the proliferation problem in the architecture above. The designing-usecases agent doesn't need separate Socratic interviewer, use case writer, and historian agents. It loads three skills and embodies all three roles in one context window. No coordination overhead, no message passing, no context burned on relay.

The boundary is drive compatibility. Complementary drives (discovery + preservation, interviewing + modeling) combine in one agent. Opposing drives (production vs critique) stay in separate agents. A creator who can also proofread will compromise between the two. A modeler who also captures notes will not — both drives serve the same goal.

This also answers the artifact contract question: yes, specialists and the Librarian share the same structuring skills. The skill is the contract. Who loads it determines what they do with it — the specialist writes artifacts, the Librarian maintains indexes. Same hat, different wearer.

## Open questions

- Where does the Librarian's work get triggered — by the synthesizer, the facilitator, or both?
