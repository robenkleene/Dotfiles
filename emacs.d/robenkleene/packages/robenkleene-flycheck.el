;;; robenkleene-flycheck.el --- robenkleene-flycheck
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package flycheck
  :init
  (global-flycheck-mode)
  (setq flycheck-display-errors-delay 0.1)
  )

(provide 'robenkleene-flycheck)
;;; robenkleene-flycheck.el ends here
