(provide 'rk-functions)

(defun rk-install-package-if-missing (p)
  (when (not (package-installed-p p))
    (package-install p)))

(defun rk-bookmark-scratch ()
  (interactive)
  (dired "~/Development/Scratch"))

(defun rk-window-resize-for-shell ()
  "Resize current window for three fourths"
  (interactive)
  (let ((size (truncate (* .25 (frame-height)))))
    (if (< size (window-height))
        (window-resize nil (- size (window-height))))))
