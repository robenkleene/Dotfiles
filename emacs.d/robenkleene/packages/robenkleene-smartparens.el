;;; robenkleene-smartparens.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar smartparens)
(use-package smartparens
  :ensure t
  :init
  (progn
    ;; Enable smartparens-mode in `eval-expression'
    (add-hook 'minibuffer-setup-hook (lambda ()
                                       (if (eq this-command 'eval-expression)
                                           (smartparens-mode)))
              )
    (custom-set-faces
     `(sp-show-pair-match-face ((t (:inherit show-paren-match))))
     `(sp-show-pair-mismatch-face ((t (:inherit show-paren-mismatch))))
     )
    )
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (defvar sp-highlight-pair-overlay)
    (defvar sp-highlight-wrap-overlay)
    (defvar sp-highlight-wrap-tag-overlay)
    (setq sp-highlight-pair-overlay nil)
    (setq sp-highlight-wrap-overlay nil)
    (setq sp-highlight-wrap-tag-overlay nil)
    )
)

(provide 'robenkleene-smartparens)
;;; robenkleene-smartparens.el ends here
