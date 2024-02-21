# Normal

- `]p`: Paste indented
- `P`: Paste without yanking in visual mode (note this can also be repeated with the `.` command)
- `zp`: Paste removing trailing whitespace (e.g., paste character-wise)
- `zP`: Paste removing trailing whitespace, without yanking first in visual mode (e.g., paste character-wise)

# Insert

- `^r <register>`: Paste in insert mode (also has a side effect of pasting character-wise instead of line-wise)
- `^r ^p <register>`: Paste in insert mode without indenting

# System Clipboard

Use `:set paste` to paste from the system clipboard without using Vim's indent.

The `unimpaired` plugin sets these bindings to assist with that process:

- `[op`: Enter insert mode with `:set paste` opening line before
- `]op`: Enter insert mode with `:set paste` opening line after
- `yop`: Enter insert mode with `:set paste` changing line
