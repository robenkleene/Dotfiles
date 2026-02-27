---
description: Restore context from a task directory and suggest next action
---

Restore context from a task directory and suggest the next action.

If currently in plan mode, exit plan mode before running this command.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the task path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Read `TASK_DIR/SPEC.md` to understand the task goals, constraints, and scope
3. If `TASK_DIR/TODO.md` exists, read it to understand the current task status
4. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
5. If `PLAN_DIR/DECISIONS.md` exists, read it to understand past decisions and their rationale
6. If `TASK_DIR/LOGS.md` exists, read the most recent section to review saved log output
7. Provide a brief summary of the task context
8. Look at the Active section of `TASK_DIR/TODO.md` and find the first unchecked item (`- [ ]`)
9. Suggest that item as the next action to take, with enough context from the task spec to act on it
10. Note that the user can enter plan mode to discuss the approach before implementing
