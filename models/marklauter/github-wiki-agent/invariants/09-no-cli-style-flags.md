# No CLI-style flags

## Statement

Commands are agent interactions, not CLI programs. Confirmation and disambiguation happen through conversation, not `--force` or `--all` flags.

## Rationale

This system is conversational. Flags bypass the judgment and confirmation that make agent interactions safe. Conversation gives the user a chance to understand what will happen before it happens.

## Scope

- use-cases/03-revise-wiki
- use-cases/06-decommission-workspace

## Origin

Established by use-cases/05-provision-workspace.

## Notes

- This invariant reinforces the conversational nature of the agent. Where a CLI would use flags for mode selection, this system uses dialogue.
