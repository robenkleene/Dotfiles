;;; robenkleene-ledger.el --- robenkleene-ledger
;;; Commentary:
;;; code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package ledger-mode
  :mode "\\.ledger\\'")

(provide 'robenkleene-ledger)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ledger.el ends here
