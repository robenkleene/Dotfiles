;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defalias 'ei 'edit-init)
(defalias 'yg 'yank-to-grep-buffer)
(defalias 'u 'rk/egit-update)
(defalias 'ut 'rk/git-pull-all-text)

(defalias 'yd 'yank-to-diff-buffer)
(defalias 'yg 'yank-to-grep-buffer)

(defun edit-init ()
  "Edit init."
  (interactive)
  (find-file-other-window "~/.emacs.d/robenkleene/robenkleene.el")
  )

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
