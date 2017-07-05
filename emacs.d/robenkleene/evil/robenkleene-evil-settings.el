;;; robenkleene-evil-settings.el --- robenkleene=evil-dired
;;; Commentary:
;;; Code:

;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
;; Re-enable Esc
(define-key evil-insert-state-map [escape] 'evil-normal-state)

(setq-default cursor-type 'bar) 
;; Setup highlight line
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'evil-normal-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-motion-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-insert-state-entry-hook (lambda () (setq global-hl-line-mode nil)))
(add-hook 'evil-visual-state-entry-hook (lambda () (setq global-hl-line-mode nil)))

(provide 'robenkleene-evil-settings)
;;; robenkleene-evil-settings.el ends here
