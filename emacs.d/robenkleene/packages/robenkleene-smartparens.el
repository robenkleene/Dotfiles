;;; robenkleene-smartparens.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package smartparens
  :commands (smartparens-strict-mode smartparens-mode)
  :bind
  ("C-M-]" . sp-select-next-thing)
  (:map smartparens-strict-mode-map
        ("<M-backspace>" . sp-backward-kill-word)
        )
  (:map smartparens-mode-map
        ("<M-backspace>" . sp-backward-kill-word)
        )
  :init
  ;; This breaks `M-backspace' for backward kill word for some reason?
  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;;                                    (if (eq this-command 'eval-expression)
  ;;                                        (smartparens-mode)))
  ;;           )
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
  :config
  (require 'smartparens-config)
  ;; (push 'markdown-mode sp-ignore-modes-list)
  ;; (smartparens-global-mode 1)
  (sp-use-smartparens-bindings)
  (defvar sp-highlight-pair-overlay)
  (defvar sp-highlight-wrap-overlay)
  (defvar sp-highlight-wrap-tag-overlay)
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)
  ;; Unsetting these lets selecting by word work
  (define-key smartparens-mode-map (kbd "M-F") nil)
  (define-key smartparens-mode-map (kbd "M-B") nil)
  (define-key smartparens-mode-map (kbd "<C-right>") nil)
  (define-key smartparens-mode-map (kbd "<C-left>") nil)
  )

(provide 'robenkleene-smartparens)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-smartparens.el ends here
