# Emacs Tasks Transparent Image Overlay

Execute the following Emacs Lisp to make the current frame transparent, then open in the image:

```
(set-frame-parameter (selected-frame) 'alpha '(50 . 50))
```

- If you start a drag motion, e.g., on a slider, and then `⌘⇥` back to Emacs, without lifting the mouse button. Then you can continue manipulating a control with the Emacs overlay visible.
