;; Colors
(defconst robenkleene/highlight-background-color "#000000")
(defconst robenkleene/selection-background-color "#444444")
;; TODO: Make helm headers use these
;; (defconst robenkleene/header-background-color "#AFD7FE")
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
;; (set-face-background 'diff-hunk-header robenkleene/header-background-color)
;; (set-face-foreground 'diff-hunk-header robenkleene/header-foreground-color)
(custom-set-faces
 ;; '(diff-file-header ((t (:foreground robenkleene/header-foreground-color :background robenkleene/header-background-color :inherit nil))))
 ;; '(diff-hunk-header ((t (:foreground robenkleene/header-foreground-color :background robenkleene/header-background-color :inherit nil))))
 '(diff-added ((t (:foreground "#45CA34" :background nil :inherit nil))))
 '(diff-removed ((t (:foreground "#DA4D31" :background nil :inherit nil))))
 )

;; Evil
(set-face-foreground 'evil-search-highlight-persist-highlight-face "#000000")
(set-face-background 'evil-search-highlight-persist-highlight-face "#5FD6FF")


;; Matches
;; TODO: Why isn't this working?
;; Probably underline would look nicer
;; (set-face-background 'show-paren-match "#000000")
;; (set-face-attribute 'show-paren-match nil :background "#444444")

;; (set-face-background 'show-paren-match "#aaaaaa")
;; (set-face-attribute 'show-paren-match nil 
;;                     :weight 'normal :underline t :overline nil :slant 'normal)
(provide 'robenkleene-theme)
