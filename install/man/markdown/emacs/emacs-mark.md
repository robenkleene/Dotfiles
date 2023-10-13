# Emacs Mark

## Movement

- `C-u C-SPC`: Pop buffer local mark (go to previous mark, repeatable)
- `C-x C-SPC`: Pop global mark
- `C-x C-x`: Swap the point and mark (e.g., to adjust the other side of a selection)
- `C-SPC C-SPC`: Push mark (set a mark with no region)
- `isearch` automatically sets a mark when entering a search result with `RET`

## Setting Mark

- `C-M-]`: Mark s-expression
- `C-x h`: Mark buffer
- `M-h`: Mark paragraph
- `C-M-h`: Mark `defun`
- `C-x C-p`: Mark page
- `M-@`: Mark word

### Symbol

Oddly there's no mark command to mark the current symbol, but `M-s .` to start an `isearch` for the current symbol, followed by `M-w` works to copy it.
