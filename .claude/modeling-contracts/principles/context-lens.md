## Context lens

The bounded context lens discovers where meanings partition. Depth on context boundaries discovered through contradiction, ubiquitous language as the boundary marker, domain events as the crossing protocol, integration points, and the mapping from contexts to agent boundaries.

## Contexts are discovered through contradiction

A bounded context is a region of the domain where every term has exactly one meaning. You do not declare contexts by drawing boxes on a whiteboard. You discover them when the same word means different things to different people — or when the same concept carries different rules depending on who is talking.

When Alice says "shipment" means what leaves the warehouse and Bob says "shipment" means what the customer ordered, that disagreement is a context boundary. The word is the same. The meaning is not. The boundary lives at the point of divergence.

Context boundaries also surface when responsibilities separate naturally. Wiki creation and editorial review both operate on wiki pages — but creation produces pages and review critiques them. The activities, the actors, the language, and the rules differ. Two contexts, not one context with two phases.

Ask: "Does this term mean the same thing everywhere it appears? Do these rules apply uniformly, or do they shift depending on which part of the domain you are in?"

## Ubiquitous language is the boundary marker

Each bounded context owns its vocabulary. Within a context, every term has one precise meaning shared by all participants — human experts, specification documents, and agents. Evans calls this the ubiquitous language. It is ubiquitous within its context and foreign outside it.

A "finding" in the editorial review context is a specific documentation problem with quoted text, a recommendation, and a severity. The same word in a different context might mean something else entirely. The ubiquitous language defines what the term means here, and "here" is the bounded context.

When you discover that a term carries two meanings, you have found a boundary. When you discover that two contexts share a term but attach different rules to it, you have found an integration point that needs a protocol.

Ubiquitous language is not a glossary exercise. It is the act of naming what the domain expert already knows — making implicit distinctions explicit. When the expert says "but that is different from..." they are drawing a context boundary. Your job is to hear it.

## Domain events are the crossing protocol

Bounded contexts communicate through domain events — durable facts that something happened. An event crosses a context boundary the way a letter crosses a property line: it carries information, not authority. The receiving context decides what to do with it.

WikiPopulated is a fact published by the wiki creation context. The editorial review context and the drift detection context both consume it — but each reacts according to its own rules, its own language, its own actors. The producing context does not know or care what the consumers do. The event is a contract: this happened, here is the payload, do what you will.

Events that stay inside a context — coordinating steps within a single use case — are internal events. They appear in the use case's Domain events section but do not get their own files. Published events are the ones that cross boundaries. They are the integration mechanism. They get their own artifact files because they are contracts with the rest of the system.

The distinction matters: a published event is a promise. Changing its structure or payload affects every consumer. An internal event is a coordination detail — change it freely.

## Integration points define relationships

Contexts do not exist in isolation. They relate to each other through three kinds of integration:

- Requires — a dependency. Wiki creation requires workspace lifecycle because a workspace must be provisioned before pages can be written. The dependency is directional: creation cannot proceed without the workspace, but the workspace does not know about creation.
- Feeds — a producer-consumer relationship. Wiki creation feeds editorial review because the populated wiki is what review critiques. The producing context publishes a domain event; the consuming context reacts to it.
- Shares with — a bidirectional relationship where two contexts exchange information through a shared protocol. Both sides must agree on the protocol. This is the most coupled form of integration and demands the most explicit contract.

Every crossing point needs a named protocol. If two contexts communicate and you cannot point to the event or contract that governs the exchange, you have found a gap. Define the protocol or question whether the boundary is in the right place.

## Context phases

The bounded context lens applies four phases in a cycle:

1. Identify context boundaries. Listen for term conflicts — the same word meaning different things. Listen for responsibility separations — activities that look related but carry different rules, different actors, different vocabularies. Each boundary candidate becomes a context.

2. Define ubiquitous language. For each context, name the terms that have precise meaning within it. If a term appears in two contexts with different meanings, both definitions exist — one per context. The glossary at the model root records the canonical definition; the context's ubiquitous language section records what the term means here.

3. Map events produced and consumed. Walk the context's use cases and identify every state transition that crosses a boundary or is published to the outside world. Each is a domain event. Name it in PastTense. Record the producer, the consumers, and the payload. Events that stay inside the context are internal — note them in the use case but do not promote them to published events.

4. Define integration points. For each pair of contexts that communicate, name the relationship (requires, feeds, shares with) and the protocol that governs it. If the protocol is a domain event, reference it. If it is a shared data contract, document it. Every crossing point has a named mechanism.

## Contexts map to agent boundaries

In an agentic system, bounded contexts become agent boundaries. The context's ubiquitous language becomes the agent's vocabulary — the terms it understands and the terms it uses in its outputs. The context's integration points become the agent's tool contracts and event schemas. The context's invariants become the agent's guardrails.

When two contexts share a domain event, the agents implementing those contexts share a wire format. The event payload is the contract. Neither agent needs to understand the other's internal language — only the shared event structure.

This mapping is not metaphorical. Wiki creation has a commissioning orchestrator, researchers, a developmental editor, and creators. Editorial review has a review orchestrator, proofreaders, a deduplicator, and an issue filer. These are different agent teams with different drives, different tools, and different vocabularies. The context boundary IS the team boundary.

When you discover a new bounded context, you have discovered a future agent boundary. When you define a domain event, you have defined a future wire protocol. The model is the architecture.
