;;; robenkleene-god-mode.el --- robenkleene-god-mode
;;; Commentary:
;;; Code:

(use-package god-mode
  :bind
  ("C-z" . god-mode-all)
  ("M-z" . god-mode-all)
  :ensure
  :init
  (god-mode-all)
  :config
  (define-key god-local-mode-map (kbd "i") 'god-local-mode)
  (define-key god-local-mode-map (kbd "SPC") 'scroll-up-command)
  (define-key god-local-mode-map (kbd "DEL") 'robenkleene/god-backspace)
  (define-key god-local-mode-map (kbd "q") 'quit-window)
  ;; (define-key god-local-mode-map (kbd ";") (lambda ()
  ;;                                            (interactive)
  ;;                                            (god-local-mode -1)
  ;;                                            (iedit-mode)))
  (global-set-key (kbd "C-x C-o") 'other-window)
  (global-set-key (kbd "C-x C-1") 'delete-other-windows)
  (global-set-key (kbd "C-x C-2") 'split-window-below)
  (global-set-key (kbd "C-x C-3") 'split-window-right)
  (global-set-key (kbd "C-x C-0") 'delete-window)
  (global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
  ;; (global-set-key (kbd "C-x C-^]") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-^[") 'previous-buffer)
  ;; (global-set-key (kbd "C-x C-<right>") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-<left>") 'previous-buffer)

  (defun robenkleene/god-backspace ()
    "Delete the current region or scroll down."
    (interactive)
    (if (use-region-p)
        (delete-region (region-beginning) (region-end))
      (scroll-down-command)
      )
    )

  ;; God Override Mode
  (defvar robenkleene/mortal-mode-map (make-keymap))
  (defvar robenkleene/mortal-map (make-keymap))
  (define-minor-mode robenkleene/mortal-mode
    "My bindings for `god-exempt-major-modes'"
    nil
    nil
    'robenkleene/mortal-mode-map)
  (define-key robenkleene/mortal-mode-map (kbd "SPC") 'scroll-up-command)
  (define-key robenkleene/mortal-mode-map (kbd "DEL") 'scroll-down-command)  
  (define-key robenkleene/mortal-mode-map (kbd "s") 'isearch-forward-regexp)
  (define-key robenkleene/mortal-mode-map (kbd "r") 'isearch-backward-regexp)
  (define-key robenkleene/mortal-mode-map (kbd "c") robenkleene/leader-map)
  ;; Bindings
  (define-key robenkleene/mortal-mode-map (kbd "x") robenkleene/mortal-map)
  (define-key robenkleene/mortal-map (kbd "o") 'other-window)
  (define-key robenkleene/mortal-map (kbd "1") 'delete-other-windows)
  (define-key robenkleene/mortal-map (kbd "2") 'split-window-below)
  (define-key robenkleene/mortal-map (kbd "3") 'split-window-right)
  (define-key robenkleene/mortal-map (kbd "0") 'delete-window)
  (define-key robenkleene/mortal-map (kbd "c") 'save-buffers-kill-terminal)
  (define-key robenkleene/mortal-map (kbd "s") 'save-buffer)
  (define-key robenkleene/mortal-map (kbd "b") 'ido-switch-buffer)
  (define-key robenkleene/mortal-map (kbd "f") 'find-file-at-point)
  (define-key robenkleene/mortal-map (kbd "<left>") 'previous-buffer)
  (define-key robenkleene/mortal-map (kbd "<right>") 'next-buffer)

  (require 'robenkleene-god-mode-modes)

  (add-hook 'god-mode-enabled-hook (lambda ()
                                     (message "`god-mode' enabled")
                                     (global-hl-line-mode 1)
                                     (robenkleene/mortal-mode -1)
                                     )
            )
  (add-hook 'god-mode-disabled-hook (lambda ()
                                      (message "`god-mode' disabled")
                                      (global-hl-line-mode -1)
                                      )
            )
  )

(provide 'robenkleene-god-mode)
;;; robenkleene-god-mode.el ends here
