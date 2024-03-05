- `:` to enter `Command-line-mode`
- `<C-c>` or `ESC`: Close command line and command line window
- `<C-n>` / `<C-p>`: Next / previous comment
- `<C-f>`: Enter command line window from command line (command history)

# Files

- `<cfile>` can be used to reference the file at the cursor, e.g., what would be used for `gf`

# Variables

The way to print environment variables like `$VIMRUNTIME` is to start a subshell:

```
`:!echo $VIMRUNTIME`
```

# Escaping

- Just using a backslash, e.g., for `\!`, `\#`, or `\%` should be enough (note that this is only necessary for `:!rg` style commands, custom commands like `:Rg` do not require these characters to be escaped)

# Movement

- `<C-b>` / `<C-e>`: Go to beginning/end of line

# Editing

- `<C-r><C-f>`: Insert file under cursor
- `<C-r><C-w>`: Insert word under cursor
- `<C-r><C-a>`: Insert WORD under cursor
- `<C-r>%`: Insert name of current file
- `<cfile>`: Another reference to the cursor file, this is particularly useful with `e <cfile>` to start create the file at the cursor (`<C-r><C-f>` can also be used in this case).
- There's no undo for the command line unfortunately

# Types of Commands

- `:normal dd`: Delete current line
- `:echo expand('%')`: Echo result of running a Vimscript command

# Command-Line Window

## Opening

- `q/`: Open search command line window
- `q:`: Enter command line window (normal history)
- `<C-f>`: Enter command line window from command line (command history)

## Closing

- `<C-w>c`: Close command line window, return to buffer
- `<C-c>`: Leave command line window open, return to command line

From the command line `<C-c>` (or `ESC`) will close the command line window and return to the buffer, so `<C-c><C-c>` also closes the command line window and returns to the buffer.

# `wildmenu`

- `<TAB>`: Show the wild menu
- `<UP>`: Move up a directory
- `<DOWN>`: Move down a directory

# Multiple Commands

- `echo "hello" | echo "world"

# History

- The history is stored in `~/.viminfo`
- `:his[tory] {name}`: List history, `{name}` defaults to `:` for this command
- `:call histdel(":", -1)`: Delete most recent item from command-line history

## `{name}`

`cmd` / `:`: Command line history
`search` / `/`: Search pattern history
`expr` / `=`: Typed expression history
`input` / `@`: Input line history
`debug` / `>`: Debug command history

