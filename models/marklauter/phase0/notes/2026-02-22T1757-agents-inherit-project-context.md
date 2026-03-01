# Why /agents generates good agents from short prompts

## Context

Discovered after generating the governing-artifacts agent with a one-sentence prompt via the /agents slash command. The resulting agent had deep, accurate knowledge of phase0 conventions, forms, naming patterns, and design principles — far more than the prompt contained.

## Body

The /agents "Generate with Claude" path runs in the main conversation context. That context already includes the full project instructions, MEMORY.md (auto-memory), and any files pulled in via @ references (e.g., facilitating-design.md). A one-sentence prompt is therefore augmented by hundreds of lines of rich project instructions already in the context window.

The quality of a generated agent directly reflects the quality of the project's instructions and memory files. Well-structured project instructions act as a force multiplier — minimal user input produces high-fidelity agents because the context does the heavy lifting.

This has a practical implication: investing in project instruction and memory quality pays compound returns every time a new agent is generated.

## References

cross-cutting (agent architecture, project instructions, /agents workflow)
