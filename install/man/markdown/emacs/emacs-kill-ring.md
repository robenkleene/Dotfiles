%

# Emacs Kill Ring

Kill commands append to the clipboard, until a movement command happens.

## Yank

- `C-y`: Yank last kill
- `M-y`: Cycle through kill ring replacing yanked text

## No Region

- `M-d`: Forward kill word
- `C-<backspace>`: Backward kill word
- `C-k`: Kill rest of line
- `M-k`: Kill sentence
- `C-M-k`: Kill s-expression

## Region

- `C-w`: Kill active region
- `M-w`: Copy to kill ring

### Modifiers

These modify the next command.

- `C-M-w`: Append next kill
