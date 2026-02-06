---
description: Restore context from an existing plan directory and suggest next action
---

Restore context from a plan directory and suggest the next action.

## Resolve Plan Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the plan directory path. Remember this path for the rest of the conversation so subsequent calls to `/rk-plan-restore` or `/rk-plan-revise` without an argument will reuse it.
2. If no argument was provided, check if a plan path was set earlier in this conversation. If so, use that.
3. If neither, default to `plan/` relative to the current working directory.

Let `PLAN_DIR` be the resolved path.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. Provide a brief summary of the project context
4. Look at the Active section of `TODO.md` and find the first unchecked item (`- [ ]`)
5. Suggest that item as the next action to take, with enough context from the spec to act on it
