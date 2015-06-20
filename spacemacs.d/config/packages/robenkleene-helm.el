(require 'helm-swoop)
;; (eval-after-load 'magit
;;    '(progn
;;       (set-face-background 'magit-item-highlight robenkleene/highlight-background-color)
;;       (define-key magit-status-mode-map (kbd "C-b") 'evil-scroll-page-up)
;;       (define-key magit-status-mode-map (kbd "C-f") 'evil-scroll-page-down)
;;      ))
(define-key helm-swoop-map (kbd "C-w") 'backward-kill-word)
(set-face-attribute 'helm-selection nil
                    :background robenkleene/selection-background-color
                    :foreground 'unspecified)
(provide 'robenkleene-helm)
