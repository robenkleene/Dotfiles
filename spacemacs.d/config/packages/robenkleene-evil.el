;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(defvar robenkleene-leader-map (make-keymap))
(define-key robenkleene-leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene-leader-map (kbd "t") 'robenkleene/open-terminal-window)
(define-key robenkleene-leader-map (kbd "f") 'robenkleene/open-finder-window)

;; Only use highlight in motion and normal modes
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'evil-normal-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-motion-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-insert-state-entry-hook (lambda () (setq global-hl-line-mode nil)))

(eval-after-load 'evil-evilified-state
  '(progn
     (defvar evil-evilified-state-map)
     (define-key evil-evilified-state-map "\C-w" 'evil-window-map)
     (define-key evil-evilified-state-map "\C-b" 'evil-scroll-page-up)
     (define-key evil-evilified-state-map "\C-f" 'evil-scroll-page-down)
     (define-key evil-evilified-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-evilified-state-map "?" 'evil-search-backward)
     (define-key evil-evilified-state-map "-" 'dired-jump)
     (define-key evil-evilified-state-map (kbd "\\") robenkleene-leader-map)
     ;; Evilify
     (defvar magit-diff-mode)
     (defvar magit-diff-mode-map)
     (defvar Custom-mode)
     (defvar custom-mode-map)
     (defvar debugger-mode)
     (defvar debugger-mode-map)
     (defvar dired-mode)
     (defvar dired-mode-map)
     (declare-function evilify "ext:evil-evilified-state.el")
     (evilify magit-diff-mode magit-diff-mode-map)
     (evilify Custom-mode custom-mode-map)
     (evilify debugger-mode debugger-mode-map)
     (evilify dired-mode dired-mode-map)
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
     (define-key evil-normal-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-motion-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-normal-state-map "-" 'dired-jump)
     (define-key evil-motion-state-map "-" 'dired-jump)
     ;; Other Leader
     (define-key evil-normal-state-map (kbd "\\") robenkleene-leader-map)
     (define-key evil-motion-state-map (kbd "\\") robenkleene-leader-map)
     )
  )

;; Insert Mode Keys
;; (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
