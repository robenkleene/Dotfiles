## Resolve Plan Path

The argument is: $ARGUMENTS

1. If an argument was provided (non-empty), use it as the plan directory path. Remember this path for the rest of the conversation so subsequent calls to `/rk-plan-continue` or `/rk-plan-revise` without an argument will reuse it.
2. If no argument was provided, check if a plan path was set earlier in this conversation. If so, use that.
3. If neither, default to `rk_plan/` relative to the current working directory.

Let `PLAN_DIR` be the resolved path.

## Plan Conventions

- All generated non-code artifacts (e.g., TDDs, design documents, research notes) should be written as Markdown files and placed in `PLAN_DIR/output/`.
- Requests to "add a code pointer to the plan" should append the code pointer to `PLAN_DIR/CODE.md`. Create the file if it doesn't exist.
- Requests to record a decision (e.g., "chose X over Y because...") should append to `PLAN_DIR/DECISIONS.md`. Create the file if it doesn't exist. Each entry should include the decision, alternatives considered, and rationale.
- Requests to save log output (e.g., from reproducing a bug, debugger output, build errors) should append to `PLAN_DIR/LOGS.md`. Create the file if it doesn't exist. Each section should start with a `##` heading describing what was run (e.g., `## Build output after fixing auth`).
- `PLAN_DIR/archive/` contains older versions of plan files for historical reference. Never load archive files automatically. When asked to check the archive for context on past decisions (e.g., "check the archive for why we decided to do X"), search `PLAN_DIR/archive/` for relevant information. Archived files mirror the plan directory structure: `PLAN_DIR/TODO.md` archives to `PLAN_DIR/archive/TODO.md`, `PLAN_DIR/output/` archives to `PLAN_DIR/archive/output/`, etc.
