(provide 'rk-functions)

(defun rk-install-package-if-missing (p)
  (when (not (package-installed-p p))
    (package-install p)))

(defun rk-bookmark-scratch ()
  (interactive)
  (dired "~/Development/Scratch"))

(require 'find-file-in-project)
(defun rk-project-directory ()
  (ffip-project-root))


