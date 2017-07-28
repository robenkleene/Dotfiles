;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package company
  :init
  (global-company-mode)
  (setq company-global-modes '(not org-mode markdown-mode))
  (setq company-idle-delay .1)
  ;; `company-capf': built-in autocomplete
  (setq company-backends '((company-keywords company-semantic company-files company-gtags company-etags company-dabbrev-code) company-capf company-ispell company-dabbrev))
  (define-key company-active-map (kbd "C-f") 'company-complete-selection)
  )


(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
