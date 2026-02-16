---
description: Work through the entire TODO list, committing each item separately
---

Work through the entire plan TODO list autonomously until all items are complete or a failure occurs.

Read `~/.claude/robenkleene/PLAN.md` and follow its instructions to resolve the plan path and understand plan conventions.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. If `PLAN_DIR/CODE.md` exists, read it to understand already-discovered code pointers
4. If `PLAN_DIR/DECISIONS.md` exists, read it to understand past decisions and their rationale
5. Starting from the first unchecked item (`- [ ]`), work through each item sequentially:
   a. Implement the change described in the TODO item
   b. Run tests (e.g., `cargo test`, `npm test`, or whatever the project uses) to verify the change
   c. If tests pass, commit the change with a descriptive message
   d. Mark the item as checked (`- [x]`) in `PLAN_DIR/TODO.md`
   e. Move to the next unchecked item
6. If a step fails (tests fail, build breaks, or the item is ambiguous), stop immediately. Leave the TODO item unchecked so `/rk-plan-continue` can pick up where this left off.

## Rules

- Do not ask questions. If a TODO item is too ambiguous to implement confidently, stop and leave it unchecked.
- Each TODO item that involves a code change gets its own commit.
- Run tests after each commit. Do not proceed to the next item if tests fail.
- Do not skip items. Work through them in order since later items may depend on earlier ones.
