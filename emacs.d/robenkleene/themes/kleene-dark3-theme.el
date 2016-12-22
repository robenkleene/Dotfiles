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
    ("diff-add" . green)
    ("diff-change" . blue)
    ("diff-remove" . red)
    ("error" . red)
    ("highlight-line-bg" . gray1)
    ("link" . cyan)
    ("modeline-active-bg" . gray4)
    ("modeline-active-fg" . white)
    ("modeline-inactive-bg" . gray2)
    ("modeline-inactive-fg" . gray5)
    ("search-bg" . cyan2)
    ("search-fg" . black)
    ("match-bg" . cyan1)
    ("match-fg" . black)
    ("warning" . yellow)

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

(defface rk-comment '((t)) "Comments" :group 'rk-faces)
(defface rk-text '((t)) "Text" :group 'rk-faces)
(defface rk-diff-add '((t)) "Diff add" :group 'rk-faces)
(defface rk-diff-change'((t)) "Diff change" :group 'rk-faces)
(defface rk-diff-remove '((t)) "Diff remove" :group 'rk-faces)
(defface rk-error '((t)) "Errors" :group 'rk-faces)
(defface rk-header'((t)) "Header" :group 'rk-faces)
(defface rk-highlight-line '((t)) "Highlight line" :group 'rk-faces)
(defface rk-link '((t)) "Warning" :group 'rk-faces)
(defface rk-match'((t)) "Match" :group 'rk-faces)
(defface rk-modeline-active  '((t)) "Active mode-line" :group 'rk-faces)
(defface rk-modeline-inactive '((t)) "Inactive mode-line" :group 'rk-faces)
(defface rk-prompt'((t)) "Prompt" :group 'rk-faces)
(defface rk-search '((t)) "Search" :group 'rk-faces)
(defface rk-warning '((t)) "Warning" :group 'rk-faces)

;;; Theme

(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark3

   ;;;; Styles
   `(rk-comment ((t (:foreground ,comment))))
   `(rk-diff-add ((t (:foreground ,diff-add))))
   `(rk-diff-change ((t (:foreground ,diff-change))))
   `(rk-diff-remove ((t (:foreground ,diff-remove))))
   `(rk-error ((t (:foreground ,error))))
   `(rk-header ((t (:foreground ,white :bold t))))
   `(rk-highlight-line ((t (:background ,highlight-line-bg))))
   `(rk-link ((t (:foreground ,link :underline t))))
   `(rk-match ((t (:foreground ,match-fg :background ,match-bg))))
   `(rk-modeline-active ((t (:foreground ,modeline-active-fg :background ,modeline-active-bg))))
   `(rk-modeline-inactive ((t (:foreground ,modeline-inactive-fg :background ,modeline-inactive-bg))))
   `(rk-prompt ((t (:inherit rk-match :bold t))))
   `(rk-search ((t (:foreground ,search-fg :background ,search-bg))))
   `(rk-text ((t (:foreground ,white))))
   `(rk-warning ((t (:foreground ,warning))))

   ;;;; Syntax
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

   ;;;; User-Interface
   `(hl-line ((t (:inherit rk-highlight-line))))
   `(minibuffer-prompt ((t (:inherit rk-prompt))))
   `(region ((t (:inherit rk-search))))

   ;;;; Text
   `(link ((t (:inherit rk-link))))

   ;;;; Mode Line
   `(mode-line-inactive ((t (:inherit rk-modeline-inactive))))
   `(mode-line ((t (:inherit rk-modeline-active))))

   ;;;; Search
   `(isearch ((t (:inherit rk-search))))
   `(isearch-fail ((t (:inherit rk-error))))
   `(lazy-highlight ((t (:inherit rk-match))))

   ;;;; Ido
   `(ido-first-match ((t (:inherit rk-search))))
   
;;; Packages

   ;;;; Helm
   `(helm-selection ((t (:inherit rk-highlight-line))))
   `(helm-match ((t (:inherit rk-match))))

   ;;;; Rainbow Delimiters
   `(rainbow-delimiters-depth-1-face ((t (:bold nil :foreground "#AFD7D7"))))
   `(rainbow-delimiters-depth-2-face ((t (:bold nil :foreground "#01A6B2"))))
   `(rainbow-delimiters-depth-3-face ((t (:bold nil :foreground "#B0FFD7"))))
   `(rainbow-delimiters-depth-4-face ((t (:bold nil :foreground "#D7AFFF"))))
   `(rainbow-delimiters-depth-5-face ((t (:bold nil :foreground "#00D900"))))
   `(rainbow-delimiters-depth-6-face ((t (:bold nil :foreground "#D0D0D0"))))
   `(rainbow-delimiters-depth-7-face ((t (:bold nil :foreground "#999900"))))
   `(rainbow-delimiters-depth-8-face ((t (:bold nil :foreground "#AFD7FF"))))
   `(rainbow-delimiters-depth-9-face ((t (:bold nil :foreground "#01A6B2"))))

   ;;;; diff
   `(diff-added ((t :inherit rk-diff-add)))
   `(diff-changed ((t :inherit rk-diff-change)))
   `(diff-removed ((t :inherit rk-diff-remove)))

   ;;;; dired
   `(dired-directory ((t (:inherit link :underline nil))))
   `(dired-header ((t (:inherit rk-prompt))))

   ;;;; magit
   ;;;;; Metadata
   `(magit-branch ((t (:inherit rk-header))))
   `(magit-branch-current ((t (:inherit magit-branch))))
   `(magit-branch-local ((t (:inherit magit-branch))))
   `(magit-branch-remote ((t (:inherit magit-branch))))
   ;;;;; Diff
   `(magit-diff-added ((t (:inherit rk-diff-add))))
   `(magit-diff-context ((t (:inherit rk-comment))))
   `(magit-diff-removed ((t (:inherit rk-diff-remove))))
   ;;;;; Diff Hierarchy
   `(magit-diff-file-header ((t (:inherit rk-comment))))
   `(magit-diff-file-heading ((t (:inherit rk-text))))
   `(magit-diff-hunk-header ((t (:inherit rk-text))))
   `(magit-diff-hunk-heading ((t (:inherit rk-text))))
   `(magit-hunk-heading ((t (:inherit rk-header))))
   `(magit-section-heading ((t (:inherit rk-header))))
   `(magit-section-title ((t (:inherit rk-header))))
   ;;;;; Highlight
   `(magit-diff-added-highlight ((t (:inherit magit-diff-added :background ,highlight-line-bg))))
   `(magit-diff-context-highlight ((t (:inherit magit-diff-context :background ,highlight-line-bg))))
   `(magit-diff-file-heading-highlight ((t (:inherit magit-diff-file-heading :background ,highlight-line-bg))))
   `(magit-diff-hunk-heading-highlight ((t (:inherit magit-diff-hunk-heading :background ,highlight-line-bg))))
   `(magit-diff-removed-highlight ((t (:inherit magit-diff-removed :background ,highlight-line-bg))))
   `(magit-hunk-heading-highlight ((t (:inherit magit-hunk-heading :background ,highlight-line-bg))))
   `(magit-item-highlight ((t :inherit magit-item-highlight :background ,highlight-line-bg)))
   `(magit-section-highlight ((t (:inherit rk-highlight-line))))
   
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
