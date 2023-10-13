%

# `vim` Cut & Paste Subtlety

When performing these steps:

1. Yank some text
2. Visually select some text
3. Paste
4. Visually select some text again
5. Paste again

At #5, what's pasted is what was visually selected at #2, not what was yanked in #1.

There are two ways to get around this:

1. At #1, yank to a named register `"ay`, and paste from that register in the remaining steps `"ap`.
2. At #5, paste from the yank register instead `"0p`

## New Line Characters

The `g_` operator, goes to the end of the line without selecting the new line character. So to replace to the end of line without deleting the new line character, use `vg_`.

* `v$`: Visual select to the end of the line, a `y` after this will include the new line
* `y$`: Yank to the end of the line, this will *not* include the new line

## Quoted Strings

* `v2i"`: Quoted String Including Quotes Without Whitespace

## Functions

* `Va{ok`: In a function block, this is usually the easiest way to select the entire function. `Va{` starts a line-wise visual selection, `o` switches the side of the selection being modified, and `k` moves up a line.
