# `vim` Editing

- `ZZ`: Quit and save
- `ZQ`: Quit without saving

## Insert Mode

- `cc`: Enter insert mode at correct indent level
- `^r *`: Paste from clipboard in insert mode (also has a side effect of pasting character-wise instead of line-wise)

## Completion

- `^n`: Start auto-complete
- `^y`: Accept from auto-complete list
- `^e`: Cancel auto-complete

### Completion Types

- `^x^f`: File paths (after starting file path completion, `^f` selects a match and goes one deeper in the hierarchy)
- `^x^k`: Dictionary words

## Selecting

- `⌃v`: Visual Block Mode
- `gv`: Reselect last visual block

Text cut with `^v` is `blockwise`, if you then paste it, the text will interleave with any lines it overlaps with. To get around this behavior, just use the `:put` command, which pastes the text as if it were yanked `linewise`.

## Undo

- `u`: Undo
- `⌃r`: Redo

## Numbers

- `C-a` / `C-x`: Increment/decrement number

## Quick Tabs to Spaces

    set expandtab
    set shiftwidth=2
    " Retab document with `gg=G`

## Tips

- Use `cw` to change whitespace between words or `dw` to delete.
