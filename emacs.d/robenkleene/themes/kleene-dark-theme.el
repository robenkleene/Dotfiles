;;; kleene-dark-theme.el --- Kleene Dark

;;; Commentary:
;;; Code:

(deftheme kleene-dark "Kleene Dark")

;;; Colors
(defvar kleene-dark-colors-alist
  '(
      ;;; Basic
    ("transparent-background" . "unspecified-bg")
    ("solid-background" . "#444444")

    ;; Diff
    ("diff-added-foreground" . "brightgreen")
    ("diff-removed-foreground" . "brightred")
    ("diff-changed-foreground" . "brightcyan")

    ;; Text Colors
    ("light-text-foreground" . "#b2b2b2")
    ("dark-text-foreground" . solid-background)
    ("inactive-text" . solid-background)
    ("metadata-text" . "#ff8700")
    ("completion-text" . diff-added-foreground)
    ("comment-text" . solid-background)

    ;; Errors & Warnings
    ("error-background" . diff-removed-foreground)
    ("error-text-foreground" . solid-background)
    ("error-text" . diff-removed-foreground)

    ;; Highlight
    ("highlight-background" . "#005f87")
    ("highlight-foreground" . "brightwhite")

    ;; Prompt
    ("prompt-background" . "#87d787")
    ("prompt-foreground" . solid-background)

    ;; Link Text
    ("link-text" . "#5EAFD7")

    ;; Modeline & Windows
    ("modeline-active-background" . "#afd7ff")
    ("modeline-active-foreground" . dark-text-foreground)
    ("modeline-inactive-background" . solid-background)
    ("modeline-inactive-foreground" . light-text-foreground)

    ;; Selection or Region
    ("region-background" . "#585858")
    ("region-foreground" . light-text-foreground)

    ;; Search
    ("search-background" . region-background)
    ("search-foreground" . highlight-foreground)
    ("search-replacement" . diff-added-foreground)

    ;; File lists
    ("directory-text" . link-text)
    ("file-text" . light-text-foreground)
    ("line-number" . metadata-text)
    ))

;;; Macro
(defmacro kleene-dark-with-color-variables (&rest body)
  "`let*' bind all colors defined in `kleene-dark-colors-alist' around BODY.  Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let* ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   kleene-dark-colors-alist))
     ,@body))

;;; Faces
(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark
   ;; General
   `(default ((t (:foreground ,light-text-foreground :background ,transparent-background))))
   `(fringe ((t (:foreground ,light-text-foreground :background ,transparent-background))))
   `(linum ((t (:foreground ,light-text-foreground :background ,solid-background))))
   `(cursor ((t (:foreground ,highlight-foreground :background ,highlight-background))))

   ;; Diff: Magit and Git Gutter inheret
   `(diff-added ((t (:foreground ,diff-added-foreground :background nil :bold nil))))
   `(diff-changed ((t (:foreground ,diff-changed-foreground :background nil :bold nil))))
   `(diff-removed ((t (:foreground ,diff-removed-foreground :background nil :bold nil))))
   ;; Git Gutter
   `(git-gutter:modified ((t (:foreground ,diff-changed-foreground :background nil :bold nil))))

   ;; Highlight
   `(hl-line ((t (:foreground ,highlight-foreground :background ,highlight-background))))
   `(highlight ((t (:inherit region))))

   ;; Region
   `(region ((t (:foreground ,region-foreground :background ,region-background))))


   ;; Paren Match
   `(show-paren-match ((t (:underline t :foreground ,region-foreground :background ,region-background))))
   ;; Does `rainbow-delimiter-mismatched-face' and `rainbow-delimiters-unmatched-face' interfere with this?
   `(show-paren-mismatch ((t (:foreground ,error-text))))

   ;; Search
   `(isearch ((t (:foreground ,search-foreground :background ,search-background))))
   `(isearch-fail ((t (:foreground ,error-text :background nil))))
   ;; Matches other then the current one
   `(lazy-highlight ((t (:foreground ,search-foreground :background ,search-background))))
   ;; Evil
   `(evil-ex-substitute-replacement ((t (:foreground ,search-replacement :background ,search-background :underline nil))))

   ;; Mode line & Windows
   `(mode-line ((t (:box nil :background ,modeline-active-background :foreground ,modeline-active-foreground))))
   `(mode-line-inactive ((t (:box nil :background ,modeline-inactive-background :foreground ,modeline-inactive-foreground))))
   `(vertical-border ((t (:foreground ,solid-background :background ,solid-background))))

   ;; Syntax Highlighting
   `(font-lock-builtin-face ((t (:foreground, "#FFFFB6"))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comment-text))))
   `(font-lock-comment-face ((t (:foreground ,comment-text))))
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

   ;; Rainbow Delimiters
   `(rainbow-delimiters-mismatched-face ((t (:inherit show-paren-mismatch))))
   `(rainbow-delimiters-unmatched-face ((t (:inherit show-paren-mismatch))))

   `(rainbow-delimiters-depth-1-face ((t (:bold nil :foreground "#808080"))))
   ;; `(rainbow-delimiters-depth-1-face ((t (:bold nil :foreground "#AFD7D7"))))
   `(rainbow-delimiters-depth-2-face ((t (:bold nil :foreground "#01A6B2"))))
   `(rainbow-delimiters-depth-3-face ((t (:bold nil :foreground "#B0FFD7"))))
   `(rainbow-delimiters-depth-4-face ((t (:bold nil :foreground "#D7AFFF"))))
   `(rainbow-delimiters-depth-5-face ((t (:bold nil :foreground "#00D900"))))
   `(rainbow-delimiters-depth-6-face ((t (:bold nil :foreground "#D0D0D0"))))
   `(rainbow-delimiters-depth-7-face ((t (:bold nil :foreground "#999900"))))
   `(rainbow-delimiters-depth-8-face ((t (:bold nil :foreground "#AFD7FF"))))
   `(rainbow-delimiters-depth-9-face ((t (:bold nil :foreground "#01A6B2"))))


   ;; Smartparens
   `(sp-show-pair-match-face ((t (:inherit show-paren-match))))
   `(sp-show-pair-mismatch-face ((t (:inherit show-paren-mismatch))))
   
   ;;; Magit
   ;; Normal
   `(magit-branch-current ((t (:foreground ,highlight-foreground :background nil :bold t))))
   `(magit-branch-local ((t (:inherit magit-branch-current))))
   `(magit-branch-remote ((t (:inherit magit-branch-current))))
   `(magit-section-heading ((t (:foreground ,highlight-foreground :background nil :underline t :bold t))))
   `(magit-diff-file-heading ((t (:foreground ,file-text :background nil :underline nil ))))
   `(magit-diff-hunk-heading ((t (:foreground ,highlight-foreground :background nil))))
   `(magit-diff-added ((t (:inherit diff-added))))
   `(magit-diff-removed ((t (:inherit diff-removed))))
   `(magit-diff-context ((t (:foreground ,inactive-text))))
   `(magit-diff-lines-heading ((t (:inherit region))))

   ;; Selection
   ;; Not sure what this is yet
   ;; `(magit-diff-file-heading-selection ((t (:inherit magit-diff-file-heading))))
   ;; `(magit-section-heading-selection ((t (:inherit magit-section-heading))))
   ;; `(magit-diff-hunk-heading-selection ((t (:inherit magit-diff-hunk-heading))))
   ;; `(magit-diff-file-heading-selection ((t (:inherit magit-diff-file-heading))))
   `(magit-diff-file-heading-selection ((t (:background "brightmagenta"))))
   `(magit-section-heading-selection ((t (:background "brightmagenta"))))
   `(magit-diff-hunk-heading-selection ((t (:background "brightmagenta"))))
   `(magit-diff-file-heading-selection ((t (:background "brightmagenta"))))

   ;; Highlight
   ;; This is the currently active section
   `(magit-section-highlight ((t (:background nil :foreground nil))))
   `(magit-diff-file-heading-highlight ((t (:inherit magit-diff-file-heading))))
   `(magit-diff-hunk-heading-highlight ((t (:inherit magit-diff-hunk-heading))))
   `(magit-diff-added-highlight ((t (:inherit diff-added))))
   `(magit-diff-removed-highlight ((t (:inherit diff-removed))))
   `(magit-diff-context-highlight ((t (:inherit magit-diff-context))))


   ;; Helm
   `(helm-match ((t (:foreground nil :background nil :bold nil :inherit isearch))))
   `(helm-buffer-file ((t (:foreground ,file-text))))
   `(helm-buffer-directory ((t (:foreground ,directory-text :bold t))))
   `(helm-buffer-process ((t (:foreground ,file-text))))
   `(helm-ff-directory ((t (:foreground ,directory-text :bold t))))
   `(helm-ff-dotted-directory ((t (:foreground ,directory-text :bold t))))
   `(helm-ff-file ((t (:foreground ,file-text))))
   `(helm-moccur-buffer ((t (:underline t :foreground ,link-text))))
   `(helm-source-header ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(helm-header-line-left-margin ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(helm-header ((t (:foreground ,modeline-active-foreground :background ,modeline-active-background))))
   `(helm-visible-mark ((t (:inherit region))))
   ;; Uncustomized
   ;; `(helm-bookmark-directory ((t (:foreground ,link-text :background "#303030" :bold t))))
   `(helm-bookmark-file ((t (:foreground "#875f00" :background "#ffff87"))))
   `(helm-bookmark-info ((t (:foreground ,prompt-foreground :background ,prompt-background))))
   `(helm-buffer-saved-out ((t (:foreground "#dd0000" :background "#303030"))))
   `(helm-buffer-size ((t (:foreground ,metadata-text))))
   `(helm-candidate-number ((t (:foreground ,highlight-background :background "#ffffff"))))
   ;; `(helm-ff-directory ((t (:foreground ,link-text :background "#303030" :bold t))))
   `(helm-ff-excutable ((t (:foreground ,prompt-background :background "#303030" :bold t))))
   `(helm-ff-invalid-symlink ((t (:foreground "#c6c6c6" :background "#dd0000"))))
   `(helm-ff-prefix ((t (:foreground "#c6c6c6" :background "#ff8700"))))
   `(helm-grep-cmd-line ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(helm-grep-file ((t (:foreground "#d18aff"))))
   `(helm-grep-finish ((t (:foreground ,prompt-background))))
   `(helm-grep-lineno ((t (:foreground ,metadata-text))))
   `(helm-grep-match ((t (:background "#3a3a3a" :foreground "#fce94f" :bold t))))
   `(helm-grep-running ((t (:foreground "#ff4b4b" :background nil))))
   `(helm-lisp-show-completion ((t (:foreground "#4e4e4e" :background ,prompt-background))))
   ;; `(helm-match ((t (:foreground ,prompt-background :background "#303030" :bold t))))
   `(helm-selection ((t (:foreground nil :background ,highlight-background))))
   `(helm-selection-line ((t (:foreground nil :background "#875f00"))))

   

   
   ;;; Uncustomized

   ;; Flycheck
   `(flycheck-error ((t (:foreground ,error-text :bold t))))
   `(flycheck-warnline ((t (:background "#ff8700" :foreground "#ffffff" :bold t))))

   ;; Highlighting faces
   ;; `(linum-highlight-face ((t (:background ,prompt-background :foreground "#3a3a3a"))))
   ;; `(hl-line ((t (:background "#4e4e4e"))))
   ;; `(highlight-symbol-face ((t (:background "#4e4e4e"))))
   `(secondary-selection ((t (:background ,highlight-background :foreground "#ffffff"))))
   `(lazy-highlight ((t (:background "#ff1f8b" :foreground "#c6c6c6"))))
   `(trailing-whitespace ((t (:background "#a40000"))))
   `(header-line ((t (:background ,highlight-background :foreground "#ffffff"))))
   `(help-argument-name ((t (:foreground "#ff7bbb" :italic t))))


   ;; Escape and prompt faces
   `(minibuffer-prompt ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(escape-glyph ((t (:foreground "#c4a000"))))
   `(error ((t (:foreground ,error-text))))
   `(warning ((t (:foreground "#ffaf5f"))))
   `(success ((t (:foreground ,prompt-background))))


   ;; org-mode
   `(org-document-title ((t (:foreground "#afd7ff" :background "#303030" :weight bold))))
   `(org-document-info ((t (:foreground ,link-text :background "#303030" :weight bold))))
   `(org-document-info-keyword ((t (:foreground "#ffaf5f" :background "#6c6c6c"))))
   `(org-archived ((t (:slant italic))))
   `(org-checkbox ((t (:background "#c6c6c6" :foreground "#4e4e4e"
                                        :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground "#afd7ff" :underline t))))
   `(org-done ((t (:bold t :weight bold :foreground ,prompt-foreground :background ,prompt-background
                              :box (:line-width 1 :style none)))))
   `(org-todo ((t (:bold t :weight bold :foreground "#a40000" :background "#ffaf87"
                              :box (:line-width 1 :style none)))))
   `(org-level-1 ((t (:foreground ,link-text))))
   `(org-level-2 ((t (:foreground ,prompt-background))))
   `(org-level-3 ((t (:foreground "#ff8700"))))
   `(org-level-4 ((t (:foreground "#00d7af"))))
   `(org-level-5 ((t (:foreground "#ef2929"))))
   `(org-level-6 ((t (:foreground "#af5fff"))))
   `(org-level-7 ((t (:foreground "#ff4ea3"))))
   `(org-level-8 ((t (:foreground "#ffd700"))))
   `(org-tag ((t (:background "#4e4e4e" :foreground "#c6c6c6" :bold t :weight bold))))

   `(org-column ((t (:background "#3a3a3a" :foreground "#4e4e4e"))))
   `(org-column-title ((t (:background "#afd7ff" :foreground "#303030" :underline t :weight bold))))
   `(org-agenda-structure ((t (:foreground "#00ac8a" :background nil :bold t))))
   `(org-deadline-announce ((t (:foreground "#a40000"))))
   `(org-scheduled ((t (:foreground "#b2b2b2"))))
   `(org-scheduled-previously ((t (:foreground "#ef2929"))))
   `(org-scheduled-today ((t (:foreground ,link-text))))
   `(org-special-keyword ((t (:background "#4e4e4e" :foreground "#c6c6c6"))))
   `(org-table ((t (:background "#4e4e4e" :foreground "#c6c6c6"))))
   `(org-time-grid ((t (:foreground "#8a8a8a"))))
   `(org-upcoming-deadline ((t (:foreground "#ef2929"))))
   `(org-warning ((t (:bold t :foreground "#ffffff" :background "#a40000"))))
   `(org-formula ((t (:foreground "#af5fff"))))
   `(org-headline-done ((t (:foreground ,prompt-background))))
   `(org-hide ((t (:foreground "#303030"))))
   `(org-code ((t (:foreground ,link-text :background "#3a3a3a"))))
   `(org-link ((t (:foreground ,link-text :underline t))))
   `(org-footnote ((t (:foreground "#ff1f8b"))))
   `(org-ellipsis ((t (:foreground "#dd0000"))))
   `(org-agenda-clocking ((t (:foreground ,highlight-background :background "#afd7ff" :bold t))))
   `(org-agenda-date ((t (:foreground ,link-text :background "#303030" :underline nil))))
   `(org-agenda-date-weekend ((t (:foreground "#d18aff" :underline nil :bold nil))))
   `(org-agenda-date-today ((t (:foreground "#afd7ff" :background "#6c6c6c" :slant italic :weight bold))))
   `(org-agenda-column-dateline ((t (:foreground "#ffffff" :background "#4e4e4e" :underline t))))
   `(org-agenda-todo ((t (:foreground "#ffffff" :background "#dd0000"))))
   `(org-agenda-done ((t (:foreground ,prompt-background :background nil))))
   `(org-agenda-dimmed-todo-face ((t (:foreground "#ffffff" :background "#dd0000"))))
   `(org-priority ((t (:foreground "#ef2929" :background ,nil))))
   `(org-block ((t (:foreground ,link-text :background "#3a3a3a"))))
   `(org-block-background ((t (:foreground nil :background "#3a3a3a"))))
   `(org-block-begin-line ((t (:foreground "#ffffff" :background ,highlight-background))))
   `(org-block-end-line ((t (:foreground "#4e4e4e" :background "#3a3a3a"))))
   `(org-quote ((t (:foreground ,link-text :background "#4e4e4e"))))
   `(org-mode-line-clock ((t (:foreground ,highlight-background :background "#afd7ff" :bold t))))
   `(org-mode-line-clock-overrun ((t (:foreground "#ffffff" :background "#ef2929" :bold t))))
   `(org-verbatim ((t (:foreground ,link-text :background "#4e4e4e" :bold nil))))

   ;; outline
   `(outline-1 ((t (:foreground ,link-text))))
   `(outline-2 ((t (:foreground ,prompt-background))))
   `(outline-3 ((t (:foreground "#ff8700"))))
   `(outline-4 ((t (:foreground "#00d7af"))))
   `(outline-5 ((t (:foreground "#ef2929"))))
   `(outline-6 ((t (:foreground "#af5fff"))))
   `(outline-7 ((t (:foreground "#ff4ea3"))))
   `(outline-8 ((t (:foreground "#ffd700"))))

   ;; undo-tree
   `(undo-tree-visualizer-default-face ((t (:foreground "#c6c6c6"))))
   `(undo-tree-visualizer-current-face ((t (:foreground ,prompt-background :weight bold))))
   `(undo-tree-visualizer-active-branch-face ((t (:foreground "#dd0000"))))
   `(undo-tree-visualizer-register-face ((t (:foreground "#ffd700"))))

   ;; Markdown-mode
   `(markdown-blockquote-face ((t (:foreground "#ff8700" :background "#4e4e4e" :italic t))))
   `(markdown-bold-face ((t (:foreground "#c6c6c6" :bold t))))
   `(markdown-comment-face ((t (:foreground "#8a8a8a" :italic t))))
   `(markdown-header-delimiter-face ((t (:foreground "#5faf00" :bold t))))
   `(markdown-header-face ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-rule-face ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-1 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-2 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-3 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-4 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-5 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-header-face-6 ((t (:foreground ,prompt-background :bold t))))
   `(markdown-link-face ((t (:foreground "#ff7bbb" :underline t))))
   `(markdown-inline-code-face ((t (:foreground ,link-text :background "#4e4e4e"))))
   `(markdown-italic-face ((t (:foreground "#c6c6c6" :italic t :underline "#c6c6c6"))))
   `(markdown-list-face ((t (:foreground ,prompt-background :background "#303030" :bold t))))
   `(markdown-math-face ((t (:foreground "#ff7bbb"))))
   `(markdown-missing-link-face ((t (:foreground "#ef2929" :bold t))))
   `(markdown-pre-face ((t (:foreground ,link-text))))
   `(markdown-reference-face ((t (:foreground "#ff8700" :italic t))))
   `(markdown-url-face ((t (:foreground "#ff1f8b" :underline "#ff1f8b"))))

   ;; Twittering-mode
   `(twittering-username-face ((t (:foreground ,link-text :background "#3a3a3a" :bold t :underline t))))
   `(twittering-uri-face ((t (:foreground ,link-text :underline t))))
   `(twittering-timeline-footer-face ((t (:foreground "#b2b2b2"))))
   `(twittering-timeline-header-face ((t (:foreground "#b2b2b2"))))

   ;; Jabber
   `(jabber-activity-face ((t (:foreground "#ff4ea3"))))
   `(jabber-activity-personal-face ((t (:foreground "#00d7af"))))
   `(jabber-chat-error ((t (:foreground "#ffafaf" :background "#dd0000"))))
   `(jabber-chat-prompt-foreign ((t (:foreground "#ff8700"))))
   `(jabber-chat-prompt-local ((t (:foreground ,link-text))))
   `(jabber-chat-prompt-system ((t (:foreground "#ffd700" :weight bold))))
   `(jabber-chat-text-foreign ((t (:foreground "#ffffff"))))
   `(jabber-chat-text-local ((t (:foreground "#b2b2b2"))))
   `(jabber-rare-time-face ((t (:foreground "#a8a8a8"))))
   `(jabber-roster-user-away ((t (:foreground "#ff8700"))))
   `(jabber-roster-user-chatty ((t (:foreground "#d18aff"))))
   `(jabber-roster-user-dnd ((t (:foreground "#ef2929"))))
   `(jabber-roster-user-error ((t (:foreground "#ffafaf" :background "#a40000"))))
   `(jabber-roster-user-offline ((t (:foreground "#a8a8a8"))))
   `(jabber-roster-user-online ((t (:foreground ,prompt-background))))
   `(jabber-roster-user-xa ((t (:foreground "#a8a8a8"))))

   ;; popup
   `(popup-face ((t (:background "#4e4e4e" :foreground ,link-text))))
   `(popup-isearch-match ((t (:background "#4e4e4e" :foreground "#ff4ea3" :bold t))))
   `(popup-menu-face ((t (:background "#4e4e4e" :foreground ,link-text))))
   `(popup-menu-mouse-face ((t (:background ,prompt-background :foreground "#3a3a3a"))))
   `(popup-menu-selection-face ((t (:background ,highlight-background :foreground "#afd7ff"))))
   `(popup-menu-summary-face ((t (:background "#4e4e4e" :foreground ,link-text))))
   `(popup-scroll-bar-background-face ((t (:background "#4e4e4e" :foreground "#4e4e4e"))))
   `(popup-scroll-bar-foreground-face ((t (:background "#8a8a8a" :foreground "#b2b2b2"))))
   `(popup-summary-face ((t (:background "#4e4e4e" :foreground ,link-text))))
   `(popup-tip-face ((t (:background "#6c6c6c" :foreground "#c6c6c6"))))

   ;; company
   `(company-scrollbar-bg ((t (:background ,solid-background))))
   `(company-scrollbar-fg ((t (:background ,light-text-foreground))))
   `(company-tooltip ((t (:background ,solid-background :foreground ,light-text-foreground))))
   `(company-tooltip-annotation ((t (:background ,solid-background :foreground ,metadata-text))))
   `(company-tooltip-common ((t (:background ,solid-background :foreground ,highlight-foreground :bold t))))
   `(company-tooltip-common-selection ((t (:background ,highlight-background :inherit company-tooltip-common))))
   `(company-tooltip-selection ((t (:background ,highlight-background :foreground ,highlight-foreground))))
   ;; Uncustomized
   `(company-echo ((t (:background nil :foreground "#c6c6c6"))))
   `(company-echo-common ((t (:foreground ,completion-text))))
   `(company-preview ((t (:foreground ,completion-text))))
   `(company-preview-common ((t (:foreground ,completion-text))))
   `(company-preview-search ((t (:background "#3a3a3a" :foreground "#ff4ea3" :bold t))))
   `(company-template-field ((t (:background "#ffffaf" :foreground "#3a3a3a"))))
   `(company-tooltip-mouse ((t (:background ,prompt-background :foreground "#303030"))))

   ;; Button and link faces
   `(link ((t (:underline t :foreground ,link-text))))
   `(link-visited ((t (:underline t :foreground "#1f5bff"))))

   ;; Gnus
   `(gnus-button ((t (:weight normal :foreground ,link-text :underline t))))
   `(gnus-cite-1 ((t (:foreground ,link-text :background "#3a3a3a" :slant italic))))
   `(gnus-cite-10 ((t (:foreground "#ff7bbb" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-11 ((t (:foreground "#00d7af" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-2 ((t (:foreground ,prompt-background :background "#3a3a3a" :slant italic))))
   `(gnus-cite-3 ((t (:foreground "#ff4ea3" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-4 ((t (:foreground "#00d7af" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-5 ((t (:foreground "#ff4b4b" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-6 ((t (:foreground "#d18aff" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-7 ((t (:foreground "#ff8700" :background "#3a3a3a" :slant italic))))
   `(gnus-cite-8 ((t (:foreground ,link-text :background "#3a3a3a" :slant italic))))
   `(gnus-cite-9 ((t (:foreground ,prompt-background :background "#3a3a3a" :slant italic))))
   `(gnus-emphasis-highlight-words ((t (:foreground "#a40000" :background "#ffafaf" :bold t))))
   `(gnus-group-mail-1 ((t (:foreground ,link-text))))
   `(gnus-group-mail-1-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-mail-1-low ((t (:foreground "#1f5bff"))))
   `(gnus-group-mail-2 ((t (:foreground "#ff8700"))))
   `(gnus-group-mail-2-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-mail-2-low ((t (:foreground "#ff5d17"))))
   `(gnus-group-mail-3 ((t (:foreground "#ff4ea3"))))
   `(gnus-group-mail-3-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-mail-3-low ((t (:foreground "#ff1f8b"))))
   `(gnus-group-mail-low ((t (:foreground "#c4a000"))))
   `(gnus-group-mail-low-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-1 ((t (:foreground ,link-text))))
   `(gnus-group-news-1-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-1-low ((t (:foreground "#1f5bff"))))
   `(gnus-group-news-2 ((t (:foreground "#ff8700"))))
   `(gnus-group-news-2-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-2-low ((t (:foreground "#ff5d17"))))
   `(gnus-group-news-3 ((t (:foreground "#ff4ea3"))))
   `(gnus-group-news-3-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-3-low ((t (:foreground "#ff1f8b"))))
   `(gnus-group-news-4 ((t (:foreground "#af5fff"))))
   `(gnus-group-news-4-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-4-low ((t (:foreground "#9a08ff"))))
   `(gnus-group-news-5 ((t (:foreground "#00d7af"))))
   `(gnus-group-news-5-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-5-low ((t (:foreground "#00ac8a"))))
   `(gnus-group-news-6 ((t (:foreground ,prompt-background))))
   `(gnus-group-news-6-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-group-news-6-low ((t (:foreground "#5faf00"))))
   `(gnus-group-news-low ((t (:foreground "#c4a000"))))
   `(gnus-group-news-low-empty ((t (:foreground "#8a8a8a"))))
   `(gnus-header-content ((t (:foreground "#ff7bbb" ))))
   `(gnus-header-from ((t (:foreground ,link-text :underline t))))
   `(gnus-header-name ((t (:foreground "#a8a8a8"))))
   `(gnus-header-newsgroups ((t (:foreground "#ff4ea3"))))
   `(gnus-header-subject ((t (:foreground "#ffffff" :bold t))))
   `(gnus-server-agent ((t (:foreground "#8a8a8a"))))
   `(gnus-server-closed ((t (:foreground "#8a8a8a"))))
   `(gnus-server-denied ((t (:foreground "#8a8a8a"))))
   `(gnus-server-offline ((t (:foreground "#8a8a8a"))))
   `(gnus-server-opened ((t (:foreground "#8a8a8a"))))
   `(gnus-signature ((t (:slant italic :foreground "#8a8a8a"))))
   `(gnus-splash ((t (:foreground "#a8a8a8"))))
   `(gnus-summary-cancelled ((t (:foreground "#8a8a8a" :background "#303030"))))
   `(gnus-summary-high-ancient ((t (:bold t :foreground "#a40000" :background nil))))
   `(gnus-summary-high-read ((t (:bold t :foreground "#c6c6c6"))))
   `(gnus-summary-high-ticked ((t (:slant italic :bold t :foreground "#dd0000" :background nil))))
   `(gnus-summary-high-undownloaded ((t (:slant italic :foreground "#dd0000" :background nil))))
   `(gnus-summary-high-unread ((t (:bold t :foreground "#ff4b4b"))))
   `(gnus-summary-low-ancient ((t (:foreground "#5faf00"))))
   `(gnus-summary-low-read ((t (:foreground "#c6c6c6"))))
   `(gnus-summary-low-ticked ((t (:slant italic :foreground ,prompt-background))))
   `(gnus-summary-low-undownloaded ((t (:slant italic :foreground ,prompt-background))))
   `(gnus-summary-low-unread ((t (:slant italic :foreground ,prompt-background))))
   `(gnus-summary-normal-ancient ((t (:foreground "#1f5bff"))))
   `(gnus-summary-normal-read ((t (:foreground "#c6c6c6"))))
   `(gnus-summary-normal-ticked ((t (:slant italic :foreground ,link-text))))
   `(gnus-summary-normal-undownloaded ((t (:slant italic :foreground ,link-text))))
   `(gnus-summary-normal-unread ((t (:foreground "#afd7ff" :bold t))))
   `(gnus-summary-selected ((t (:background ,prompt-background :foreground "#005f00"))))

   ;; Dired/Dired+
   `(dired-directory ((t (:foreground ,directory-text :bold t))))
   `(diredp-file-name ((t (:foreground ,file-text))))
   ;; Uncustomized
   `(dired-flagged ((t (:foreground "#ef2929"))))
   `(dired-header ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(dired-ignored ((t (:foreground "#a8a8a8"))))
   `(dired-mark ((t (:foreground ,prompt-background))))
   `(dired-marked ((t (:foreground ,prompt-background))))
   `(dired-perm-write ((t (:foreground "#dd0000" :bold t))))
   `(dired-symlink ((t (:foreground "#ff4ea3"))))
   `(dired-warning ((t (:foreground "#c6c6c6" :background "#a40000" :bold t))))
   `(diredp-compressed-file-suffix ((t (:foreground "#af5fff"))))
   `(diredp-date-time ((t (:foreground ,link-text :background "#3a3a3a"))))
   `(diredp-deletion ((t (:foreground "#c6c6c6", :background "#a40000"))))
   `(diredp-deletion-file-name ((t (:foreground "#dd0000"))))
   `(diredp-dir-heading ((t (:foreground "#303030" :background ,prompt-background))))
   `(diredp-dir-priv ((t (:foreground ,link-text :background "#303030" :bold t))))
   `(diredp-display-msg ((t (:foreground "#ff8700"))))
   `(diredp-executable-tag ((t (:foreground ,prompt-background))))
   `(diredp-file-suffix ((t (:foreground "#ff8700"))))
   `(diredp-flag-mark ((t (:foreground "#c6c6c6" :background "#ff1f8b" :bold t))))
   `(diredp-flag-mark-line ((t (:foreground "#303030" :background "#ff7bbb"))))
   `(diredp-ignored-file-name ((t (:foreground "#8a8a8a"))))
   `(diredp-link-priv ((t (:foreground "#ff1f8b"))))
   `(diredp-mode-line-flagged ((t (:foreground "#303030" :background ,prompt-background))))
   `(diredp-mode-line-marked ((t (:foreground "#c6c6c6" :background "#ff1f8b" bold t))))
   `(diredp-no-priv ((t (:foreground "#c6c6c6" :background "#3a3a3a"))))
   `(diredp-number ((t (:foreground "#fce94f"))))
   `(diredp-other-priv ((t (:foreground "#c6c6c6" :background ,highlight-background))))
   `(diredp-rare-priv ((t (:foreground "#c6c6c6" :background "#af5fff"))))
   `(diredp-symlink ((t (:foreground "#ff1f8b"))))
   `(diredp-read-priv ((t (:foreground ,prompt-foreground :background ,prompt-background))))
   `(diredp-write-priv ((t (:foreground "#0000af" :background "#afd7ff"))))
   `(diredp-exec-priv ((t (:foreground "#a40000" :background "#ffaf87"))))


   ;; Message faces
   `(message-cited-text ((t (:foreground ,prompt-background))))
   `(message-header-cc ((t (:foreground "#afd7ff"))))
   `(message-header-name ((t (:foreground "#b2b2b2"))))
   `(message-header-newsgroups ((t (:foreground ,link-text :bold t))))
   `(message-header-other ((t (:foreground "#ff7bbb"))))
   `(message-header-subject ((t (:foreground "#ffffff" :bold t))))
   `(message-header-to ((t (:foreground ,link-text :underline t :bold t))))
   `(message-header-xheader ((t (:foreground "#a8a8a8"))))
   `(message-mml ((t (:foreground "#ff8700"))))
   `(message-separator ((t (:foreground "#6c6c6c"))))

   ;; Grep
   `(grep-context-face ((t (:foreground "#dd0000"))))
   `(grep-error-face ((t (:foreground "#ef2929" :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,prompt-background))))
   `(grep-match-face ((t (:foreground nil :background nil :inherit match))))

   ;; Diff
   `(diff-context ((t (:foreground "#6c6c6c"))))
   `(diff-file-header ((t (:foreground "#303030" :background "#afd7ff" :bold t))))
   `(diff-function ((t (:foreground "#3a3a3a" :background "#c6c6c6"))))
   `(diff-header ((t (:foreground ,highlight-background :background "#afd7ff"))))
   `(diff-hunk-header ((t (:foreground "#afd7ff" :background "#4e4e4e" :bold t))))
   `(diff-index ((t (:foreground "#3a3a3a" :background "#b2b2b2" :bold t))))
   `(diff-indicator-added ((t (:foreground "#ffffff" :background "#5faf00" :bold t))))
   `(diff-indicator-changed ((t (:foreground "#ffffff" :background "#c4a000" :bold t))))
   `(diff-indicator-removed ((t (:foreground "#ffffff" :background "#a40000" :bold t))))
   `(diff-nonexistent ((t (:foreground "#ffffff" :background "#a40000" :bold t))))
   `(diff-refine-added ((t (:foreground "#ffffff" :background ,prompt-foreground :bold t))))
   `(diff-refine-change ((t (:foreground "#ffffff" :background "#875f00" :bold t))))
   `(diff-refine-removed ((t (:foreground "#ffffff" :background "#a40000" :bold t))))

   ;; Ediff
   `(ediff-current-diff-A ((t (:background "#875f00"))))
   `(ediff-current-diff-Ancestor ((t (:background ,highlight-background))))
   `(ediff-current-diff-B ((t (:background "#6c0099"))))
   `(ediff-current-diff-C ((t (:background "#af5f00"))))
   `(ediff-even-diff-A ((t (:background "#4e4e4e"))))
   `(ediff-even-diff-Ancestor ((t (:background "#4e4e4e"))))
   `(ediff-even-diff-B ((t (:background "#4e4e4e"))))
   `(ediff-even-diff-C ((t (:background "#4e4e4e"))))
   `(ediff-fine-diff-A ((t (:foreground nil :background "#005f00" :bold t))))
   `(ediff-fine-diff-Ancestor ((t (:foreground nil :background "#005f00" :bold t))))
   `(ediff-fine-diff-B ((t (:foreground nil :background "#005f00" :bold t))))
   `(ediff-fine-diff-C ((t (:foreground nil :background "#005f00" :bold t))))
   `(ediff-odd-diff-A ((t (:background "#a40000"))))
   `(ediff-odd-diff-Ancestor ((t (:background "#a40000"))))
   `(ediff-odd-diff-B ((t (:background "#a40000"))))
   `(ediff-odd-diff-C ((t (:background "#a40000"))))

   ;; smerge
   `(smerge-refined-change ((t (:background ,highlight-background :foreground "#ffffff"))))

   ;; Flyspell faces
   `(flyspell-duplicate ((t (:underline t foreground-color"#ffaf5f"))))
   `(flyspell-incorrect ((t (:background "#ef2929" :foreground "#c6c6c6" :bold t))))

   ;; Semantic faces
   `(semantic-decoration-on-includes ((t (:underline "#a8a8a8"))))
   `(semantic-decoration-on-private-members-face
     ((t (:background "#9a08ff"))))
   `(semantic-decoration-on-protected-members-face
     ((t (:background "#ff1f8b"))))
   `(semantic-decoration-on-unknown-includes
     ((t (:background "#a40000"))))
   `(semantic-decoration-on-unparsed-includes
     ((t (:background "#3a3a3a"))))
   `(semantic-tag-boundary-face ((t (:overline ,link-text))))
   `(semantic-unmatched-syntax-face ((t (:underline "#ef2929"))))

   ;; CUA
   `(cua-rectangle ((t (:background "#ff1f8b" :foreground "#c6c6c6"))))

   ;; Ace-jump
   `(ace-jump-face-background ((t (:background nil :foreground "#6c6c6c"))))
   `(ace-jump-face-foreground ((t (:foreground "#ff8700" :bold t))))


   ;; EShell
   `(eshell-ls-archive ((t (:foreground "#af5fff"))))
   `(eshell-ls-backup ((t (:foreground "#4e4e4e"))))
   `(eshell-ls-clutter ((t (:foreground "#8a8a8a"))))
   `(eshell-ls-directory ((t (:foreground ,link-text :bold t))))
   `(eshell-ls-executable ((t (:foreground ,prompt-background))))
   `(eshell-ls-missing ((t (:foreground "#ffffff" :background "#a40000"))))
   `(eshell-ls-product ((t (:foreground "#ffffff" :background ,prompt-background))))
   `(eshell-ls-readonly ((t (:foreground "#ff5d17"))))
   `(eshell-ls-special ((t (:foreground "#fce94f"))))
   `(eshell-ls-symlink  ((t (:foreground "#ff4ea3"))))
   `(eshell-ls-unreadable ((t (:foreground "#8a8a8a"))))
   `(eshell-prompt ((t (:foreground ,prompt-background :background ,transparent-background :bold t))))

   ;; Comint prompt (Shell)
   `(comint-highlight-input ((t (:foreground ,highlight-foreground :bold t))))
   `(comint-highlight-prompt ((t (:foreground ,prompt-background :background ,transparent-background :bold t))))

   ;; which-function-mode
   `(which-func ((t (:foreground "#ffffff" :background "#ff8700"))))

   ;; Flymake
   `(flymake-warnline ((t (:underline "#ff8700"))))
   `(flymake-errline ((t (:underline "#dd0000"))))


   ;; Malabar
   `(malabar-error-face ((t (:underline "#dd0000"))))
   `(malabar-warning-face ((t (:underline "#ff8700"))))
   `(malabar-info-face ((t (:underline "#1f5bff"))))

   ;; MMM-Mode
   `(mmm-cleanup-submode-face ((t (:background "#ffd787"))))
   `(mmm-code-submode-face ((t (:background "#d7d7ff"))))
   `(mmm-comment-submode-face ((t (:background "#afd7ff"))))
   `(mmm-declaration-submode-face ((t (:background "#87ffff"))))
   `(mmm-default-submode-face ((t (:background "#3a3a3a"))))
   `(mmm-delimiter-face ((t (:background nil :foreground "#ffffff"))))
   `(mmm-init-submode-face ((t (:background "#ffafd7"))))
   `(mmm-output-submode-face ((t (:background "#e6a8df"))))
   `(mmm-special-submode-face ((t (:background ,prompt-background))))

   ;; Clojure
   `(clojure-test-failure-face ((t (:underline "#ff8700"))))
   `(clojure-test-error-face ((t (:underline "#dd0000"))))
   `(clojure-test-success-face ((t (:underline "#5faf00"))))

   ;; Javascript
   `(js2-function-param-face ((t (:foreground "#5faf00"))))
   `(js2-external-variable ((t (:foreground "#ff8700" :underline t))))
   `(js2-error ((t (:foreground ,error-text))))
   `(js2-warning ((t (:foreground nil :underline t :bold t))))

   ;; rcirc
   `(rcirc-bright-nick ((t (:foreground ,link-text :bold t))))
   `(rcirc-dim-nick ((t (:foreground "#8a8a8a" :bold t))))
   `(rcirc-keyword ((t (:foreground "#ff4ea3" :bold t))))
   `(rcirc-my-nick ((t (:foreground ,prompt-background :bold t))))
   `(rcirc-nick-in-message ((t (:foreground "#5faf00"))))
   `(rcirc-nick-in-message-full-line ((t (:foreground ,highlight-background))))
   `(rcirc-other-nick ((t (:foreground ,link-text :bold t))))
   `(rcirc-prompt ((t (:foreground "#4e4e4e" :background ,prompt-background :bold t))))
   `(rcirc-server ((t (:foreground "#a8a8a8"))))
   `(rcirc-server-prefix ((t (:foreground "#a8a8a8"))))
   `(rcirc-timestamp ((t (:foreground "#ff8700"))))
   `(rcirc-track-keyword ((t (:foreground "#ff4ea3"))))
   `(rcirc-track-nick ((t (:foreground ,link-text))))
   `(rcirc-url ((t (:foreground ,link-text :bold nil :underline "#1f5bff"))))

   ;; ERC
   `(erc-button ((t (:foreground ,link-text :underline ,link-text :bold nil))))
   `(erc-current-nick-face ((t (:foreground ,prompt-background))))
   `(erc-dangerous-hosts ((t (:foreground "#dd0000" :bold t))))
   `(erc-direct-msg-face ((t (:foreground "#ff8700"))))
   `(erc-error-face ((t (:foreground "#dd0000"))))
   `(erc-header-face ((t (:background ,link-text))))
   `(erc-input-face ((t (:foreground "#ffffff"))))
   `(erc-keyword-face ((t (:foreground "#ff4ea3" :bold t))))
   `(erc-my-nick-face ((t (:foreground ,prompt-background :bold t))))
   `(erc-nick-default-face ((t (:bold t :foreground ,link-text))))
   `(erc-nick-msg-face ((t (:weight normal :foreground "#ff8700"))))
   `(erc-notice-face ((t (:foreground "#8a8a8a"))))
   `(erc-pal-face ((t (:foreground "#d18aff"))))
   `(erc-prompt-face ((t (:bold t :foreground ,prompt-background :background "#6c6c6c"))))
   `(erc-timestamp-face ((t (:foreground "#ff8700"))))

   ;; ReStructuredText
   `(rst-level-1-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-2-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-3-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-4-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-5-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-6-face ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-1 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-2 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-3 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-4 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-5 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-level-6 ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-adornment ((t (:foreground "#ff8700" :background "#303030" :bold t))))
   `(rst-block ((t (:foreground ,prompt-background :background "#4e4e4e" :bold t))))
   `(rst-comment ((t (:foreground "#ff4b4b" :background "#a40000" :bold t))))
   `(rst-literal ((t (:foreground ,prompt-background :background "#4e4e4e"))))
   `(rst-reference ((t (:foreground "#ff4ea3" :background "#303030"))))
   `(rst-definition ((t (:foreground "#fce94f" :background "#303030"))))
   `(rst-directive ((t (:foreground "#d18aff" :background "#3a3a3a" :bold t))))
   `(rst-external ((t (:foreground ,link-text :background "#303030"))))
   `(rst-transition ((t (:foreground ,prompt-background :background "#3a3a3a" :bold t))))

   ;; yalinum
   `(yalinum-bar-face ((t (:foreground "#6c6c6c" :background "#c6c6c6"))))
   `(yalinum-face ((t (:foreground "#c6c6c6" :background "#8a8a8a"))))
   `(yalinum-track-face ((t (:foreground "#c6c6c6" :background "#6c6c6c"))))

   ;; Ruby
   `(enh-ruby-heredoc-delimiter-face ((t (:foreground "#af5fff"))))
   `(enh-ruby-op-face ((t (:foreground "#ff5d17" :bold t))))
   `(enh-ruby-regexp-delimiter-face ((t (:foreground "#af5fff"))))
   `(enh-ruby-string-delimiter-face ((t (:foreground "#af87ff"))))
   `(erm-syn-errline ((t (:foreground "#ffafaf" :background "#a40000" :bold t :underline t))))
   `(erm-syn-warnline ((t (:bold t :underline t))))

   ;; ansi-term
   `(term-color-black ((t (:background "#303030" :foreground "#303030"))))
   `(term-color-blue ((t (:background "#00d7af" :foreground "#00d7af"))))
   `(term-color-cyan ((t (:background "#00d7af" :foreground "#00d7af"))))
   `(term-color-green ((t (:background ,prompt-background :foreground ,prompt-background))))
   `(term-color-magenta ((t (:background "#ff1f8b" :foreground "#ff1f8b"))))
   `(term-color-red ((t (:background "#ef2929" :foreground "#ef2929"))))
   `(term-color-white ((t (:background "#ffffff" :foreground "#ffffff"))))
   `(term-color-yellow ((t (:background "#ff8700" :foreground "#ff8700"))))

   ;; ido-mode
   `(ido-first-match ((t (:foreground "#ff8700" :bold t))))
   `(ido-incomplete-regexp ((t (:foreground "#ff4b4b" :bold t))))
   `(ido-indicator ((t (:foreground "#875f00" :background "#ffd787"))))
   `(ido-only-match ((t (:foreground ,prompt-background :background nil))))
   `(ido-subdir ((t (:foreground ,link-text :bold t))))
   `(ido-virtual ((t (:foreground "#ff1f8b"))))


   ;; cfw: Calendar Framework
   ;;   `(cfw:face-annotation ((t (:foreground , :background ,))))
   `(cfw:face-day-title ((t (:foreground "#ffffff" :background "#262626"))))
   ;;   `(cfw:face-default-content ((t (:foreground , :background ,))))
   ;;   `(cfw:face-default-day ((t (:foreht , :background ,))))
   ;;   `(cfw:face-disable ((t (:foreground , :background ,))))
   `(cfw:face-grid ((t (:foreground "#8a8a8a"))))
   `(cfw:face-header ((t (:foreground "#c6c6c6" :background "#4e4e4e" :bold t))))
   `(cfw:face-holiday ((t (:foreground "#d18aff" :background "#262626" :bold t))))
   ;;   `(cfw:face-periods ((t (:foreground , :background ,))))
   `(cfw:face-saturday ((t (:foreground "#c3c9f8" :background ,highlight-background :bold t))))
   `(cfw:face-select ((t (:foreground "#303030" :background ,link-text))))
   `(cfw:face-sunday ((t (:foreground "#ffafaf" :background "#a40000" :bold t))))
   ;;   `(cfw:face-title ((t (:foreground , :background ,))))
   `(cfw:face-today ((t (:foreground "#ff8700" :background "#4e4e4e"))))
   `(cfw:face-today-title ((t (:foreground "#ffffff" :background "#ff8700"))))
   `(cfw:face-toolbar ((t (:foreground "#c6c6c6" :background "#4e4e4e"))))
   `(cfw:face-toolbar-button-off ((t (:foreground "#5faf87":background "#4e4e4e"))))
   `(cfw:face-toolbar-button-on ((t (:foreground "#ef2929" :background "#ffffff"))))

   ;; Column marker
   `(column-marker-1 ((t (:background "#6c6c6c"))))
   `(column-marker-2 ((t (:background "#875f00"))))
   `(column-marker-3 ((t (:background "#a40000"))))

   ;; Swoop
   `(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
   `(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
   ;; Uncustomized
   `(swoop-face-header-format-line ((t (:foreground "#000000" :background nil :underline nil))))
   `(swoop-face-line-buffer-name ((t (:foreground ,prompt-foreground :background ,prompt-background))))
   `(swoop-face-line-number ((t (:foreground "#87875f" :background "#d7d7af"))))
   `(swoop-face-target-line ((t (:foreground "#fce94f" :background "#6c6c6c"))))
   `(swoop-face-target-words ((t (:foreground "#ff7bbb" :background "#6c6c6c" :bold t))))
   `(helm-swoop-target-line-block-face ((t (:foreground "#fce94f" :background "#4e4e4e"))))

   ;; widget
   `(widget-button ((t (:foreground ,link-text :underline t :bold t))))
   `(widget-button-pressed ((t (:foreground "#afd7ff"))))
   `(widget-documentation ((t (:foreground ,prompt-background))))
   `(widget-field ((t (:foreground ,prompt-background :background "#4e4e4e"))))
   `(widget-inactive ((t (:foreground "#8a8a8a"))))
   `(widget-single-line-field ((t (:foreground ,prompt-background :background "#4e4e4e"))))

   ;; table
   `(table-cell ((t (:foreground "#ffffff" :background "#4e4e4e"))))

   ;; compilation
   `(compilation-line-number ((t (:foreground ,metadata-text))))
   `(compilation-info ((t (:foreground ,link-text))))
   ;; Uncustomized
   `(compilation-column-number ((t (:foreground ,prompt-background))))
   `(compilation-error ((t (:foreground ,error-text))))
   `(compilation-mode-line-exit ((t (:foreground ,prompt-foreground :background ,prompt-background :bold t))))
   `(compilation-mode-line-fail ((t (:foreground "#a40000" :background "#ffafaf" :bold t))))
   `(compilation-mode-line-run ((t (:foreground "#d75f00" :background "#ffd787" :bold t))))
   `(compilation-warning ((t (:foreground "#ff5d17"))))

   ;; Neotree
   `(neo-banner-face ((t (:foreground "#5faf00" :background nil))))
   `(neo-header-face ((t (:foreground ,prompt-background :background nil))))
   `(neo-root-dir-face ((t (:foreground "#ff7bbb"))))
   `(neo-button-face ((t (:foreground ,link-text :bold t))))
   `(neo-dir-link-face ((t (:foreground "#1f5bff" :bold t))))
   `(neo-expand-btn-face ((t (:foreground ,link-text :background "#6c6c6c"))))
   `(neo-file-link-face ((t (:foreground "#c6c6c6"))))

   ;; info
   `(info-header-node ((t (:foreground "#ff4ea3" :bold t))))
   `(info-header-xref ((t (:foreground ,link-text :background nil :bold t))))
   `(info-index-match ((t (:background ,highlight-background))))
   `(info-menu-header ((t (:foreground "#ffffff" :bold t :underline t))))
   `(info-menu-star ((t (:foreground "#ef2929"))))
   `(info-node ((t (:foreground "#a40000"))))
   `(info-title-1 ((t (:foreground ,link-text :bold t))))
   `(info-title-2 ((t (:foreground ,prompt-background :bold t))))
   `(info-title-3 ((t (:foreground "#ff8700" :bold t))))
   `(info-title-4 ((t (:foreground "#ff4ea3" :bold t))))
   `(info-xref ((t (:foreground ,link-text :underline t))))
   `(info-xref-visited ((t (:foreground "#d18aff" :underline t))))

   ;; Tuareg
   `(tuareg-font-lock-error-face ((t (:foreground "#a40000" :background "#ffafaf" :bold t))))
   `(tuareg-font-lock-governing-face ((t (:foreground "#c6c6c6" :bold t))))
   `(tuareg-font-lock-interactive-error-face ((t (:foreground "#a40000" :background "#ffafaf" :bold t))))
   `(tuareg-font-lock-interactive-output-face ((t (:foreground ,highlight-background))))
   `(tuareg-font-lock-multistage-face ((t (:foreground ,highlight-background :background "#afd7ff"))))
   `(tuareg-font-lock-operator-face ((t (:foreground ,prompt-background :background "#4e4e4e" :bold t))))

   ;; CPerl
   `(cperl-array-face ((t (:foreground "#c3c9f8" :background ,highlight-background))))
   `(cperl-hash-face ((t (:foreground "#ffaf87" :background "#5f0000"))))
   `(cperl-nonoverridable-face ((t (:foreground ,prompt-background :background "#005f00"))))

   ;; Haskell
   `(haskell-interactive-face-compile-error ((t (:foreground "#ff4b4b" :background nil :bold t))))
   `(haskell-interactive-face-compile-warning ((t (:foreground "#ff8700" :background nil :bold t))))
   `(haskell-interactive-face-garbage ((t (:foreground "#8a8a8a"))))
   `(haskell-interactive-face-prompt ((t (:foreground ,prompt-background :background "#6c6c6c" :bold t))))
   `(haskell-interactive-face-result ((t (:foreground ,link-text))))

   ;; tty-menu
   `(menu ((t (:foreground "#a8a8a8" :background "#4e4e4e"))))
   `(tty-menu-disabled-face ((t (:foreground "#6c6c6c" :background "#4e4e4e"))))
   `(tty-menu-enabled-face ((t (:foreground "#ffffff" :background "#4e4e4e" :bold t))))
   `(tty-menu-selected-face ((t (:background ,highlight-background))))

   ;; web-mode
   `(web-mode-comment-face ((t (:foreground "#4e4e4e"))))
   `(web-mode-current-element-highlight-face ((t (:background "#4e4e4e"))))
   `(web-mode-current-column-highlight-face ((t (:background "#4e4e4e"))))
   `(web-mode-symbol-face ((t (:foreground "#ffd700"))))
   `(web-mode-type-face ((t (:foreground "#00d7af"))))

   ;; Custom
   `(custom-button ((t (:background "#afd7ff" :foreground ,highlight-background
                                         :box (:line-width 1 :style released-button)))))
   `(custom-button-mouse ((t (:background "#d7d7ff" :foreground "#4e4e4e"
                                               :box (:line-width 1 :style released-button)))))
   `(custom-button-pressed ((t (:foreground "#4e4e4e" :background "#c6c6c6"
                                                 :box (:line-width 1 :style pressed-button)))))

   ;; Hydra
   `(hydra-face-red ((t (:foreground "#ff4b4b"))))
   `(hydra-face-blue ((t (:foreground ,link-text))))
   `(hydra-face-amaranth ((t (:foreground "#ff4ea3"))))
   )

  )

;;; Variables
(kleene-dark-with-color-variables
  (custom-theme-set-variables
   'kleene-dark
   `(ansi-color-names-vector ["#303030" "#ff4b4b" ,prompt-background "#fce94f"
                              ,link-text "#d18aff" "#afd7ff" "#c6c6c6"]))
 )

(provide-theme 'kleene-dark)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; kleene-dark-theme.el ends here
