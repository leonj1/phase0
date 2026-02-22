#!/usr/bin/env bash
set -euo pipefail

# Creates a note file following the note form (structuring-notes.md).
# Usage: create-note.sh <model-dir> <slug> <topic> <context> <body> <references>
#
# Example:
#   create-note.sh models/marklauter/phase0 historian-as-skill \
#     "Historian maps to a skill, not an agent" \
#     "Discovered while discussing durability improvements to designing-usecases agent." \
#     "The historian is a behavioral role, not a separate agent..." \
#     "cross-cutting (agent architecture, skill design)"

MODEL_DIR="$1"
SLUG="$2"
TOPIC="$3"
CONTEXT="$4"
BODY="$5"
REFERENCES="$6"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H%M")
FILENAME="${TIMESTAMP}-${SLUG}.md"
NOTES_DIR="${MODEL_DIR}/notes"

mkdir -p "$NOTES_DIR"

{
  printf '# %s\n\n' "$TOPIC"
  printf '## Context\n\n%s\n\n' "$CONTEXT"
  printf '## Body\n\n%s\n\n' "$BODY"
  printf '## References\n\n%s\n' "$REFERENCES"
} > "${NOTES_DIR}/${FILENAME}"

echo "${NOTES_DIR}/${FILENAME}"
