;;; robenkleene-ledger.el --- robenkleene-ledger
;;; Commentary:
;;; code:

(eval-when-compile (require 'use-package))
(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'")

(provide 'robenkleene-ledger)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ledger.el ends here
