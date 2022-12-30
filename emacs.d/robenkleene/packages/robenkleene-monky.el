;;; robenkleene-monky.el --- robenkleene-monky
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package monky
  :commands
  (monky-status)
  :init
  (setq monky-process-type 'cmdserver)
  )

(provide 'robenkleene-monky)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-monky.el ends here
