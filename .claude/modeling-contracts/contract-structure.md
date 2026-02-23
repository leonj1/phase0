## Contract structure

The internal structure of the instruction set — `.claude/modeling-contracts/` and `.claude/scripts/`.

## modeling-contracts/

### principles/

Core beliefs and philosophical prose that creators follow when producing content. Each file teaches one concept — a lens, a role, a vocabulary, a standard. Principles shape how agents think and what they value during design work.

### governance/

Verification rules that reviewers follow when checking content. Governance owns the negative assertions — what to flag, what violates a contract, what to reject.

### forms/

Structural contracts for artifacts. Each form defines the sections, ordering, and placeholder guidance for one artifact type. Forms are pure structure — no philosophy, no creation mechanics. They serve both reading and writing. One form per artifact type defined in model-structure.md.

### Root-level documents

Structure documents that describe folder layouts and naming patterns. model-structure.md covers the model output tree. contract-structure.md covers the instruction set tree.

## scripts/

Deterministic helper scripts that agents call via Bash. One creation script per artifact type. Judgment stays in the agent; mechanics stay in the script. Always use relative paths (e.g., `bash .claude/scripts/create-note.sh`) to match permission patterns in `settings.json`.
