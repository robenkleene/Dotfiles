;;; robenkleene-smartparens.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:

(use-package smartparens
  :diminish
  :commands (smartparens-strict-mode smartparens-mode)
  :init
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-mode)
  :config
  (sp-local-pair 'emacs-lisp-mode "`" "'")
  )

(provide 'robenkleene-smartparens)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-smartparens.el ends here
