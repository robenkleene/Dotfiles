## Resolve Plan Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the plan directory path. Remember this path for the rest of the conversation so subsequent calls to `/rk-plan-restore` or `/rk-plan-revise` without an argument will reuse it.
2. If no argument was provided, check if a plan path was set earlier in this conversation. If so, use that.
3. If neither, default to `rk_plan/` relative to the current working directory.

Let `PLAN_DIR` be the resolved path.

## Plan Conventions

- All generated non-code artifacts (e.g., TDDs, design documents, research notes) should be written as Markdown files and placed in `PLAN_DIR/output/`.
- Requests to "add a code pointer to the plan" should append the code pointer to `PLAN_DIR/CODE.md`. Create the file if it doesn't exist.
