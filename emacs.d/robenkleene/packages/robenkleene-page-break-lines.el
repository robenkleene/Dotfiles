;;; robenkleene-page-break-lines.el --- robenkleene-page-break-lines
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package page-break-lines
  :init
  (global-page-break-lines-mode)
  )

(provide 'robenkleene-page-break-lines)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-page-break-lines.el ends here
