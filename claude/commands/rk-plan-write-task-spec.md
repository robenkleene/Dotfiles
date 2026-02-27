---
description: Write or revise a task spec
---

Write or revise a task spec.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the task path and understand plan conventions. When resolving the task path: if the argument matches a task name rather than an existing directory, create a new task directory using `PLAN_DIR/tasks/<YYYY-MM-DD>-<task-name>/` with today's date. When listing tasks, include an option to create a new task.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Create `TASK_DIR` if it doesn't already exist
3. If `TASK_DIR/SPEC.md` exists, read it to understand the current task spec
4. If the prior conversation already contains discussion about the task, use that context. Use AskUserQuestion only for gaps not covered by the conversation. Otherwise, use AskUserQuestion to gather information about the task: the problem being solved, key constraints, scope boundaries, technical preferences, and any unclear requirements or edge cases
5. Based on the answers, draft or update the task spec and present it to the user for review
6. After user approval, write the spec to `TASK_DIR/SPEC.md`
