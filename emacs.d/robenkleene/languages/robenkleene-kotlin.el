;;; robenkleene-kotlin.el --- robenkleene-kotlin
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package kotlin-mode
  :mode "\\.kt\\'")

(provide 'robenkleene-kotlin)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-kotlin.el ends here
