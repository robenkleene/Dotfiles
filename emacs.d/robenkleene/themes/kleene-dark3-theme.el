;; kleene-dark3-theme.el --- Kleene Dark 3

;;; Commentary:
;;; Code:

(deftheme kleene-dark3 "Kleene Dark 3")

(defmacro kleene-dark-with-color-variables (&rest body)
  "`let*' bind all colors defined in `kleene-dark-colors-alist' around BODY.  Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let* ((class '((class color) (min-colors 89)))
          ,@(mapcar (lambda (cons)
                      (list (intern (car cons)) (cdr cons)))
                    kleene-dark-colors-alist))
     ,@body))

;;; Colors

(defvar kleene-dark-colors-alist
  '(
    ;; Ansi
    ("black" . "#000000")
    ("blue" . "#0000F5")
    ("cyan" . "#00ffff")
    ("green" . "#62D63F")
    ("magenta" . "#af00df")
    ("red" . "#D32D1E")
    ("white" . "#ffffff")
    ("yellow" . "#E5E64B")

    ;; Palette
    ("cyan1" . "#23A6B1")
    ("cyan2" . "#35E5E4")
    ("gray1" . "#3a3a3a")
    ("gray2" . "#4e4e4e")
    ("gray3" . "#626262")
    ("gray4" . "#808080")
    ("gray5" . "#b2b2b2")

    ;; Named
    ("comment" . gray3)
    ("error" . red)
    ("diff-add" . green)
    ("diff-remove" . red)
    ("diff-change" . blue)
    ("warning" . yellow)
    ("modeline-active-fg" . white)
    ("modeline-active-bg" . gray4)
    ("modeline-inactive-fg" . gray5)
    ("modeline-inactive-bg" . gray2)
    ("search-fg" . black)
    ("search-bg" . cyan2)
    ("highlight-line-bg" . gray1)

    ;; Temp
    ("act1" . "#808080")
    ("act2" . "#444444")
    ("base" . white)
    ("base-dim" . "#B2B2B2")
    ("highlight-line" . "#3A3A3A")
    ("bg2" . "#4e4e4e")
    ("bg3" . "#121212")
    ("bg4" . "#080808")
    ("border" . "#111111")
    ("cblk" . "#b2b2b2")
    ("cblk-ln" . "#af5faf")
    ("cblk-ln-bg" . "#333333")
    ("cursor" . "#d0d0d0")
    ("header" . base)
    ("highlight-match" . "#4AA4B0")
    ("highlight-search" . "#68E0D8")
    ("lnum" . "#444444")
    ("mat" . "#86dc2f")
    ("meta" . "#af875f")
    ("str" . "#2aa198")
    ("suc" . "#86dc2f")
    ("ttip" . "#888888")
    ("ttip-sl" . "#333333")
    ("type" . "#df005f")
    ("var" . "#8787d7")
    ("war" . "#dc752f")
    ))

;;; Custom Faces
(defface rk-modeline-active  '((t)) "Modeline" :group 'rk-faces)
(defface rk-modeline-inactive '((t)) "Modeline" :group 'rk-faces)


(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark3

;;; Styles

   `(rk-modeline-active ((t (:foreground ,modeline-active-fg :background ,modeline-active-bg))))
   `(rk-modeline-inactive ((t (:foreground ,modeline-inactive-fg :background ,modeline-inactive-bg))))

;;; Syntax

   `(font-lock-builtin-face ((t (:foreground, "#FFFFB6"))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comment))))
   `(font-lock-comment-face ((t (:foreground ,comment))))
   `(font-lock-constant-face ((t (:foreground, "#99CC99"))))
   `(font-lock-doc-face ((t (:foreground, "#A8FF60"))))
   `(font-lock-doc-string-face ((t (:foreground, "#A8FF60"))))
   `(font-lock-function-name-face ((t (:foreground, "#FFD2A7"))))
   `(font-lock-keyword-face ((t (:foreground, "#96CBFE"))))
   `(font-lock-negation-char-face ((t (:foreground, "#FF6C60"))))
   `(font-lock-number-face ((t (:foreground, "#FF73FD"))))
   `(font-lock-preprocessor-face ((t (:foreground, "#96CBFE"))))
   `(font-lock-reference-face ((t (:foreground, "#99CC99"))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground, "#E9C"))))
   `(font-lock-regexp-grouping-construct ((t (:foreground, "#E9C"))))
   `(font-lock-string-face ((t (:foreground, "#A8FF60"))))
   `(font-lock-type-face ((t (:foreground, "#FFFFB6"))))
   `(font-lock-variable-name-face ((t (:foreground, "#C6C5FE"))))
   `(font-lock-warning-face ((t (:foreground, "#FF6C60"))))

;;; User-Interface
   `(hl-line ((t (:background ,gray1))))
   `(isearch ((t (:foreground ,black :background ,cyan1))))
   `(minibuffer-prompt ((t (:foreground ,black :background ,cyan1 :bold t))))
   `(isearch-fail ((t (:foreground ,red))))
   `(link ((t (:foreground ,cyan :underline t))))
   `(region ((t (:background ,highlight-match :foreground ,black))))
   `(mode-line-inactive ((t (:inherit rk-modeline-inactive))))
   `(mode-line ((t (:inherit rk-modeline-active))))
   
;;; Packages

   ;; Rainbow Delimiters
   `(rainbow-delimiters-depth-1-face ((t (:bold nil :foreground "#AFD7D7"))))
   `(rainbow-delimiters-depth-2-face ((t (:bold nil :foreground "#01A6B2"))))
   `(rainbow-delimiters-depth-3-face ((t (:bold nil :foreground "#B0FFD7"))))
   `(rainbow-delimiters-depth-4-face ((t (:bold nil :foreground "#D7AFFF"))))
   `(rainbow-delimiters-depth-5-face ((t (:bold nil :foreground "#00D900"))))
   `(rainbow-delimiters-depth-6-face ((t (:bold nil :foreground "#D0D0D0"))))
   `(rainbow-delimiters-depth-7-face ((t (:bold nil :foreground "#999900"))))
   `(rainbow-delimiters-depth-8-face ((t (:bold nil :foreground "#AFD7FF"))))
   `(rainbow-delimiters-depth-9-face ((t (:bold nil :foreground "#01A6B2"))))

   ;; diff
   `(diff-added             ((t :background unspecified :foreground ,green)))
   `(diff-changed           ((t :background unspecified :foreground ,blue)))
   `(diff-header            ((t :background unspecified :foreground ,base)))
   `(diff-indicator-added   ((t :inherit diff-added)))
   `(diff-indicator-changed ((t :inherit diff-changed)))
   `(diff-indicator-removed ((t :inherit diff-removed)))
   `(diff-refine-added      ((t :inherit diff-added)))
   `(diff-refine-changed    ((t :inherit diff-changed)))
   `(diff-refine-removed    ((t :inherit diff-removed)))
   `(diff-removed           ((t :background unspecified :foreground ,red)))

   ;; dired
   `(dired-directory ((t (:inherit link :underline nil))))
   `(dired-flagged ((t (:foreground ,red))))
   `(dired-header ((t (:background ,highlight-match :foreground ,black :bold t))))
   `(dired-ignored ((t (:inherit shadow))))
   `(dired-mark ((t (:foreground ,blue :inherit bold))))
   `(dired-marked ((t (:foreground ,magenta :inherit bold))))
   `(dired-perm-write ((t (:foreground ,base :underline t))))
   `(dired-symlink ((t (:foreground ,cyan :background unspecified :inherit bold))))
   `(dired-warning ((t (:foreground ,war))))

   ;; magit
   `(magit-branch ((t (:foreground ,white :inherit bold))))
   `(magit-branch-current ((t (:foreground ,base :inherit bold :box t))))
   `(magit-branch-local ((t (:inherit magit-branch-current))))
   `(magit-branch-remote ((t (:inherit magit-branch-current))))
   `(magit-diff-context ((t (:foreground ,comment))))
   `(magit-diff-context-highlight ((t (:inherit magit-diff-context :background ,highlight-line))))
   `(magit-diff-file-header ((t (:foreground ,comment))))
   `(magit-diff-file-heading ((t (:foreground ,base))))
   `(magit-diff-file-heading-highlight ((t (:inherit magit-diff-file-heading :background ,highlight-line))))
   `(magit-diff-hunk-header ((t (:foreground ,ttip))))
   `(magit-diff-hunk-heading ((t (:foreground ,ttip))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,highlight-line :foreground ,ttip))))
   `(magit-hunk-heading ((t (:background ,bg3))))
   `(magit-hunk-heading-highlight ((t (:background ,highlight-line))))
   `(magit-item-highlight ((t :background ,highlight-line :foreground unspecified)))
   `(magit-section-heading ((t (:foreground ,white :inherit bold))))
   `(magit-section-highlight ((t (:background ,highlight-line :foreground nil))))
   `(magit-section-title ((t (:background ,highlight-line :foreground ,white :inherit bold))))
   `(magit-diff-added ((t (:inherit diff-added))))
   `(magit-diff-removed ((t (:inherit diff-removed))))
   `(magit-diff-added-highlight ((t (:inherit diff-added :background ,highlight-line))))
   `(magit-diff-removed-highlight ((t (:inherit diff-removed :background ,highlight-line))))

   ;; markdown
   `(markdown-header-face-1 ((t (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-2 ((t (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-3 ((t (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-4 ((t (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-5 ((t (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-6 ((t (:inherit bold :foreground ,header :background unspecified))))

   ;; show-paren
   `(show-paren-match ((t (:background ,act1))))
   `(show-paren-mismatch ((t (:foreground ,red))))

   ;; smartparens
   `(sp-pair-overlay-face ((t (:background ,highlight-match :foreground nil))))
   `(sp-show-pair-match-face ((t (:foreground ,mat :inherit bold :underline t))))
   ))

;;; Variables
(kleene-dark-with-color-variables
  (custom-theme-set-variables
   'kleene-dark3
   `(ansi-color-names-vector [,black ,red ,green ,yellow ,blue ,magenta ,cyan ,white]))
  )

(provide-theme 'kleene-dark3)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; kleene-dark3-theme.el ends here
