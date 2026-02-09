# Style Guides

When editing files, check for a style guide at `install/man/markdown/<ext>/rk_<ext>_style.md` (where `<ext>` matches the file extension, e.g., `sh`, `md`). The local style of existing nearby files takes precedence; use the style guide as a secondary reference.

# Plan Output

All generated non-code artifacts (e.g., TDDs, design documents, research notes) should be written as Markdown files using the Code Pointer Format in `install/man/markdown/md/rk_md_style.md`, and placed in the `plan/output/` directory relative to the plan directory.

# Plan Code Pointers

When a plan is loaded (i.e., `PLAN_DIR` was resolved by `/rk-plan-restore` or `/rk-plan-revise`), requests to "add a code pointer to the plan" should append the code pointer to `PLAN_DIR/CODE.md`. Create the file if it doesn't exist.

@~/.claude-local/CLAUDE.md
