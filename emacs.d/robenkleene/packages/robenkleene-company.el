;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package company
  :bind
  (:map company-active-map
        ("C-p" . company-select-previous-or-abort)
        ("C-n" . company-select-next-or-abort)
        ;; Use tab as well as return for completion
        ("TAB" . company-complete-selection)
        ("<tab>" . company-complete-selection)
        )
  (:map company-search-map
        ("C-p" . company-select-previous-or-abort)
        ("C-n" . company-select-next-or-abort)
        )
  :init
  (setq company-idle-delay .1)
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
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-company.el ends here
