---
name: structuring-glossaries
description: Structural contract for glossary documents. Defines the artifact shape for both reading and writing glossary files. Load when writing or reviewing glossary documents.
---

# Structuring glossaries

Structural contract for glossary documents. Defines the artifact shape for both reading and writing glossary files. Load when writing or reviewing glossary documents.

The glossary is a single file that defines every term with precise meaning within the model. Bounded contexts have their own ubiquitous language; the glossary captures terms that span the model. Terms defined in a bounded context's ubiquitous language section belong there, and appear in the glossary only when they span multiple contexts.

The glossary lives at `GLOSSARY.md` in the model root.

## Structure

```markdown
# Glossary

{Entries in alphabetical order. One entry per term.}

**{Term}** — {Definition in one sentence.}
```

## Entry format

Each entry is a single line:

1. **Term** — bolded, followed by an em dash (`—`)
2. **Definition** -- one sentence, present tense, declarative

If a term needs a paragraph, it belongs in a principle or its own artifact.

## Renamed terms

When a term has been renamed, add a "Formerly:" annotation. This prevents newcomers from reviving retired vocabulary.

```markdown
**Editorial lens** -- A distinct editorial discipline applied to wiki content during review. Formerly: pass.
```

## Ordering

Entries are alphabetical by term.

## Scope boundaries

Terms defined in a bounded context's ubiquitous language section stay there. A term appears in the glossary when it spans the model -- when multiple contexts or artifacts rely on its meaning.
