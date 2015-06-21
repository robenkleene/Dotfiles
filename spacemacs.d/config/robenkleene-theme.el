;; Colors
(defconst robenkleene/highlight-background-color "#000000")
(defconst robenkleene/selection-background-color "#444444")
(defconst robenkleene/error-foreground-color "#DA4D31")
(defconst robenkleene/success-foreground-color "#45CA34")
;; TODO: Make helm headers use these
(defconst robenkleene/header-background-color "#444444")
;; (defconst robenkleene/header-foreground-color "#000000")

;; Transparent background
(defun rk-transparent-background-in-terminal ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))
    )
  )
(add-hook 'window-setup-hook 'rk-transparent-background-in-terminal)
(add-hook 'server-visit-hook 'rk-transparent-background-in-terminal)

;; Line Numbers interfere with git gutter
;; (global-linum-mode t)
;; Cursor
;; (set-face-attribute 'highlight nil :foreground 'unspecified :underline nil :background "#000000")

;; Highlight Line
(set-face-foreground 'hl-line nil)
(set-face-underline 'hl-line nil)
(set-face-foreground 'highlight 'unspecified)
(set-face-background 'hl-line robenkleene/highlight-background-color)
(set-face-background 'secondary-selection robenkleene/highlight-background-color)

;; Diff
(eval-after-load 'diff-mode
  '(progn
     (set-face-attribute 'diff-file-header nil :background robenkleene/header-background-color :foreground 'unspecified :inherit nil)
     (set-face-attribute 'diff-hunk-header nil :background robenkleene/header-background-color :foreground 'unspecified :inherit nil)
     (set-face-attribute 'diff-added-face nil :background 'unspecified :foreground robenkleene/success-foreground-color :inherit nil)
     (set-face-attribute 'diff-removed-face nil :background 'unspecified :foreground robenkleene/error-foreground-color :inherit nil)
   ))

;; Evil
(set-face-foreground 'evil-search-highlight-persist-highlight-face "#000000")
(set-face-background 'evil-search-highlight-persist-highlight-face "#5FD6FF")

;; Parens
(set-face-attribute 'show-paren-match nil :weight 'bold :foreground 'unspecified :background 'unspecified :underline t :overline nil :slant 'normal)
(set-face-attribute 'show-paren-mismatch nil :weight 'bold :foreground robenkleene/error-foreground-color :background 'unspecified :underline nil :overline nil :slant 'normal)

(setq debug-on-error t)

;; smartparens
(eval-after-load 'smartparens
   '(progn
      (set-face-attribute 'sp-show-pair-match-face nil :background 'unspecified :foreground 'unspecified :inherit 'show-paren-match)
      (set-face-attribute 'sp-show-pair-mismatch-face nil :background 'unspecified :foreground 'unspecified :inherit 'show-paren-mismatch)
      ))

(provide 'robenkleene-theme)
