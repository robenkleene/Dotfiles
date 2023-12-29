# Outline

- `M-RET`: New sibling list item before children
- `C-RET`: New sibling list item after children (doesn't work in terminal Emacs)
- `M-RET <tab>`: New first child list item
- `C-RET <tab>`: New last child list item (doesn't work in terminal Emacs)
- `M-S-RET`: New todo item at current level before children (doesn't work in terminal Emacs)
- `C-S-RET`: New todo item at current level after children (doesn't work in terminal Emacs)
- `M-S-RET <tab>`: New child todo item before children (doesn't work in terminal Emacs)
- `C-S-RET <tab>`: New child todo item after children (doesn't work in terminal Emacs)
- `C-c C-x C-w` / `C-c C-x C-y`: Kill / paste subtree

## Moving

- `M-left` / `M-right`: Demote / promote item
- `M-up` / `M-down`: Move item up / down
- `C-c C-w`: Move item to a category

# Todo

- `S-<left>` / `S-<right>` on a todo: Cycle todo states (`DONE` / `TODO`)
- `C-c C-t`: Cycle todo state
- `C-c C-d` / `C-u C-c C-d`: Insert / remove deadline
- `C-c C-s` / `C-u C-c C-s`: Insert / remove schedule
- `C-c .`: Change date
- To make a weekly repeating todo, just add `+7d` to the end of the date, e.g., `2023-05-29 Mon +7d`

## Date Picker

- `S-<left>` / `S-<right>`: Move day left / right
- `S-<up>` / `S-<down>`: Move week backward / forward
- `+1` / `+1d`: Schedule date to tomorrow
- `.`: Go to today

# Archive

- `C-c C-x C-s`: Archive item

# Sorting

- `C-c ^` / `org-sort`: Sort (then `d` to sort by deadline)

# Columns

- `C-c C-x C-c` / `C-c C-c`: Turn on / off column view for the current subtree
