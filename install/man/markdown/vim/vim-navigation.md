# `vim` Navigation

## `vim` Marks

- `ma`: Make mark called `a`
- `<backtick>a`: Go to `a` (line and column)
- `'x`: Go to `x` (line only)
- `:marks`: List marks
- `<backtick><backtick>`: Go to location before last motion
- `''`: Go to line before last motion

### Special Marks

- `.`: Last change
- `[` and `]`: Beginning and end of last yank or change
- `<` and `>`: Beginning and end of last visual selection

## Edits

- `g;` / `g,`: Go to previous / next edit

## Operating What's Under Cursor

* `gx`: Open URL under cursor
* `gf`: Open file under cursor
- `<C-w>gf`:  Open the file under the cursor in a new tab
- `<C-w>f`:  Open the file under the cursor in a new split

## Buffers

- `:ls`: List open buffers
- `:b[uffer]`: go to buffer number 
- `:bd`: Close buffer

## Jump List

- `:[ju]mps`: Show the `jumplist`
- `<C-o>`: Go to the previous position in the `jumplist`
- `<C-i>`: Go to the next position in the `jumplist`

## Argument List

- `:args`: Show the contents of the argument list
- `:next`: Next file
- `:prev`: Previous file
- `args <backtick>fd foo<backtick>`: Populate `arglist` with result of external command (using `backtick-expansion`). Note if the command contains a wildcard, e.g., `args <backtick>fd '*.js'<backtick>`, then you must wrap the search term in quotes to prevent `vim` from trying to expand the `*`.

Once files have been opened as arguments, `##` can be used to represent them in `ex` commands, e.g.:

	:vimgrep /Lorem/ ##

## Old Files

- `:[ol]dfiles`: Recent files
    - You can hit `:` in this list to enter an edit command, e.g., `e #<1` to edit old file number `1`
- `:e #<1`: Edit most recent file
- `:e #<2`: Edit second most recent file

## Language Specific

- `]}` & `[{`: Go to next or previous brace (only works from inside a brace pair)
- `]m` & `[m`: Go to next or previous method

## View

- `zz`: Move screen centering cursor
- `zt` / `zb`: Move screen positioning cursor at top /bottom
- `zs` / `ze`: Move screen positioning cursor at beginning / end
- `zh` / `zl`: Move screen positioning cursor left / right by one character
- `zH` / `zL`: Move screen left / right by one screen

