- `:` to enter `Command-line-mode`
- `<C-c>` or `ESC`: Close command line and command line window
- `<C-n>` / `<C-p>`: Next / previous command

# Files

- `<cfile>` can be used to reference the file at the cursor, e.g., what would be used for `gf`

# Variables

The way to print environment variables like `$VIMRUNTIME` is to start a subshell:

```
`:!echo $VIMRUNTIME`
```

# Escaping

- To pass `!`, `#`, `%` to a shell command, which trigger it's Vim command-line meaning, just escape it with a backslash: `\!`, `\#`, or `\%` (note that this is only necessary for `:!rg` style commands, custom commands like `:Rg` do not require these characters to be escaped)
- To use a `|` after a shell command in Vim, e.g., to run `0r !git diff` then `cd ..` on one command line insert a `<NL>` between the two commands with `<C-v><C-j>` (see `h :bar`)

# Editing

- `:help cmdline-editing`: Help
- `<C-b>` / `<C-e>`: Go to beginning/end of line
- `<C-u>`: Delete to the beginning of the line
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

- `<C-f>`: Enter command line window from command line (command history)
- `q:`: Enter command line window from normal mode
- `q/`: Open search command line window from normal mode

## Closing

- `<C-w>c`: Close command line window, return to buffer
- `<C-c>`: Leave command line window open, return to command line

From the command line `<C-c>` (or `ESC`) will close the command line window and return to the buffer, so `<C-c><C-c>` also closes the command line window and returns to the buffer.

# `wildmenu`

- `<TAB>`: Show the wild menu
- `<UP>`: Move up a directory
- `<DOWN>`: Move down a directory

# Multiple Commands

- `echo "hello" | echo "world"`

# History

- The history is stored in `~/.viminfo`
- `:his[tory] {name}`: List history, `{name}` defaults to `:` for this command

## `{name}`

`cmd` / `:`: Command line history
`search` / `/`: Search pattern history
`expr` / `=`: Typed expression history
`input` / `@`: Input line history
`debug` / `>`: Debug command history

## Deleting

- `:call histdel(":")`: Delete all command-line history
- `:call histdel("/")`: Delete all search history
- `:call histdel(":", -1)`: Delete most recent item from command-line history
- `:call histdel("/", -1)`: Delete most recent item from search history

