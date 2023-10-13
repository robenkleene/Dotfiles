%

# Emacs Undo

- `C-_`: Undo
- `C-g C-_`: Redo
- `C-g C-_ C-_`: Redo twice, etc...

## Notes

- If you can't find an edit, try keeping hitting `undo` over and over again, more than seems necessary. A by product of the undo system, is that undo and redoing pushes changes farther down on the stack.
- `buffer-undo-list`: Variable storing the undo state
