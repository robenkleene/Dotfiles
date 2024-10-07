# Movement

- `C-u C-SPC`: Pop buffer local mark (go to previous mark, repeatable with `C-SPC` if )
- `C-x C-SPC`: Pop global mark (go to previous mark, from the global mark ring)
- `C-SPC C-SPC`: Push mark (set a mark with no region)
- `C-x C-x`: Swap the point and mark (e.g., to adjust the other side of a selection)
- `isearch` automatically sets a mark when entering a search result with `RET`

# Setting Mark

- `C-M-]`: Mark s-expression
- `C-x h`: Mark buffer
- `M-h`: Mark paragraph
- `C-M-h`: Mark current function
- `C-x C-p`: Mark page
- `M-@`: Mark word
- `C-M-@` / `C-M-SPC`: Mark s-expression

## Reverting

- `M--` followed by a mark command goes backwards (e.g., `M-- C-M-SPC` will revert the last mark s-expression)

## Off-Screen

In Emacs the cursor can't scroll off-screen, which means if you want to select contiguous text, for example with `mark-block` (`M-h`) eventually the bottom of the selection will move off screen. If you try to scroll the bottom of the selection back on screen, then you'll have lost the beginning of your selection, because Emacs will move the cursor which represents the beginning of the cursor.

As a workaround, you can hit `C-x C-x` (`exchange-point-and-mark`) to see where the selection is, and then move back with `C-x C-x` again (unfortunately, if you continue marking with `M-h` for example, it'll start a new selection if you don't move back with a second `C-x C-x` again first.

## Symbol

Oddly there's no mark command to mark the current symbol, but `M-s .` to start an `isearch` for the current symbol, followed by `M-w` works to copy it.

## Mark Within Delimiters

1. Use `M-@` (`mark-sexp`) to select the text including the delimiters
2. Move the cursor right, so it's within the delimiter on the left side
3. Use `C-x C-x` (`exchange-point-and-mark`) to switch to the other side
4. Move the cursor left twice, so it's within the delimiters on the right side
