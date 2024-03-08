- `let @*=@a`: Copy register `a` to the system clipboard

# Linewise

If a register contains a new line, it will be treated as linewise. If it's linewise if it's appended to (e.g., `"Ay`) then a new line will be appended between each yank.

- Use `:pu[t] <register>` to force paste linewise from a register, to use the expression register, put the entire expression on the line, e.g., `:put =system('p')`
- `let @b="\n"`: Set a register just a line break (so subsequent appends with `"By` will have line break inserted between them)
