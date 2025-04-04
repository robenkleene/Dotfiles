;;; robenkleene-smartparens.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:

(use-package smartparens
  :hook
  (emacs-lisp-mode . smartparens-strict-mode)
  (eval-expression-minibuffer-setup . smartparens-strict-mode)
  :diminish
  :commands (smartparens-strict-mode smartparens-mode)
  :config
  ;; Make smartparens work better with Emacs lisp, e.g., code in comments with
  ;; `' and single-quoting variables
  (require 'smartparens-config)
  ;; Disable the overlays that show scope while typing
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)
  )

(provide 'robenkleene-smartparens)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-smartparens.el ends here
