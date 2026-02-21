# Grounding models

Core principles for domain modeling, grounded in Alan Cooper's goal-directed design and Eric Evans' domain-driven design. Every agent in the design cycle shares this vocabulary and these principles.

## Primary actors have goals; supporting actors have drives

A **primary actor** has a *goal* — a desired end state the system exists to serve. You don't need to explain why they want it. The system is built for them. Their goals always have conditions.

A **supporting actor** has a *drive* — a reason to participate. Drives explain why supporting actors exist at all. They are born from tensions between primary actor goals and the forces of reality.

Goals and drives both make actors predictable in a modeling sense. You know what a primary actor wants to achieve, and you know what a supporting actor will optimize for — and therefore where it will fall short. An actor is not a tool. A tool has no goal or drive — `grep` does exactly what you tell it. An actor makes decisions shaped by what it cares about.

## Goals are conditional

A primary actor's goal is a **conditional goal**: a desired end state plus the values the actor holds about how they exist in that state. A conditional goal is a **value statement** — it expresses not just *where* the actor wants to be, but *what they value* about being there.

## Domain events over return values

Actors communicate through meaningful state transitions, not function returns. A drift assessment, a filed finding, a change report — these are domain events. They are the published language between bounded contexts.

Name them. Define them. They are the integration points of the system.

## Markdown is the wire format

Protocols, domain events, reports, and assessments are all materialized as markdown. Not JSON. Not YAML. Not protocol buffers. The consumers are humans and LLM agents, and markdown is the format both read natively. Formal machine-readable schemas are not needed when every consumer is a capable reader.

This is a deliberate choice, not a shortcut. A system whose integration points are optimized for human and AI consumption does not need a serialization layer between them.

## Nouns, verbs, and objects

- **Actors** are nouns. Proofreader, Creator, Corrector, Commissioning orchestrator. They're *who*.
- **Use cases** are verbs. Populate New Wiki, Review Wiki Quality, Sync Wiki with Source Changes. They're *what happens*.
- **Events** are nouns — past participles used as nouns. WikiPopulated, FindingFiled, WikiSynced. They're *what was produced*, the fact that something happened.

If you catch yourself naming an actor with a verb or a use case with a noun, something is off.

## Extract, don't invent

Use case design is Socratic. The designer asks questions; the domain expert has the answers. The designer's job is to draw out goals, constraints, and events that the expert already knows but hasn't structured — not to fabricate domain knowledge or infer requirements from silence.

Work one phase at a time. Summarize what you heard before moving on. If the answer is task-oriented ("it runs git pull"), redirect to intent ("what state does that achieve?"). If something contradicts a principle in this document, flag it.

The user knows the domain. The designer knows how to structure it.
