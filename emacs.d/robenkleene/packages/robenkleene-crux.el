;;; robenkleene-crux.el --- robenkleene-crux
;;; Commentary:
;;; Code:

(use-package crux
  :commands (remove rename crux-delete-file-and-buffer crux-rename-file-and-buffer)
  :config
  (defalias 'remove 'crux-delete-file-and-buffer)
  (defalias 'rename 'crux-rename-file-and-buffer)
  )

(provide 'robenkleene-crux)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-crux.el ends here
