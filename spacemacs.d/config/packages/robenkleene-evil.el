(define-key evil-evilified-state-map "\C-w" 'evil-window-map)
(define-key evil-evilified-state-map "\C-b" 'evil-scroll-page-up)
(define-key evil-evilified-state-map "\C-f" 'evil-scroll-page-down)
(define-key evil-evilified-state-map "?" 'evil-search-backward)
(define-key evil-evilified-state-map "-" 'dired-jump)
;; Evilify
(evilify magit-diff-mode magit-diff-mode-map)
(evilify Custom-mode custom-mode-map)
(evilify debugger-mode debugger-mode-map)
;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
;; Re-enable esc
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-normal-state-map "-" 'dired-jump)
(define-key evil-motion-state-map "-" 'dired-jump)

;; Evil Leader
(evil-leader/set-key
  "ow" 'toggle-truncate-lines)

;; Other Leader
(defvar robenkleene-leader-map (make-keymap))
(define-key robenkleene-leader-map (kbd "w") 'toggle-truncate-lines)

(define-key evil-normal-state-map (kbd "\\") robenkleene-leader-map)
(define-key evil-motion-state-map (kbd "\\") robenkleene-leader-map)


;; Insert Mode Keys
;; (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)
(provide 'robenkleene-evil)
