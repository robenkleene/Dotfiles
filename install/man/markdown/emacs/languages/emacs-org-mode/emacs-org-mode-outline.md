- `⇧⇥`: Cycling visibility for the whole document

# New Sibling

The new sibling keys will create a list item when in used in the context of a list, and a headline in the context of a headline. If a blank line exists above the current item, then a blank line is inserted before the new sibling (this behavior can be changed by setting `org-blank-before-new-entry`, but usually this can be mediated just by not including a blank line between the document title and the first header).

- `M-RET`: New sibling headline or list item before children, split at insertion point
- `M-m M-RET`: Add new sibling above this headline (if at the beginning of the line `M-RET` adds above current heading
- `C-u M-RET`: New sibling headline or list item before children, always below current
- `M-RET <tab>`: New first child headline or list item (after creating a new item, `<tab>` allows cycling through indent levels, `<backtab>` does not unindent though, just use `<tab>` and keep cycling)
- `C-c C-x C-w` / `C-c C-x C-y`: Kill / paste subtree

## Additions Poorly Supported in Terminal

- `C-RET`: New sibling headline or list item after children
- `C-RET <tab>`: New last child headline or list item
- `C-S-RET`: New todo headline or list item at current level after children
- `C-S-RET <tab>`: New child todo item after children

## Additions Unsupported in Terminal

- `M-S-RET`: New todo item at current level before children
- `M-S-RET <tab>`: New child todo item before children

# Navigation

- `M-{` / `M-}`: Previous / next element
- `C-c C-p` / `C-c C-n`: Previous / next item
- `C-c C-b` / `C-c C-f`: Previous / next sibling
- `C-c C-u`: Go to parent

# Moving

- `M-left` / `M-right`, `C-c C-<` / `C-c C->`: Promote / demote item
- `M-up` / `M-down`: Move item up / down
- `C-c C-w`: Move item to a category (note this can only move an item to another top-level category, for this reason, it's a good idea to have your main lists at the top level)

# Deleting

- To delete an item `C-a C-k C-k` or `C-k C-k` at the end of the previous line

# Folding

- `org-fold-hide-sublevels`: Collapse everything
