---
description: Save the current plan to a file
---

Save the current plan to a file. This command must be run after exiting plan mode (since plan mode is read-only).

The argument is: $ARGUMENTS

## Process

1. If no argument was provided, use AskUserQuestion to ask for the file path
2. Review the conversation to find the plan that was discussed and finalized
3. Write the plan contents to the specified file path
