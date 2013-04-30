(provide 'rk-settings)

;; Auto-Save Files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Quick Settings

;; Visual
(global-visual-line-mode t) ;; Don't split words when line wrapping
(setq visible-bell 1) ;; All the beeping is annoying

;; (setq scroll-preserve-screen-position t) ;; Cursor stays in same position on window
(delete-selection-mode 1)
(setq explicit-shell-file-name "/bin/bash") ;; zsh doesn't play nice with shell
(setq inhibit-startup-message t) ;; Go straight to scratch
;; These two magic lines improve scrolling
;; (setq scroll-step 1)
;; (setq scroll-conservatively 10000)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-preserve-screen-position t)
