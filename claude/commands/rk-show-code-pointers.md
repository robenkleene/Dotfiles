---
description: Re-display code from the conversation as formatted code pointers
---

Look at the conversation so far and identify the code locations that were just discussed. Re-display them as code pointers using the `man rk_md_style` format.

## Process

1. Look at the recent conversation to determine what code locations were referenced
2. Read the relevant files to get exact line numbers and code snippets
3. Output every result as a code pointer using the `man rk_md_style` format: a `grep` fenced code block with the file path in `file:line:col:` format, followed by a language-specific fenced code block with the code snippet
4. Do not output anything else besides the code pointers (no explanatory text, no headers, no summaries)
