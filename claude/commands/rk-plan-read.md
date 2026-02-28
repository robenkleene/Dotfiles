---
description: Read a file and enter plan mode
---

Read a file and enter plan mode. The file contents become the starting context for the plan discussion.

The argument is: $ARGUMENTS

## Process

1. If no argument was provided, use AskUserQuestion to ask for the file path
2. Read the file at the specified path
3. Enter plan mode using `EnterPlanMode`
