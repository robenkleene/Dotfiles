---
description: Review and improve a spec file by asking clarifying questions
argument-hint: <path-to-spec-file>
---

Review the spec file at: $ARGUMENTS

## Process

1. Read the spec file thoroughly
2. Use AskUserQuestion to clarify ambiguities or missing details, such as:
   - Unclear requirements
   - Missing acceptance criteria
   - Ambiguous scope
   - Undefined edge cases
3. Based on the answers, suggest improvements to the spec
4. After confirming with the user, update the spec file with the improvements

Key points:
- $ARGUMENTS is replaced with whatever the user types after the command
- argument-hint shows in help text to guide usage
- The command is invoked as /improve-spec path/to/my-spec.md
