;;; robenkleene-adaptive-wrap.el --- robenkleene-adaptive-wrap
;;; Commentary:
;;; Code:

(use-package adaptive-wrap
  :diminish
  :init
  (add-hook 'text-mode-hook 'adaptive-wrap-prefix-mode)
  )

(provide 'robenkleene-adaptive-wrap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-adaptive-wrap.el ends here
