---
description: Review and improve a task spec by asking clarifying questions
---

Review a task spec and suggest improvements.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to understand plan conventions. For plan path resolution, use the previously remembered plan path or default to `rk_plan/` — do not use `$ARGUMENTS` for the plan path.

## Resolve Task Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the task directory path. If the path does not start with `PLAN_DIR`, treat it as relative to `PLAN_DIR/tasks/`.
2. If no argument was provided, list the task directories in `PLAN_DIR/tasks/` and use AskUserQuestion to ask which task to revise.

Let `TASK_DIR` be the resolved path.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Read `TASK_DIR/SPEC.md` to understand the task goals, constraints, and scope
3. If `TASK_DIR/TODO.md` exists, read it to understand the task current progress
4. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
5. Based on the answers, suggest improvements to the task spec
6. After confirming with the user, update `TASK_DIR/SPEC.md` with the improvements
