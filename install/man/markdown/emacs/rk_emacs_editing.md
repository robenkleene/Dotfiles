- `C-j`: Insert a new line without indenting the next line
- `C-o`: Open a split the current line, leaving the cursor on the current line (at the beginning of the line, create a insert a new line above, in the middle, split the line at the cursor, and at the end insert a new line below)

# Uppercase, Lowercase & Capitalization

- `M-l`: Lowercase word
- `M-u`: Uppercase word
- `M-c`: Capitalize word

# Transpose

- `C-t`: Characters
- `M-t`: Words
- `C-x C-t`: Lines

# Selection

- `M-w`: Copy
- `C-w`: Cut
- `C-y`: Paste
- `M-y`: Cycle through matches (after a `C-y`)
- `C-SPC`: Select
- `C-x C-x`: Restore previous region

## Rectangular

- `C-x SPC`: Enter rectangular selection (block editing) mode
- `C-x r t` / `string-rectangle`: Prepend each line in select (use `C-M-%` / `query-replace-regexp` to append each line)

### Examples

#### Insert Text on Each Line

1. Enter rectangle selection with `C-x SPC`
2. Move the cursor down across the column where the text should be inserted
3. Hit `C-x r t` to enter string rectangle, enter the text to insert and hit enter

#### Prefix Each Line

This can be used to edit anywhere in a line, not just the beginning.

1. Go to the first character of the first line and set the mark (`C-SPC`)
2. Go to the first character of last line and toggle rectangular selection (`C-x r t`)
3. At the `String rectangle:` prompt, enter the prefix and hit enter

# Movement

- `M-m`: Move to first character on line (skip white space)
- `M-m`: Cycle between top, center and bottom of window
- `M-{`: Backward by paragraph
- `M-}`: Forward by paragraph

# Deleting

- `M-0 C-k`: Delete to beginning of line

# Macros

- `C-x (`: Start recording a macro
- `C-x )`: Finish recording a macro
- `C-x e`: Replay macro

# Special

- `M-q`: Wrap
- `M-z` / `C-u M-z`: Delete to character forward / backward
- `C-x C-q`: Toggle view only mode

# Split & Merge Lines

- `M-^`: Join line with line above
- `C-o`: Open empty line above
- `C-x C-o`: Delete empty blank lines

# Comments

- `M-;`: Comment or uncomment selected region
- `C-x C-;`: Comment or uncomment line

# Whitespace

- `M-\`: Delete whitespace until next word
- `M-\` / `C-u M-\` : Delete whitespace forward / backward next non-whitespace character

# Spelling

- `M-S-$`: Correct misspelled word
