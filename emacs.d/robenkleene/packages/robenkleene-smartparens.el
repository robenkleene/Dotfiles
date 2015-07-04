;;; robenkleene-smartparens.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:


(eval-after-load 'smartparens
  '(progn
     (defvar sp-highlight-pair-overlay)
     (defvar sp-highlight-wrap-overlay)
     (defvar sp-highlight-wrap-tag-overlay)
     (setq sp-highlight-pair-overlay nil)
     (setq sp-highlight-wrap-overlay nil)
     (setq sp-highlight-wrap-tag-overlay nil)
     ))

(require 'smartparens-config)

(custom-set-faces
 `(sp-show-pair-match-face ((t (:inherit show-paren-match))))
 `(sp-show-pair-mismatch-face ((t (:inherit show-paren-mismatch))))
 )

(smartparens-global-mode 1)

(provide 'robenkleene-smartparens)
;;; robenkleene-smartparens.el ends here
