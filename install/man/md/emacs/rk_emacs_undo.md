- `C-x u`, `C-/`, `C-_`: Undo
- `C-g C-_`: Redo
- `C-g C-_ C-_`: Redo twice, etc...
- `C-g`: Followed by an undo binding to redo, to do this repeatedly, then use `C-x z` to repeat, followed by tapping `z` over and over again to keep repeating.

# Notes

- If you can't find an edit, try keeping hitting `undo` over and over again, more than seems necessary. A by product of the undo system, is that undo and redoing pushes changes farther down on the stack.
- `buffer-undo-list`: Variable storing the undo state
