;;; robenkleene-diff.el --- robenkleene-diff
;;; Commentary:
;;; Code:

(add-hook 'diff-mode-hook (lambda () (view-mode)))

(provide 'robenkleene-diff)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-diff.el ends here
