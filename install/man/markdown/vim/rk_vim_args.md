- `:args`: Show the contents of the argument list
- `:next`: Next file
- `:prev`: Previous file
- `args <backtick>fd foo<backtick>`: Populate `arglist` with result of external command (using `backtick-expansion`). Note if the command contains a wildcard, e.g., `args <backtick>fd '*.js'<backtick>`, then you must wrap the search term in quotes to prevent `vim` from trying to expand the `*`.
- Since the `arglist` is a subset of the buffer list `b <tab>` can also be used to complete from the `argslist` (although it will also include buffers that aren't in the `argslist`)

Once files have been opened as arguments, `##` can be used to represent them in `ex` commands, e.g.:

	:vimgrep /Lorem/ ##
