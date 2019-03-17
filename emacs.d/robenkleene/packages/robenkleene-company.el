;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package company
  :init
  (setq company-idle-delay .1)
  ;; (setq company-idle-delay .1)
  ;; `company-capf': built-in auto-complete
  (setq company-backends '((company-keywords
                            company-semantic
                            company-files
                            company-gtags
                            company-etags
                            company-dabbrev-code)
                           company-capf
                           company-ispell
                           company-dabbrev))
  ;; (global-company-mode)
  ;; (setq company-global-modes '(not org-mode markdown-mode))
  (add-hook 'prog-mode-hook 'company-mode)
  )


(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
