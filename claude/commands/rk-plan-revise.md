---
description: Review and improve plan files by asking clarifying questions
---

Review a project plan and suggest improvements.

## Resolve Plan Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the plan directory path. Remember this path for the rest of the conversation so subsequent calls to `/rk-plan-restore` or `/rk-plan-revise` without an argument will reuse it.
2. If no argument was provided, check if a plan path was set earlier in this conversation. If so, use that.
3. If neither, default to `plan/` relative to the current working directory.

Let `PLAN_DIR` be the resolved path.

## Plan Conventions

- All generated non-code artifacts (e.g., TDDs, design documents, research notes) should be written as Markdown files using the Code Pointer Format in `install/man/markdown/md/rk_md_style.md`, and placed in `PLAN_DIR/output/`.
- Requests to "add a code pointer to the plan" should append the code pointer to `PLAN_DIR/CODE.md`. Create the file if it doesn't exist.

## Process

1. Read `PLAN_DIR/SPEC.md` to understand the project goals, constraints, and scope
2. Read `PLAN_DIR/TODO.md` to understand the current task status
3. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
   - Tasks that seem missing from the TODO list
4. Based on the answers, suggest improvements to the spec and TODO list
5. After confirming with the user, update the plan files with the improvements
