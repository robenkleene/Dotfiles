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
    ("gray2" . "#444444")
    ("gray3" . "#585858")
    ("gray4" . "#808080")
    ("gray5" . "#b2b2b2")
    ("gray6" . "#eeeeee")

    ;; Named
    ("comment" . gray4)
    ("nontext" . gray3)
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
    ("match-active-bg" . gray3)
    ("match-inactive-bg" . gray2)
    ("match-fg" . gray4)
    ("warning" . yellow)

    ))

;;; Custom Faces
(defface rk-bold'((t)) "Header" :group 'rk-faces)
(defface rk-callout '((t)) "Callout block" :group 'rk-faces)
(defface rk-change '((t)) "Change" :group 'rk-faces)
(defface rk-change-highlight '((t)) "Change Highlight" :group 'rk-faces)
(defface rk-comment '((t)) "Comments" :group 'rk-faces)
(defface rk-nontext '((t)) "Non-Text" :group 'rk-faces)
(defface rk-string '((t)) "String" :group 'rk-faces)
(defface rk-diff-add '((t)) "Diff add" :group 'rk-faces)
(defface rk-diff-change'((t)) "Diff change" :group 'rk-faces)
(defface rk-diff-remove '((t)) "Diff remove" :group 'rk-faces)
(defface rk-error '((t)) "Errors" :group 'rk-faces)
(defface rk-error-highlight '((t)) "Error Highlight" :group 'rk-faces)
(defface rk-header '((t)) "Header" :group 'rk-faces)
(defface rk-highlight '((t)) "Highlight" :group 'rk-faces)
(defface rk-highlight-line '((t)) "Highlight line" :group 'rk-faces)
(defface rk-italic'((t)) "Header" :group 'rk-faces)
(defface rk-link '((t)) "Link" :group 'rk-faces)
(defface rk-match-active'((t)) "Match" :group 'rk-faces)
(defface rk-match-inactive'((t)) "Match" :group 'rk-faces)
(defface rk-modeline-active  '((t)) "Active mode-line" :group 'rk-faces)
(defface rk-modeline-inactive '((t)) "Inactive mode-line" :group 'rk-faces)
(defface rk-popup '((t)) "Pop-up" :group 'rk-faces)
(defface rk-popup-match '((t)) "Pop-up match" :group 'rk-faces)
(defface rk-popup-selection '((t)) "Pop-up selection" :group 'rk-faces)
(defface rk-prompt'((t)) "Prompt" :group 'rk-faces)
(defface rk-region'((t)) "Region" :group 'rk-faces)
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

  (set-face-attribute 'rk-bold nil :inherit 'rk-header)
  (set-face-attribute 'rk-callout nil :background callout-bg)
  (set-face-attribute 'rk-change nil :foreground change)
  (set-face-attribute 'rk-change-highlight nil :background change)
  (set-face-attribute 'rk-comment nil :foreground comment)
  (set-face-attribute 'rk-nontext nil :foreground nontext)
  (set-face-attribute 'rk-string nil :foreground string)
  (set-face-attribute 'rk-diff-add nil :inherit 'rk-success)
  (set-face-attribute 'rk-diff-change nil :inherit 'rk-change)
  (set-face-attribute 'rk-diff-remove nil :inherit 'rk-error :underline 'unspecified)
  (set-face-attribute 'rk-error nil :foreground error :underline t)
  (set-face-attribute 'rk-error-highlight nil :background error)
  (set-face-attribute 'rk-italic nil :inherit 'rk-text :slant 'oblique)
  (set-face-attribute 'rk-warning-highlight nil :background warning :foreground black :bold t)
  (set-face-attribute 'rk-header nil :foreground gray6 :bold t)
  (set-face-attribute 'rk-highlight-line nil :background highlight-line-bg)
  (set-face-attribute 'rk-highlight nil :background match-active-bg)
  (set-face-attribute 'rk-link nil :foreground link :underline t)
  (set-face-attribute 'rk-match-active nil :background match-active-bg)
  (set-face-attribute 'rk-match-inactive nil :background match-inactive-bg)
  (set-face-attribute 'rk-modeline-active nil :foreground modeline-active-fg :background modeline-active-bg)
  (set-face-attribute 'rk-modeline-inactive nil :foreground modeline-inactive-fg :background modeline-inactive-bg)
  (set-face-attribute 'rk-modeline-inactive nil :foreground modeline-active-fg :background modeline-inactive-bg)
  (set-face-attribute 'rk-popup-match nil :foreground link)
  (set-face-attribute 'rk-popup-selection nil :inherit 'rk-match-active)
  (set-face-attribute 'rk-prompt nil :inherit 'rk-match-active :bold t)
  (set-face-attribute 'rk-region nil :background modeline-inactive-bg)
  (set-face-attribute 'rk-search nil :background search-bg :foreground white)
  (set-face-attribute 'rk-success nil :foreground success)
  (set-face-attribute 'rk-tag-active nil :inherit 'rk-modeline-active :bold t)
  (set-face-attribute 'rk-tag-inactive nil :inherit 'rk-modeline-inactive :bold t)
  (set-face-attribute 'rk-text nil :foreground gray6)
  (set-face-attribute 'rk-text2 nil :foreground gray5)
  (set-face-attribute 'rk-warning nil :foreground warning :underline t)
  (set-face-attribute 'rk-whitespace nil :inherit 'rk-highlight-line)

  ;; Styles
  ;; Prefer to use the default text colors
  (set-face-attribute 'italic nil :underline 'unspecified :slant 'italic)
  (set-face-attribute 'bold nil :bold t)

  ;; Basic
  (set-face-attribute 'mode-line-inactive nil :foreground nontext)
  (set-face-attribute 'region nil :inherit 'rk-region :background 'unspecified :foreground 'unspecified)

  ;; Search
  (set-face-attribute 'isearch nil :inherit 'rk-match-active :background 'unspecified :foreground 'unspecified :bold t)
  (set-face-attribute 'lazy-highlight nil :inherit 'rk-match-inactive :background 'unspecified :foreground 'unspecified)
  (set-face-attribute 'isearch-fail nil :inherit 'rk-error :background 'unspecified :foreground 'unspecified :bold t)

  ;; Syntax
  (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground comment :slant 'oblique)
  (set-face-attribute 'font-lock-comment-face nil :foreground comment :slant 'oblique)

  ;; Fill Column
  (set-face-attribute 'fill-column-indicator nil :foreground callout-bg :background 'unspecified)

  ;; Packages

  ;; Whitespace
  (set-face-attribute 'trailing-whitespace nil :inherit 'rk-whitespace :background 'unspecified :underline 'unspecified)
  (set-face-attribute 'nobreak-space nil :inherit 'rk-whitespace :background 'unspecified :underline 'unspecified)

  ;; show-paren
  (set-face-attribute 'show-paren-match nil :underline t :background 'unspecified :foreground 'unspecified :bold nil)
  (set-face-attribute 'show-paren-mismatch nil :inherit 'rk-error)

  ;; Markdown
  (with-eval-after-load 'markdown-mode
    ;; (set-face-attribute 'markdown-header-face-1 nil :inherit 'rk-header :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-header-face-2 nil :inherit 'rk-header :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-header-face-3 nil :inherit 'rk-header :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-header-face-4 nil :inherit 'rk-header :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-header-face-5 nil :inherit 'rk-header :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-header-face-6 nil :inherit 'rk-header :foreground 'unspecified)
    (set-face-attribute 'markdown-markup-face nil :inherit 'rk-nontext :foreground 'unspecified)
    (set-face-attribute 'markdown-header-delimiter-face nil :inherit 'rk-nontext :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-link-face nil :inherit 'rk-link :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-url-face nil :inherit 'rk-comment :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-pre-face nil :inherit 'rk-comment :foreground 'unspecified :background 'unspecified)
    ;; (set-face-attribute 'markdown-code-face nil :inherit 'rk-comment :foreground 'unspecified :background 'unspecified)
    ;; (set-face-attribute 'markdown-inline-code-face nil :inherit 'markdown-pre-face :foreground 'unspecified :background 'unspecified)
    ;; (set-face-attribute 'markdown-blockquote-face nil :inherit 'rk-comment :foreground 'unspecified)
    (set-face-attribute 'markdown-gfm-checkbox-face nil :inherit 'rk-comment :foreground 'unspecified)
    (set-face-attribute 'markdown-list-face nil :inherit 'rk-comment :foreground 'unspecified)
    (set-face-attribute 'markdown-footnote-marker-face nil :inherit 'rk-nontext :slant 'normal :foreground 'unspecified)
    ;; (set-face-attribute 'markdown-italic-face nil :inherit 'rk-text :foreground 'unspecified :background 'unspecified)
    ;; (set-face-attribute 'markdown-bold-face nil :inherit 'rk-text :foreground 'unspecified :background 'unspecified :bold t)
    )

  ;; Org
  ;; (with-eval-after-load 'org
  ;;   (set-face-attribute 'org-code nil :inherit 'rk-comment :foreground 'unspecified)
  ;;   (set-face-attribute 'org-level-1 nil :inherit 'rk-header :foreground 'unspecified)
  ;;   (set-face-attribute 'org-level-2 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-3 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-4 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-5 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-6 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-7 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-level-8 nil :inherit 'org-level-1 :foreground 'unspecified :bold 'unspecified)
  ;;   (set-face-attribute 'org-special-keyword nil :inherit 'rk-comment :bold t :foreground 'unspecified)
  ;;   (set-face-attribute 'org-property-value nil :inherit 'rk-comment :foreground 'unspecified)
  ;;   ;; Agenda
  ;;   (set-face-attribute 'org-agenda-date nil :inherit 'rk-header :foreground 'unspecified)
  ;;   )

  ;; Git Commit
  ;; (with-eval-after-load 'magit
  ;; (set-face-attribute 'git-commit-summary nil :inherit 'rk-text :foreground 'unspecified :background 'unspecified)
  ;;   )

  ;; Dired
  ;; (with-eval-after-load 'dired
  ;;   (set-face-attribute 'dired-directory nil :inherit 'rk-link :underline nil)
  ;;   )
  )

(provide 'robenkleene-override-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-override-theme.el ends here
