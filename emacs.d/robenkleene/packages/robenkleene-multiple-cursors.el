;;; robenkleene-multiple-cursors.el --- robenkleene-multiple-cursors
;;; Commentary:
;;; Code:

(use-package multiple-cursors
  :bind
  ("C-c C-c" . mc/edit-lines)
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  )

(provide 'robenkleene-multiple-cursors)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-multiple-cursors.el ends here
