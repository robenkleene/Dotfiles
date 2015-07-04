;;; robenkleene-flycheck.el --- robenkleene-flycheck
;;; Commentary:
;;; Code:


(require 'use-package)
(defvar flycheck)
(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(provide 'robenkleene-flycheck)
;;; robenkleene-flycheck.el ends here
