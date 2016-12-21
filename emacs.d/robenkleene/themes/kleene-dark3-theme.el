;; kleene-dark3-theme.el --- Kleene Dark 2

;;; Commentary:
;;; Code:

(deftheme kleene-dark3 "Kleene Dark 2")

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
    ;; Colors
    ("aqua" . "#2aa198")
    ("green" . "#21D726")
    ("cyan" . "#00ffff")
    ("red" . "#E30A17")
    ("blue" . "#27E5E4")
    ("magenta" . "#af00df")
    ("yellow" . "#875f00")
    ("black" . "#000000")
    ;; Syntax
    ("keyword" . "#FFFFB6")
    ("comment" . "#626262")
    ("const" . "#99CC99")
    ("func" . "#FFD2A7")
    ;; Other
    ("act1" . "#808080")
    ("act2" . "#444444")
    ("base" . "#ffffff")
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
    ("comp" . const)
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

(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark3

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

   `(hl-line ((,class (:background ,highlight-line))))
   `(minibuffer-prompt ((,class (:foreground ,black :background ,highlight-match :bold t))))
   `(isearch ((,class (:background ,highlight-search :foreground ,black))))
   `(isearch-fail ((,class (:background unspecified :foreground ,red))))
   `(link ((,class (:foreground ,blue :underline t))))
   `(link-visited ((,class (:foreground ,cyan :underline t))))
   `(region ((,class (:background ,highlight-match :foreground ,black))))
   
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

;;;;; company
   `(company-echo-common ((,class (:background ,base :foreground ,highlight-line))))
   `(company-preview ((,class (:background ,highlight-line :foreground ,ttip))))
   `(company-preview-common ((,class (:background ,highlight-line :foreground ,base))))
   `(company-preview-search ((,class (:inherit match))))
   `(company-scrollbar-bg ((,class (:background ,bg2))))
   `(company-scrollbar-fg ((,class (:background ,act2))))
   `(company-template-field ((,class (:inherit region))))
   `(company-tooltip ((,class (:background ,highlight-line :foreground ,ttip))))
   `(company-tooltip-annotation ((,class (:foreground ,keyword))))
   `(company-tooltip-common ((,class (:background ,highlight-line :foreground ,base))))
   `(company-tooltip-common-selection ((,class (:foreground ,base))))
   `(company-tooltip-mouse ((,class (:inherit highlight))))
   `(company-tooltip-search ((,class (:inherit match))))
   `(company-tooltip-selection ((,class (:background ,ttip-sl :foreground ,base))))

;;;;; diff
   `(diff-added             ((,class :background unspecified :foreground ,green)))
   `(diff-changed           ((,class :background unspecified :foreground ,blue)))
   `(diff-header            ((,class :background unspecified :foreground ,base)))
   `(diff-indicator-added   ((,class :inherit diff-added)))
   `(diff-indicator-changed ((,class :inherit diff-changed)))
   `(diff-indicator-removed ((,class :inherit diff-removed)))
   `(diff-refine-added      ((,class :inherit diff-added)))
   `(diff-refine-changed    ((,class :inherit diff-changed)))
   `(diff-refine-removed    ((,class :inherit diff-removed)))
   `(diff-removed           ((,class :background unspecified :foreground ,red)))

;;;;; diff-hl
   `(diff-hl-change ((,class :foreground ,blue)))
   `(diff-hl-delete ((,class :foreground ,red)))
   `(diff-hl-insert ((,class :foreground ,green)))

;;;;; dired
   `(dired-directory ((,class (:inherit link :underline nil))))
   `(dired-flagged ((,class (:foreground ,red))))
   `(dired-header ((,class (:background ,highlight-match :foreground ,black :bold t))))
   `(dired-ignored ((,class (:inherit shadow))))
   `(dired-mark ((,class (:foreground ,comp :inherit bold))))
   `(dired-marked ((,class (:foreground ,magenta :inherit bold))))
   `(dired-perm-write ((,class (:foreground ,base :underline t))))
   `(dired-symlink ((,class (:foreground ,cyan :background unspecified :inherit bold))))
   `(dired-warning ((,class (:foreground ,war))))

;;;;; magit
   `(magit-blame-culprit ((,class :foreground ,yellow)))
   `(magit-blame-header  ((,class :foreground ,green)))
   `(magit-blame-sha1    ((,class :foreground ,func)))
   `(magit-blame-subject ((,class :foreground ,yellow)))
   `(magit-blame-time    ((,class :foreground ,green)))
   `(magit-blame-name    ((,class :foreground ,yellow)))
   `(magit-blame-heading ((,class :foreground ,green)))
   `(magit-blame-hash    ((,class :foreground ,func)))
   `(magit-blame-summary ((,class :foreground ,yellow)))
   `(magit-blame-date    ((,class :foreground ,green)))
   `(magit-branch ((,class (:foreground ,const :inherit bold))))
   `(magit-branch-current ((,class (:foreground ,base :inherit bold :box t))))
   `(magit-branch-local ((t (:inherit magit-branch-current))))
   `(magit-branch-remote ((t (:inherit magit-branch-current))))
   `(magit-diff-context ((,class (:foreground ,comment))))
   `(magit-diff-context-highlight ((,class (:inherit magit-diff-context :background ,highlight-line))))
   `(magit-diff-file-header ((,class (:foreground ,comment))))
   `(magit-diff-file-heading ((,class (:foreground ,base))))
   `(magit-diff-file-heading-highlight ((,class (:inherit magit-diff-file-heading :background ,highlight-line))))
   `(magit-diff-hunk-header ((,class (:foreground ,ttip))))
   `(magit-diff-hunk-heading ((,class (:foreground ,ttip))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,highlight-line :foreground ,ttip))))
   `(magit-hash ((,class (:foreground ,var))))
   `(magit-hunk-heading           ((,class (:background ,bg3))))
   `(magit-hunk-heading-highlight ((,class (:background ,highlight-line))))
   `(magit-item-highlight ((,class :background ,highlight-line :foreground unspecified)))
   `(magit-log-author ((,class (:foreground ,func))))
   `(magit-log-head-label-head ((,class (:background ,yellow :foreground ,highlight-line :inherit bold))))
   `(magit-log-head-label-local ((,class (:background ,keyword :foreground ,highlight-line :inherit bold))))
   `(magit-log-head-label-remote ((,class (:background ,suc :foreground ,highlight-line :inherit bold))))
   `(magit-log-head-label-tags ((,class (:background ,magenta :foreground ,highlight-line :inherit bold))))
   `(magit-log-head-label-wip ((,class (:background ,cyan :foreground ,highlight-line :inherit bold))))
   `(magit-log-sha1 ((,class (:foreground ,str))))
   `(magit-process-ng ((,class (:foreground ,war :inherit bold))))
   `(magit-process-ok ((,class (:foreground ,func :inherit bold))))
   `(magit-section-heading        ((,class (:foreground ,keyword :inherit bold))))
   `(magit-section-highlight ((t (:background ,highlight-line :foreground nil))))
   `(magit-section-title ((,class (:background ,highlight-line :foreground ,keyword :inherit bold))))
   `(magit-diff-added ((t (:inherit diff-added))))
   `(magit-diff-removed ((t (:inherit diff-removed))))
   `(magit-diff-added-highlight ((t (:inherit diff-added :background ,highlight-line))))
   `(magit-diff-removed-highlight ((t (:inherit diff-removed :background ,highlight-line))))

;;;;; markdown
   `(markdown-header-face-1 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-2 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-3 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-4 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-5 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-6 ((,class (:inherit bold :foreground ,header :background unspecified))))

;;;;; mode-line
   `(mode-line           ((,class (:foreground ,base :background ,act1 :box (:color ,border :line-width 1)))))
   `(mode-line-inactive  ((,class (:foreground ,base-dim :background ,bg2 :box (:color ,border :line-width 1)))))

   ;;;;; show-paren
   `(show-paren-match ((,class (:background ,act1))))
   `(show-paren-mismatch ((,class (:foreground ,red))))


;;;;; smartparens
   `(sp-pair-overlay-face ((,class (:background ,highlight-match :foreground nil))))
   `(sp-show-pair-match-face ((,class (:foreground ,mat :inherit bold :underline t))))
   ))






;;; Variables
(kleene-dark-with-color-variables
  (custom-theme-set-variables
   'kleene-dark3
   `(ansi-color-names-vector [,bg4 ,red ,green ,yellow ,blue ,magenta ,cyan ,base]))
  )

(provide-theme 'kleene-dark3)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; kleene-dark3-theme.el ends here
