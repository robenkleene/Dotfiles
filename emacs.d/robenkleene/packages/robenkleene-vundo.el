;;; robenkleene-vundo.el --- robenkleene-vundo
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package vundo
  :commands (vundo)
  )

(provide 'robenkleene-vundo)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vundo.el ends here
