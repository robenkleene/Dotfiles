;;; robenkleene-override-theme.el --- robenkleene-override-theme
;;; Commentary:
;;; Code:

(defmacro kleene-dark-with-color-variables (&rest body)
  "`let*' bind all colors defined in `kleene-dark-colors-alist' around BODY.  Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let* ((class '((class color) (min-colors 89)))
          ,@(mapcar (lambda (cons)
                      (list (intern (car cons)) (cdr cons)))
                    kleene-dark-colors-alist))
     ,@body))

(defvar kleene-dark-colors-alist
  '(
    ;; Ansi
    ("black" . "#000000")
    ("white" . "#ffffff")
    ("blue" . "#87AFDF")
    ("brightblue" . "#3792E3")
    ;; For some reason cyan doesn't work as a color name?
    ;; ("cyan" . "##00AFAF")
    ("brightcyan" . "#00FFFF")
    ("green" . "#75FF95")
    ("brightgreen" . "#BDDABD")
    ("magenta" . "#C978EB")
    ("brightmagenta" . "#DBA3EB")
    ("red" . "#9D571A")
    ("brightred" . "#DABDBD")
    ("yellow" . "#E5E64B")
    ("brightyellow" . "#DADABD")

    ;; Palette
    ("cyan1" . "#00AFAF")
    ("cyan2" . "#008787")
    ("cyan3" . "#62D8E9")
    ("purple" . "#5f0087")
    ("brightpurple" . "#822EB6")
    ("gray0" . "#303030")
    ("gray1" . "#3a3a3a")
    ("gray2" . "#4e4e4e")
    ("gray3" . "#6c6c6c")
    ("gray4" . "#808080")
    ("gray5" . "#b2b2b2")
    ("gray6" . "#eeeeee")

    ;; Named
    ("comment" . gray4)
    ("string" . green)
    ("success" . green)
    ("change" . brightblue)
    ("error" . red)
    ("highlight" . cyan3)
    ("highlight-line-bg" . gray1)
    ("callout-bg" . gray0)
    ("link" . blue)
    ("modeline-active-bg" . gray4)
    ("modeline-active-fg" . white)
    ("modeline-inactive-bg" . gray2)
    ("modeline-inactive-fg" . gray5)
    ("search-bg" . brightpurple)
    ("search-fg" . gray4)
    ("match-bg" . purple)
    ("match-fg" . gray4)
    ("warning" . yellow)

    ))

;;; Custom Faces
(defface rk-bold'((t)) "Header" :group 'rk-faces)
(defface rk-callout '((t)) "Callout block" :group 'rk-faces)
(defface rk-change '((t)) "Change" :group 'rk-faces)
(defface rk-change-highlight '((t)) "Change Highlight" :group 'rk-faces)
(defface rk-comment '((t)) "Comments" :group 'rk-faces)
(defface rk-string '((t)) "String" :group 'rk-faces)
(defface rk-diff-add '((t)) "Diff add" :group 'rk-faces)
(defface rk-diff-change'((t)) "Diff change" :group 'rk-faces)
(defface rk-diff-remove '((t)) "Diff remove" :group 'rk-faces)
(defface rk-error '((t)) "Errors" :group 'rk-faces)
(defface rk-error-highlight '((t)) "Error Highlight" :group 'rk-faces)
(defface rk-header'((t)) "Header" :group 'rk-faces)
(defface rk-highlight '((t)) "Highlight" :group 'rk-faces)
(defface rk-highlight-line '((t)) "Highlight line" :group 'rk-faces)
(defface rk-italic'((t)) "Header" :group 'rk-faces)
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
(defface rk-warning-highlight '((t)) "Warning Highlight" :group 'rk-faces)
(defface rk-whitespace '((t)) "Whitespace" :group 'rk-faces)

(kleene-dark-with-color-variables
  (custom-set-faces
    ;;;; Styles
   `(rk-bold ((t (:inherit rk-header))))
   `(rk-callout ((t (:background ,callout-bg))))
   `(rk-change ((t (:foreground ,change))))
   `(rk-change-highlight ((t (:background ,change))))
   `(rk-comment ((t (:foreground ,comment))))
   `(rk-string ((t (:foreground ,string))))
   `(rk-diff-add ((t (:inherit rk-success))))
   `(rk-diff-change ((t (:inherit rk-change))))
   `(rk-diff-remove ((t (:inherit rk-error :underline nil))))
   `(rk-error ((t (:foreground ,error :underline t))))
   `(rk-error-highlight ((t (:background ,error))))
   `(rk-italic ((t (:inherit rk-text :slant oblique))))
   `(rk-warning-highlight
     ((t (:background ,warning :foreground ,black :bold t))))
   `(rk-header ((t (:foreground ,gray6 :bold t))))
   `(rk-highlight-line ((t (:background ,highlight-line-bg))))
   `(rk-highlight ((t (:background ,match-bg))))
   `(rk-link ((t (:foreground ,link :underline t))))
   `(rk-match ((t (:background ,match-bg))))
   `(rk-modeline-active
     ((t
       (:foreground ,modeline-active-fg :background ,modeline-active-bg))))
   `(rk-modeline-inactive
     ((t
       (:foreground ,modeline-inactive-fg :background ,modeline-inactive-bg))))
   `(rk-none ((t (:foreground nil :background nil :bold nil :underline nil))))
   `(rk-modeline-inactive
     ((t
       (:foreground ,modeline-active-fg :background ,modeline-inactive-bg))))
   `(rk-popup-match ((t (:foreground ,link))))
   `(rk-popup-selection ((t (:inherit rk-match))))
   `(rk-prompt ((t (:inherit rk-match :bold t))))
   `(rk-search ((t (:background ,search-bg :foreground ,white))))
   `(rk-success ((t (:foreground ,success))))
   `(rk-tag-active ((t (:inherit rk-modeline-active :bold t))))
   `(rk-tag-inactive ((t (:inherit rk-modeline-inactive :bold t))))
   `(rk-text ((t (:foreground ,gray6))))
   `(rk-text2 ((t (:foreground ,gray5))))
   `(rk-warning ((t (:foreground ,warning :underline t))))
   ;; `(rk-whitespace ((t (:inherit rk-warning))))
   `(rk-whitespace ((t (:inherit rk-highlight-line))))

   ;; Styles
   ;; This doesn't work for some reason?
   ;; `(region ((t (:inherit rk-match))))
   `(region ((t (:background "#45475A"))))

   ;; Packages

   ;; Helm
   `(helm-selection ((t (:inherit rk-highlight-line))))
   `(helm-selection-line ((t (:inherit rk-highlight-line))))
   `(helm-match ((t (:inherit rk-match))))
   `(helm-match-item ((t (:inherit rk-match))))
   `(helm-grep-lineno ((t (:inherit rk-comment))))
   `(helm-source-header ((t (:inherit rk-modeline-inactive))))
   `(helm-candidate-number ((t (:inherit rk-prompt))))
   `(helm-grep-finish ((t (:inherit rk-prompt))))
   `(helm-grep-file ((t (:inherit link :underline nil))))

   ;; Whitespace
   `(whitespace-space-after-tab ((t (:inherit rk-whitespace))))
   `(whitespace-space-before-tab ((t (:inherit rk-whitespace))))
   `(whitespace-tab ((t (:inherit rk-whitespace))))
   `(trailing-whitespace ((t (:inherit rk-whitespace))))
   `(whitespace-line ((t (:inherit rk-warning))))

   ;;;; show-paren
   `(show-paren-match ((t (:underline t :background nil :foreground nil :bold nil))))
   `(show-paren-mismatch ((t (:inherit rk-error))))

   ;; Markdown
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
   `(markdown-blockquote-face ((t (:inherit rk-text2))))
   `(markdown-gfm-checkbox-face ((t (:inherit rk-text2))))
   `(markdown-list-face ((t (:inherit rk-text2))))
   `(markdown-footnote-marker-face ((t (:inherit rk-comment :slant normal))))
   ;; `(markdown-italic-face ((t (:inherit rk-text2))))
   
   )
  )

(provide 'robenkleene-override-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-override-theme.el ends here
