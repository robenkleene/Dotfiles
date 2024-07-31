;;; robenkleene-adaptive-wrap.el --- robenkleene-adaptive-wrap
;;; Commentary:
;;; Code:

(use-package adaptive-wrap
  :diminish
  :init
  ;; This doesn't play nice with Org mode with `org-indent-mode' on
  (add-hook 'markdown-mode-hook 'adaptive-wrap-prefix-mode)
  )

(provide 'robenkleene-adaptive-wrap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-adaptive-wrap.el ends here
