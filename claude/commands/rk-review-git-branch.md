Review the current branch for merge readiness.

## Process

1. Determine the base branch by checking which of `main` or `master` exists
2. Run `git diff <base>...HEAD` to see all changes on this branch
3. Run `git log <base>..HEAD --oneline` to see all commits
4. Review the diff for:
   - Bugs or correctness issues
   - Regressions (e.g., lost functionality, weakened error handling)
   - Inconsistencies (e.g., code that contradicts itself across files)
   - Stale references (e.g., comments, docs, or variable names that no longer match the code)
   - Anything that looks unintentional
5. If anything is unclear about the code, its intent, or its context, use AskUserQuestion to clarify before finalizing the review.
6. Report your findings. If there are no concerns, say so clearly. If there are concerns, list each one with the file and line reference.
