# Emacs Tasks Transparent Image Overlay

Execute the following Emacs Lisp to make the current frame transparent, then open in the image:

```
(set-frame-parameter (selected-frame) 'alpha '(50 . 50))
```
