;;; robenkleene-god-mode.el --- robenkleene-god-mode
;;; Commentary:
;;; Code:

(use-package god-mode
  :bind
  ("C-z" . god-mode-all)
  :init
  (global-hl-line-mode)
  (make-variable-buffer-local 'global-hl-line-mode)
  (add-hook 'god-mode-enabled-hook (lambda () (setq global-hl-line-mode t)))
  (add-hook 'god-mode-disabled-hook (lambda () (setq global-hl-line-mode nil)))
  (god-mode-all)
  :config
  (define-key god-local-mode-map (kbd "i") 'god-local-mode)
  (global-set-key (kbd "C-x C-o") 'other-window)
  (global-set-key (kbd "C-x C-1") 'delete-other-windows)
  (global-set-key (kbd "C-x C-2") 'split-window-below)
  (global-set-key (kbd "C-x C-3") 'split-window-right)
  (global-set-key (kbd "C-x C-0") 'delete-window)
  )

(provide 'robenkleene-god-mode)
;;; robenkleene-god-mode.el ends here
