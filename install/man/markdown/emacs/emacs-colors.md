%

# `emacs` Colors

- `describe-char`: Good to see why the character at the cursor is colored
- `list-faces-display`: Show defined colors
- `load-theme`: Reload the current theme after changing colors

## Mouse

Some additional characters might be accessible where you can't move your cursor with this technique:

```
(defun robenkleene/describe-char-at-mouse-click (click-event)
  "`describe-char' at CLICK-EVENT's position.
CLICK-EVENT should be a mouse-click event."
  (interactive "e")
  (run-hooks 'mouse-leave-buffer-hook)
  (let ((pos (cadr (event-start click-event))))
    (describe-char pos)))
(global-set-key (kbd "C-c d <down-mouse-1>")
                #'robenkleene/describe-char-at-mouse-click)
```
