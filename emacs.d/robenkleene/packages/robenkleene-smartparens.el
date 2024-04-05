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
  ;; Make smartparens work better with Emacs lisp, e.g., code in comments with
  ;; `' and single-quoting variables
  (require 'smartparens-config)
  )

(provide 'robenkleene-smartparens)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-smartparens.el ends here
