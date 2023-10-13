# `vim` Shell Commands

## Output in Echo Area

Note that the space after `w` is mandatory!

- `:.w !bash`: Current line
- `:w !bash`: File
- `:%w !bash`: File
- `:'<,'>w !bash`: Visual selection (note this only works for *line-wise* selection, sub-line selection will not work! This is because `:` `ex` commands are all line based)
## Replacing Selection

- `:'<,'>!sort`: Pipe visual selection through sort
- `:%!sort`: Pipe file through sort
- `!}`: Filter to the end of the current block through shell command (here `}` is just used as the `vim` motion to the end of the block)

## Appending Output to Current Buffer

- `:r !ls`: Input the result of a shell command below the current line
- `:0r !ls`: Input the result of a shell command at the beginning of the document
- These don't work with interactive commands (their output is written to a temporary buffer)

## Output in a New Buffer

There's no nice way to do this, it's easier to just create a new buffer (`:new`) paste the current document if you need it then run the command

- `vnew | 0r !git blame #`: Trick to get blame output side-by-side with command

## Special

- `!clear`: Clear the external command buffer
- `!!bash`: Execute current line in bash (note that this is a normal mode command, not a command line command)
- `:!%`: Run current file

## Parameter Expansion

`:h backtick-expantion`

- ":e `today`.md": Works well
- Backtick expansion often causes errors, for example ":Explore `git root`" doesn't work. A workaround is to use tab expansion to expand the backtick quote portion (e.g., ":Explore `git root`<tab>" will expand to the result of `git root`).

### Gotchas

- Doesn't work with Fish shell
- Doesn't work with interactive programs, it hangs (e.g., "e `which z_fzf`" won't work

## Pipes

- Pipes can be used normally with `:!`, e.g., `:!realpath % | pbcopy` works
