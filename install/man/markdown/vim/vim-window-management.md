%

# `vim` Window Management

## Opening & Closing Windows

- `<C-w>c`: Close the current window
- `<C-w>o`: Close other windows
- `<C-w>n` or `:new`: New empty horizontal split
- `:vnew`: New empty vertical split
- `<C-w>v`: New vertical split with current file
- `<C-w><C-s>`: New horizontal split with current file

## Switching Windows

- `<C-w>w`: Next window
- `<C-w>p`: Previous window

## Resizing Windows

- `<C-w>=`: Resize windows equally
- `<C-w>>`: Resize vertical window larger
- `<C-w><`: Resize vertical window smaller
- `<C-w>+`: Resize horizontal window larger
- `<C-w>-`: Resize horizontal window smaller

### By Direction

- `<C-w>h`: Move to window left
- `<C-w>k`: Move to window up
- `<C-w>j`: Move to window down
- `<C-w>k`: Move to window right

## Moving Windows

- `<C-w>H`: Move window left
- `<C-w>K`: Move window up
- `<C-w>J`: Move window down
- `<C-w>K`: Move window right

## Tabs

* `<C-w>T`: Move file to new tab
* `:tabedit %` or `<C-w>T`: Move a window to a new tab
* `:tabnew`: Make new tab
* `:tabe[dit]`: Edit file in tab
* `:tabc[lose]`: Close tab
* `gt`: Next tab
* `gT`: Previous tab

## Window Movement

- `zz`: Center cursor in window
- `z.`: Center cursor in window and move cursor to first non-blank character
- `zt` / `zb`: Align cursor with top / bottom of window
- `z<CR>` / `z-`: Align cursor with top / bottom of window and move cursor to first non-blank character
- `zh` / `zl`: Move window left / right
- `zH` / `zL`: Move window left / right by half a screen
- `zs` / `ze`: Align cursor with left / right side of window
