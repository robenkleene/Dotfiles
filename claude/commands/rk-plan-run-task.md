---
description: Work through a task TODO list, committing each item separately
---

Work through a task TODO list autonomously until all items are complete or a failure occurs.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the task path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the overall project goals, constraints, and scope
2. Read `TASK_DIR/SPEC.md` to understand the task goals, constraints, and scope
3. Read `TASK_DIR/TODO.md` to understand the current task status
4. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
5. If `PLAN_DIR/DECISIONS.md` exists, read it to understand past decisions and their rationale
6. Starting from the first unchecked item (`- [ ]`), work through each item sequentially:
   a. Implement the change described in the TODO item
   b. Run tests (e.g., `cargo test`, `npm test`, or whatever the project uses) to verify the change
   c. If tests pass, commit the change with a descriptive message
   d. Mark the item as `- [x]` and move it to the `# Done` section of `TASK_DIR/TODO.md`
   e. Move to the next unchecked item
7. If a step fails (tests fail, build breaks, or the item is ambiguous), stop immediately. Leave the TODO item unchecked so the task can be resumed later.

## Rules

- Do not ask questions. If a TODO item is too ambiguous to implement confidently, stop and leave it unchecked.
- Each TODO item that involves a code change gets its own commit.
- Run tests after each commit. Do not proceed to the next item if tests fail.
- Do not skip items. Work through them in order since later items may depend on earlier ones.
