# Opening Windows

- `<C-w>n` or `:new`: New empty horizontal split
- `:vnew`: New empty vertical split
- `<C-w>v`: New vertical split with current file
- `<C-w><C-s>`: New horizontal split with current file
- `:enew`: New window replacing current window
- `:only`: Close all windows except for the current one

## File at Cursor

- `gf`: Edit file at cursor in current window
- `gF`: Edit file at cursor in current window at grep line number
- `<C-w>f`: Edit file at cursor in horizontal split
- `<C-w>F`: Edit file at cursor in horizontal split at grep line number
- `<C-w>gf`: Edit file at cursor in tab
- `<C-w>gF`: Edit file at cursor in tab at grep line number

# Closing Windows

- `<C-w>c`: Close the current window
- `<C-w>o`: Close other windows

# Moving Windows

- `<C-w>H`: Move window left
- `<C-w>K`: Move window up
- `<C-w>J`: Move window down
- `<C-w>K`: Move window right

# Resizing Windows

- `<C-w>_`: Resize window to maximum height
- `<C-w>|`: Resize window to maximum width
- `<C-w>=`: Resize windows equally

# Switching Windows

- `<C-w>w` / `<C-w>W`: Move to window below & right / above & left of current window
- `<C-w>p`: Previous window

# Resizing Windows

- `<C-w>=`: Resize windows equally
- `<C-w>>`: Resize vertical window larger
- `<C-w><`: Resize vertical window smaller
- `<C-w>+`: Resize horizontal window larger
- `<C-w>-`: Resize horizontal window smaller

## By Direction

- `<C-w>h`: Move to window left
- `<C-w>k`: Move to window up
- `<C-w>j`: Move to window down
- `<C-w>k`: Move to window right

# Tabs

- `<C-w>T`: Move a window to a new tab
- `:tabe[dit]` / `:tabnew`: Make new tab
- `:tabc[lose]`: Close tab
- `gt`: Next tab
- `gT`: Previous tab
- `:tab <command>`: Open command in a new tab
- `:[sp]lit +<command>`: Is supposed to work similarly for splits, but it's less predictable (e.g., `:split +tag <term>` seems to fail)
- `:tabonly`: Close all tabs except for the current one

# Cursor Position in Window

- `zz`: Center cursor in window vertically
- `z.`: Center cursor in window vertically and move cursor to first non-blank character
- `zt` / `zb`: Align cursor with top / bottom of window
- `z<CR>` / `z-`: Align cursor with top / bottom of window and move cursor to first non-blank character
- `zh` / `zl`: Move window left / right
- `zH` / `zL`: Move window left / right by half a screen
- `zs` / `ze`: Align cursor with left / right side of window
- `zszH`: Center cursor horizontally

# Arrangements

## Two vertical splits below one horizontal split

1. `<C-w> L`: To move the first vertical split vertical
2. `<C-w> L`: To move the second vertical split vertical
3. `<C-w> K`: To move the third split horizontal above the other two
