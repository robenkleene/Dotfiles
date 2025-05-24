;;; robenkleene-adaptive-wrap.el --- robenkleene-adaptive-wrap
;;; Commentary:
;;; Code:

(use-package adaptive-wrap
  :hook
  ;; This doesn't play nice with Org mode with `org-indent-mode' on
  (markdown-mode . adaptive-wrap-prefix-mode)
  :diminish
  )

(provide 'robenkleene-adaptive-wrap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-adaptive-wrap.el ends here
