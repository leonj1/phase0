## Structuring glossaries

The glossary is a single file at `GLOSSARY.md` in the model root. Terms scoped to one bounded context live in that context's ubiquitous language section instead.

## Structure

```markdown
# Glossary

{Entries in alphabetical order. One entry per term.}

{Term} — {Definition in one sentence.}
```

## Entry format

Each entry is a single line:

1. Term — followed by an em dash (`—`)
2. Definition — one sentence, present tense, declarative

If a term needs a paragraph, it belongs in a principle or its own artifact.

## Renamed terms

When a term has been renamed, add a "Formerly:" annotation. This prevents newcomers from reviving retired vocabulary.

```markdown
Editorial lens — A distinct editorial discipline applied to wiki content during review. Formerly: pass.
```

## Ordering

Entries are alphabetical by term.

## Scope boundaries

Terms defined in a bounded context's ubiquitous language section stay there. A term appears in the glossary when it spans the model — when multiple contexts or artifacts rely on its meaning.
