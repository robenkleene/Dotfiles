;;; robenkleene-adaptive-wrap.el --- robenkleene-adaptive-wrap
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package adaptive-wrap
  :init
  (add-hook 'text-mode-hook 'adaptive-wrap-prefix-mode)
  )

(provide 'robenkleene-adaptive-wrap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-adaptive-wrap.el ends here
