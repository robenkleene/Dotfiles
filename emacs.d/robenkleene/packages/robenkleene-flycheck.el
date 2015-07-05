;;; robenkleene-flycheck.el --- robenkleene-flycheck
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(provide 'robenkleene-flycheck)
;;; robenkleene-flycheck.el ends here
