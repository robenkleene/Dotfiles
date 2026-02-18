Review the current directory and suggest improvements.

## Process

1. Explore the project structure, source files, tests, configuration, and documentation in the current working directory.
2. Review the codebase for:
   - Bugs or correctness issues
   - Missing error handling or edge cases
   - Inconsistencies (e.g., code that contradicts itself across files)
   - Stale references (e.g., comments, docs, or variable names that no longer match the code)
   - Safety concerns (e.g., command injection, path traversal, data loss scenarios)
   - Code quality issues (e.g., duplication, unclear naming, missing tests)
   - Usability improvements for CLI tools or APIs
3. If anything is unclear about the project, its purpose, or its conventions, use AskUserQuestion to clarify before finalizing the review.
4. Report your findings as a prioritized list of suggestions, ordered by impact. For each item, reference the relevant file and line. If there are no concerns, say so clearly.
