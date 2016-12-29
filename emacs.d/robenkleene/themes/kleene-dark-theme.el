;; kleene-dark-theme.el --- Kleene Dark

;;; Commentary:
;;; Code:

(deftheme kleene-dark "Kleene Dark")

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
    ("blue" . "#005FFF")
    ("cyan" . "#4AA4B0")
    ("green" . "#62D63F")
    ("magenta" . "#af00df")
    ("red" . "#D32D1E")
    ("white" . "#ffffff")
    ("yellow" . "#E5E64B")

    ;; Palette
    ;; ("cyan1" . "#23A6B1")
    ;; ("cyan2" . "#35E5E4")
    ("cyan1" . "#0E6A72")
    ("cyan2" . "#1C7D85")
    ("gray0" . "#303030")
    ("gray1" . "#3a3a3a")
    ("gray2" . "#4e4e4e")
    ("gray3" . "#626262")
    ("gray4" . "#808080")
    ("gray5" . "#b2b2b2")

    ;; Named
    ("comment" . gray3)
    ("success" . green)
    ("change" . blue)
    ("error" . red)
    ("highlight-line-bg" . gray1)
    ("callout-bg" . gray0)
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

    ))

;;; Custom Faces

(defface rk-callout '((t)) "Callout block" :group 'rk-faces)
(defface rk-change '((t)) "Change" :group 'rk-faces)
(defface rk-comment '((t)) "Comments" :group 'rk-faces)
(defface rk-diff-add '((t)) "Diff add" :group 'rk-faces)
(defface rk-diff-change'((t)) "Diff change" :group 'rk-faces)
(defface rk-diff-remove '((t)) "Diff remove" :group 'rk-faces)
(defface rk-error '((t)) "Errors" :group 'rk-faces)
(defface rk-header'((t)) "Header" :group 'rk-faces)
(defface rk-highlight-line '((t)) "Highlight line" :group 'rk-faces)
(defface rk-link '((t)) "Link" :group 'rk-faces)
(defface rk-match'((t)) "Match" :group 'rk-faces)
(defface rk-modeline-active  '((t)) "Active mode-line" :group 'rk-faces)
(defface rk-modeline-inactive '((t)) "Inactive mode-line" :group 'rk-faces)
(defface rk-popup '((t)) "Pop-up" :group 'rk-faces)
(defface rk-popup-match '((t)) "Pop-up match" :group 'rk-faces)
(defface rk-popup-selection '((t)) "Pop-up selection" :group 'rk-faces)
(defface rk-prompt'((t)) "Prompt" :group 'rk-faces)
(defface rk-search '((t)) "Search" :group 'rk-faces)
(defface rk-success '((t)) "Success" :group 'rk-faces)
(defface rk-tag-active '((t)) "Tag" :group 'rk-faces)
(defface rk-tag-inactive '((t)) "Tag" :group 'rk-faces)
(defface rk-text '((t)) "Text" :group 'rk-faces)
(defface rk-text2 '((t)) "Text 2" :group 'rk-faces)
(defface rk-warning '((t)) "Warning" :group 'rk-faces)

;;; Theme

(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark

   ;;;; Styles
   `(rk-callout ((t (:background ,callout-bg))))
   `(rk-change ((t (:foreground ,change))))
   `(rk-comment ((t (:foreground ,comment))))
   `(rk-diff-add ((t (:inherit rk-success))))
   `(rk-diff-change ((t (:inherit rk-change))))
   `(rk-diff-remove ((t (:inherit rk-error))))
   `(rk-error ((t (:foreground ,error))))
   `(rk-error ((t (:foreground ,error))))
   `(rk-header ((t (:foreground ,white :bold t))))
   `(rk-highlight-line ((t (:background ,highlight-line-bg))))
   `(rk-link ((t (:foreground ,link :underline t))))
   `(rk-match ((t (:background ,match-bg))))
   `(rk-modeline-active ((t (:foreground ,modeline-active-fg :background ,modeline-active-bg))))
   `(rk-modeline-inactive ((t (:foreground ,modeline-inactive-fg :background ,modeline-inactive-bg))))
   `(rk-popup ((t (:inherit rk-modeline-active))))
   `(rk-popup-match ((t (:foreground ,link))))
   `(rk-popup-selection ((t (:inherit rk-search))))
   `(rk-prompt ((t (:inherit rk-search :foreground ,white :bold t))))
   `(rk-search ((t (:background ,search-bg))))
   `(rk-success ((t (:foreground ,success))))
   `(rk-tag-active ((t (:inherit rk-modeline-active :bold t))))
   `(rk-tag-inactive ((t (:inherit rk-modeline-inactive :bold t))))
   `(rk-text ((t (:foreground ,white))))
   `(rk-text2 ((t (:foreground ,gray4))))
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
   `(region ((t (:inherit rk-match))))
   `(highlight ((t (:inherit rk-match))))
   `(header-line ((t (:inherit rk-header :underline t :background ,modeline-inactive-bg))))

   ;;;; Text
   `(link ((t (:inherit rk-link))))
   `(success ((t (:inherit rk-success))))
   
   ;;;; Mode Line
   `(mode-line-inactive ((t (:inherit rk-modeline-inactive))))
   `(mode-line ((t (:inherit rk-modeline-active))))

   ;;;; Search
   `(isearch ((t (:inherit rk-search))))
   `(isearch-fail ((t (:inherit rk-error))))
   `(lazy-highlight ((t (:inherit rk-match))))

   ;;;; Ido
   `(ido-first-match ((t (:inherit rk-search))))

   ;;;; Compilation (used for grep)
   `(compilation-line-number ((t (:inherit rk-comment))))
   `(compilation-info ((t (:inherit rk-success))))

   ;;;; git
   `(git-commit-summary ((t (:inherit rk-text))))

   ;;;; Flycheck
   `(flycheck-warning ((t (:inherit rk-warning))))
   `(flycheck-error ((t (:inherit rk-error))))

   ;;;; Flyspell
   `(flyspell-duplicate ((t (:inherit rk-warning))))
   `(flyspell-incorrect ((t (:inherit rk-error))))

   ;;;; diff
   `(diff-added ((t :inherit rk-diff-add)))
   `(diff-changed ((t :inherit rk-diff-change)))
   `(diff-removed ((t :inherit rk-diff-remove)))

   ;;;; dired
   `(dired-directory ((t (:inherit link :underline nil))))
   `(dired-header ((t (:inherit rk-prompt))))

   ;;;; ediff
   '(ediff-current-diff-A ((t (:inherit rk-highlight-line))))
   '(ediff-current-diff-B ((t (:inherit ediff-current-diff-A))))
   '(ediff-current-diff-C ((t (:inherit ediff-current-diff-A))))
   '(ediff-fine-diff-A ((t (:inherit rk-diff-change))))
   '(ediff-fine-diff-B ((t (:inherit ediff-fine-diff-A))))
   '(ediff-fine-diff-C ((t (:inherit ediff-fine-diff-A))))
   '(ediff-odd-diff-A ((t (:inherit rk-callout))))
   '(ediff-odd-diff-B ((t (:inherit ediff-odd-diff-A))))
   '(ediff-odd-diff-C ((t (:inherit ediff-odd-diff-A))))
   '(ediff-even-diff-A ((t (:inherit ediff-odd-diff-A))))
   '(ediff-even-diff-B ((t (:inherit ediff-odd-diff-A))))
   '(ediff-even-diff-C ((t (:inherit ediff-odd-diff-A))))

;;; Packages

   ;;;; Helm
   `(helm-selection ((t (:inherit rk-highlight-line))))
   `(helm-match ((t (:inherit rk-match))))
   `(helm-grep-lineno ((t (:inherit rk-comment))))
   `(helm-source-header ((t (:inherit rk-modeline-inactive))))
   `(helm-candidate-number ((t (:inherit rk-prompt))))
   `(helm-grep-finish ((t (:inherit rk-prompt))))

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
   `(magit-diff-hunk-header ((t (:inherit rk-header))))
   `(magit-diff-hunk-heading ((t (:inherit rk-header))))
   `(magit-diff-lines-heading ((t (:inherit rk-header :background ,callout-bg))))
   `(magit-hunk-heading ((t (:inherit rk-header))))
   `(magit-section-heading ((t (:inherit rk-header))))
   `(magit-section-title ((t (:inherit rk-header))))
   ;;;;; Highlight
   `(magit-diff-added-highlight ((t (:inherit magit-diff-added :background ,callout-bg))))
   `(magit-diff-context-highlight ((t (:inherit magit-diff-context :background ,callout-bg))))
   `(magit-diff-file-heading-highlight ((t (:inherit magit-diff-file-heading :background ,callout-bg))))
   `(magit-diff-hunk-heading-highlight ((t (:inherit magit-diff-hunk-heading :background ,callout-bg))))
   `(magit-diff-removed-highlight ((t (:inherit magit-diff-removed :background ,callout-bg))))
   `(magit-hunk-heading-highlight ((t (:inherit magit-hunk-heading :background ,callout-bg))))
   `(magit-item-highlight ((t (:inherit magit-item-highlight :background ,callout-bg))))
   `(magit-section-highlight ((t (:inherit rk-callout))))
   ;;;;; Region
   `(magit-diff-hunk-region ((t (:inherit region))))
   
   ;;;; markdown
   `(markdown-header-face-1 ((t (:inherit rk-header))))
   `(markdown-header-face-2 ((t (:inherit rk-header))))
   `(markdown-header-face-3 ((t (:inherit rk-header))))
   `(markdown-header-face-4 ((t (:inherit rk-header))))
   `(markdown-header-face-5 ((t (:inherit rk-header))))
   `(markdown-header-face-6 ((t (:inherit rk-header))))
   `(markdown-markup-face ((t (:inherit rk-comment))))
   `(markdown-link-face ((t (:inherit rk-link))))
   `(markdown-url-face ((t (:inherit rk-comment))))
   `(markdown-pre-face ((t (:inherit rk-text2))))
   `(markdown-inline-code-face ((t (:inherit markdown-pre-face))))
   
   ;;;; show-paren
   `(show-paren-match ((t (:inherit rk-modeline-active :bold t))))
   `(show-paren-mismatch ((t (:inherit rk-error))))

   ;;;; wgrep
   `(wgrep-delete-face ((t (:inherit rk-diff-remove))))
   `(wgrep-face ((t (:inherit rk-diff-change))))
   `(wgrep-done-face ((t (:inherit rk-success))))
   `(wgrep-reject-face ((t (:inherit rk-error))))

   ;;;; Company
   `(company-tooltip ((t (:inherit rk-popup))))
   `(company-tooltip-common ((t (:inherit rk-popup-match))))
   `(company-tooltip-selection ((t (:inherit rk-popup-selection))))
   `(company-scrollbar-bg ((t (:background ,modeline-inactive-bg))))
   `(company-scrollbar-fg ((t (:background ,modeline-inactive-fg))))
   `(company-preview ((t (:inherit rk-comment :background ,highlight-line-bg))))
   `(company-preview-common ((t (:inherit company-tooltip-common :background ,highlight-line-bg))))

   ;;;; Org
   `(org-todo ((t (:inherit rk-tag-active))))
   `(org-done ((t (:inherit rk-tag-inactive))))
   `(org-code ((t (:inherit rk-text2))))
   `(org-level-1 ((t (:inherit rk-text))))
   `(org-level-2 ((t (:inherit org-level-1))))
   `(org-level-3 ((t (:inherit org-level-1))))
   `(org-level-4 ((t (:inherit org-level-1))))
   `(org-level-5 ((t (:inherit org-level-1))))
   `(org-level-6 ((t (:inherit org-level-1))))
   `(org-level-7 ((t (:inherit org-level-1))))
   `(org-level-8 ((t (:inherit org-level-1))))
   
   
   ))

;;; Variables
(kleene-dark-with-color-variables
  (custom-theme-set-variables
   'kleene-dark
   `(ansi-color-names-vector [,black ,red ,green ,yellow ,blue ,magenta ,cyan ,white]))
  )

(provide-theme 'kleene-dark)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; kleene-dark-theme.el ends here
