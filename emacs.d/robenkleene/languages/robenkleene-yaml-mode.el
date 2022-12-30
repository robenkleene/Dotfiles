;;; robenkleene-yaml-mode.el --- robenkleene-yaml-mode
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package yaml-mode
  :mode "\\.yaml\\'"
  )

(provide 'robenkleene-yaml-mode)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-yaml-mode.el ends here
