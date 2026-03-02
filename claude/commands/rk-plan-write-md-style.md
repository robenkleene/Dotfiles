---
description: Write conversation content to plan file in rk_md_style format
---

Look at the conversation so far and identify the content that was discussed. Write it to the plan file in proper markdown following `man rk_md_style` rules.

## Process

1. Enter plan mode via `EnterPlanMode`
2. Look at the conversation to identify the content that was discussed
3. Read relevant files to get exact line numbers and snippets where needed
4. Write the content to the plan file following all rules from `man rk_md_style` (real headers, proper code pointer format with fenced code blocks, no bold-as-header, etc.)
5. Do NOT call `ExitPlanMode` — leave the user in plan mode to continue working
