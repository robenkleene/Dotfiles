;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package company
  :ensure t
  :init
  (global-company-mode)
  ;; `company-capf': built-in autocomplete
  (setq company-backends '((company-keywords company-semantic company-files company-gtags company-etags company-dabbrev-code) company-capf company-ispell company-dabbrev))
  (define-key company-active-map (kbd "C-f") 'company-complete-selection)
  )


(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
