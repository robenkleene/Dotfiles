---
description: Write or revise a task spec
---

Write or revise a task spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to understand plan conventions. For plan path resolution, use the previously remembered plan path or default to `rk_plan/` — do not use `$ARGUMENTS` for the plan path.

## Resolve Task Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the task directory path or task name. If the path does not start with `PLAN_DIR`, treat it as relative to `PLAN_DIR/tasks/`. If it matches a task name rather than an existing directory, use `PLAN_DIR/tasks/<YYYY-MM-DD>-<task-name>/` with today's date.
2. If no argument was provided and task directories exist in `PLAN_DIR/tasks/`, list them and use AskUserQuestion to ask which task to work on, with an option to create a new one.
3. If no argument was provided and no task directories exist, use AskUserQuestion to ask what the task is about, then derive a short descriptive name and use `PLAN_DIR/tasks/<YYYY-MM-DD>-<task-name>/`.

Let `TASK_DIR` be the resolved path.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Create `TASK_DIR` if it doesn't already exist
3. If `TASK_DIR/SPEC.md` exists, read it to understand the current task spec
4. Use AskUserQuestion to gather information:
   - If writing a new spec: ask about the problem being solved, key constraints, scope boundaries, and technical preferences
   - If revising: ask about unclear requirements, missing acceptance criteria, ambiguous scope, and undefined edge cases
5. Based on the answers, draft or update the task spec and present it to the user for review
6. After user approval, write the spec to `TASK_DIR/SPEC.md`
