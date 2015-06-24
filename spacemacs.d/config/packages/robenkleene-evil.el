;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-after-load 'evil-evilified-state
  '(progn
     (defvar evil-evilified-state-map)
     (define-key evil-evilified-state-map "\C-w" 'evil-window-map)
     (define-key evil-evilified-state-map "\C-b" 'evil-scroll-page-up)
     (define-key evil-evilified-state-map "\C-f" 'evil-scroll-page-down)
     (define-key evil-evilified-state-map "?" 'evil-search-backward)
     (define-key evil-evilified-state-map "-" 'dired-jump)
     ;; Evilify
     (defvar agit-diff-mode)
     (defvar magit-diff-mode)
     (defvar magit-diff-mode-map)
     (defvar Custom-mode)
     (defvar custom-mode-map)
     (defvar debugger-mode)
     (defvar debugger-mode-map)
     (declare-function evilify "ext:evil-evilified-state.el")
     (evilify magit-diff-mode magit-diff-mode-map)
     (evilify Custom-mode custom-mode-map)
     (evilify debugger-mode debugger-mode-map)
     )
  )

(eval-after-load 'evil
  '(progn
     (defvar evil-insert-state-map)
     (defvar evil-normal-state-map)
     (defvar evil-motion-state-map)
     ;; Disable insert mode key map
     (setcdr evil-insert-state-map nil)
     ;; Re-enable esc
     (define-key evil-insert-state-map [escape] 'evil-normal-state)
     (define-key evil-normal-state-map "-" 'dired-jump)
     (define-key evil-motion-state-map "-" 'dired-jump)
     ;; Other Leader
     (defvar robenkleene-leader-map (make-keymap))
     (define-key robenkleene-leader-map (kbd "w") 'toggle-truncate-lines)

     (define-key evil-normal-state-map (kbd "\\") robenkleene-leader-map)
     (define-key evil-motion-state-map (kbd "\\") robenkleene-leader-map)
     )
  )

;; Evil Leader
;; (evil-leader/set-key
;;   "ow" 'toggle-truncate-lines)

;; Insert Mode Keys
;; (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
