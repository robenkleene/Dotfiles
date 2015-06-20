(define-key evil-evilified-state-map "\C-w" 'evil-window-map)
(define-key evil-evilified-state-map "\C-b" 'evil-scroll-page-up)
(define-key evil-evilified-state-map "\C-f" 'evil-scroll-page-down)
(define-key evil-evilified-state-map "?" 'evil-search-backward)
(define-key evil-evilified-state-map "-" 'dired-jump)
(evilify magit-diff-mode magit-diff-mode-map)
;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
;; Re-enable esc
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-normal-state-map "-" 'dired-jump)
;; Insert Mode Keys
;; (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)
(provide 'robenkleene-evil)
