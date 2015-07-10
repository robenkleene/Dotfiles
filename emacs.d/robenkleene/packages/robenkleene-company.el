;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package company
  :ensure t
  :init
  (global-company-mode)
  (setq company-backends '((company-keywords company-semantic company-files company-gtags company-etags company-dabbrev-code) company-capf company-dabbrev))
  )

(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
