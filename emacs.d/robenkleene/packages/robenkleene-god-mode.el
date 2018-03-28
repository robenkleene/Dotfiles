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
  ;; (global-set-key (kbd "C-x C-^]") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-^[") 'previous-buffer)
  ;; (global-set-key (kbd "C-x C-<right>") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-<left>") 'previous-buffer)

  ;; God Override Mode
  (defvar robenkleene/god-override-minor-mode-map (make-keymap))
  (defvar robenkleene/god-override-x-map (make-keymap))
  (define-minor-mode robenkleene/god-override-minor-mode
    "My bindings for `god-exempt-major-modes'"
    nil
    nil
    'robenkleene/god-override-minor-mode-map)
  (define-key robenkleene/god-override-minor-mode-map (kbd "x") robenkleene/god-override-x-map)
  ;; Bindings
  (define-key robenkleene/god-override-x-map (kbd "o") 'other-window)
  (define-key robenkleene/god-override-x-map (kbd "1") 'delete-other-windows)
  (define-key robenkleene/god-override-x-map (kbd "2") 'split-window-below)
  (define-key robenkleene/god-override-x-map (kbd "3") 'split-window-right)
  (define-key robenkleene/god-override-x-map (kbd "0") 'delete-window)
  (define-key robenkleene/god-override-x-map (kbd "c") 'save-buffers-kill-terminal)
  (define-key robenkleene/god-override-x-map (kbd "s") 'save-buffer)
  (define-key robenkleene/god-override-x-map (kbd "b") 'ibuffer)
  (define-key robenkleene/god-override-x-map (kbd "<left>") 'previous-buffer)
  (define-key robenkleene/god-override-x-map (kbd "<right>") 'next-buffer)

  ;; Overridden Modes
  (add-hook 'dired-mode-hook 'robenkleene/god-override-minor-mode)
  (add-hook 'magit-status-mode-hook 'robenkleene/god-override-minor-mode)

  )

(provide 'robenkleene-god-mode)
;;; robenkleene-god-mode.el ends here
