---
description: Restore context from an existing plan directory and suggest next action
---

Restore context from a plan directory and suggest the next action.

Read `~/.claude/custom/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. Provide a brief summary of the project context
4. Look at the Active section of `TODO.md` and find the first unchecked item (`- [ ]`)
5. Suggest that item as the next action to take, with enough context from the spec to act on it
