# `luasnip`

## Paste

Using pasted text in snippets with tokens is difficult because `SELECT` mode, which is used by default when filling out snippets, doesn't support pasting. Here's a workaround:

1. Trigger the snippet then immediately escape back to `NORMAL` mode
2. Yank the text to use in the snippet (this step can also be performed before triggering the snippet)
3. Use the `c` operator to replace the token
4. Paste from the `0` register in `INSERT` mode with `⌃R 0` (since the snippet is still active, this will also replace all instances of the same token in the snippet)
