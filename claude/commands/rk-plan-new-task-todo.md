---
description: Read a task spec and propose a todo list for the task
---

Read a task spec and propose a todo list scoped to that task.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to understand plan conventions. For plan path resolution, use the previously remembered plan path or default to `rk_plan/` — do not use `$ARGUMENTS` for the plan path.

## Resolve Task Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the task directory path. If the path does not start with `PLAN_DIR`, treat it as relative to `PLAN_DIR/tasks/`.
2. If no argument was provided, list the task directories in `PLAN_DIR/tasks/` and use AskUserQuestion to ask which task to create a todo list for.

Let `TASK_DIR` be the resolved path.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Read `TASK_DIR/SPEC.md` to understand the task goals, constraints, and scope
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. Analyze the task spec and break it down into concrete, actionable tasks
5. Propose the todo list to the user for review before writing anything
6. After user approval, write the todo list to `TASK_DIR/TODO.md` using this format:

## Format

```markdown
# Active

- [ ] First task
- [ ] Second task
- [ ] Third task

# Done
```

Keep tasks specific and actionable. Group related work but avoid making individual items too large. Order tasks so dependencies come first.
