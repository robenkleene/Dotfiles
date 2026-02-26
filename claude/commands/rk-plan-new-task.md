---
description: Scaffold a new task subdirectory by asking clarifying questions
---

Scaffold a new task subdirectory with a spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to understand plan conventions. For plan path resolution, use the previously remembered plan path or default to `rk_plan/` — do not use `$ARGUMENTS` for the plan path.

## Resolve Task Name

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the task name (lowercase, hyphen-separated).
2. If no argument was provided, use AskUserQuestion to ask what the task is about, then derive a short descriptive name.

The task directory will be `PLAN_DIR/tasks/<YYYY-MM-DD>-<task-name>/` using today's date.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Create the task directory if it doesn't already exist
3. Use AskUserQuestion to understand the task by asking about:
   - What problem is being solved or what subtask is being addressed
   - Key constraints or requirements specific to this task
   - Scope boundaries (what's in and out of scope for this task)
   - Any known technical approach or preferences
4. Based on the answers, draft a task spec and present it to the user for review
5. After user approval, write the spec to `TASK_DIR/SPEC.md`
