;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package company
  :ensure t
  :init
  (global-company-mode)
  (setq company-backends '((company-keywords company-semantic company-files company-gtags company-etags company-dabbrev-code) company-capf company-ispell company-dabbrev))
  )

;; `company-capf': built-in autocomplete

(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
