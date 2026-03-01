# Clarify how evaluators target a specific model in a multi-model workspace

## What

The models/ directory is a multi-project workspace — models/marklauter/github-wiki-agent/, models/someone/other-project/, etc. The evaluation agents and the shared evaluation contract (evaluation.md) currently discover the model root by globbing with wildcards (models/*/*/, models/**/*.md). In a workspace with one model this works by accident. In a workspace with multiple models it breaks — evaluating-style globs models/**/*.md and reads every artifact from every model, evaluating-structure globs models/*/*/ and inventories all models, evaluating-coherence finds multiple GLOSSARY.md files. The facilitator-role contract already says to pass the model directory path in each dispatch prompt, but the agents treat this as optional and fall back to globbing. The fix is not just replacing globs — it requires deciding how model targeting works across the system. Should agents require the model path and fail explicitly if it is missing? Should the shared evaluation contract stop suggesting glob fallbacks? Should the dispatch prompt format be standardized so every agent receives the model path the same way? This needs a coherent answer that works across all four evaluators and the shared evaluation contract.

## Why

Discovered while adding skill injections to evaluator agents. The evaluating-style agent globs models/**/*.md, which would silently read artifacts from unrelated models in a multi-model workspace. The same pattern appears in evaluating-structure, evaluating-references, evaluating-coherence, and the shared evaluation.md contract.

## References

- .claude/contracts/principles/best-practices/evaluation.md (shared evaluation contract — line 32 suggests glob fallback)
- .claude/agents/evaluating-structure.md (Step 2 — globs models/*/*/)
- .claude/agents/evaluating-references.md (Step 1 — globs under models/)
- .claude/agents/evaluating-coherence.md (Loading step 1 — globs models/*/*/GLOSSARY.md)
- .claude/agents/evaluating-style.md (Step 1 — globs models/**/*.md)
- .claude/contracts/principles/roles/facilitator.md (says to pass model path in dispatch)
