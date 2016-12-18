;; kleene-dark2-theme.el --- Kleene Dark 2

;;; Commentary:
;;; Code:

(deftheme kleene-dark2 "Kleene Dark 2")

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
    ;; Special
    ("cblk-bg"       . "#262626")
    ;; Colors
    ("aqua"          . "#2aa198")
    ("green"         . "#21D726")
    ("cyan"          . "#00ffff")
    ("red"           . "#E30A17")
    ("blue"          . "#27E5E4")
    ("magenta"       . "#af00df")
    ("yellow"        . "#875f00")
    ("black"         . "#000000")
    ;; Syntax
    ("keyword"       . "#FFFFB6")
    ("comment"       . "#626262")
    ("const"         . "#99CC99")
    ("func"          . "#FFD2A7")
    ;; Other
    ("act1"          . "#808080")
    ("act2"          . "#444444")
    ("base"          . "#ffffff")
    ("base-dim"      . "#B2B2B2")
    ("bg1"           . "#3A3A3A")
    ("bg2"           . "#1c1c1c")
    ("bg3"           . "#121212")
    ("bg4"           . "#080808")
    ("border"        . "#111111")
    ("cblk"          . "#b2b2b2")
    ("cblk-ln"       . "#af5faf")
    ("cblk-ln-bg"    . "#333333")
    ("cursor"        . "#d0d0d0")
    ("comment-bg"    . cblk-bg)
    ("comp"          . const)
    ("err"           . "#e0211d")
    ("header"         . base)
    ("head3"         . "#67b11d")
    ("head3-bg"      . cblk-bg)
    ("head4"         . "#875f00")
    ("head4-bg"      . cblk-bg)
    ("highlight"     . "#4AA4B0")
    ("highlight2"    . "#68E0D8")
    ("lnum"          . "#444444")
    ("mat"           . "#86dc2f")
    ("meta"          . "#af875f")
    ("str"           . "#2aa198")
    ("suc"           . "#86dc2f")
    ("ttip"          . "#888888")
    ("ttip-sl"       . "#333333")
    ("type"          . "#df005f")
    ("var"           . "#8787d7")
    ("war"           . "#dc752f")
    ))

(kleene-dark-with-color-variables
  (custom-theme-set-faces
   'kleene-dark2

;;;;; syntax
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

;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:bold nil :foreground "#AFD7D7"))))
   `(rainbow-delimiters-depth-2-face ((t (:bold nil :foreground "#01A6B2"))))
   `(rainbow-delimiters-depth-3-face ((t (:bold nil :foreground "#B0FFD7"))))
   `(rainbow-delimiters-depth-4-face ((t (:bold nil :foreground "#D7AFFF"))))
   `(rainbow-delimiters-depth-5-face ((t (:bold nil :foreground "#00D900"))))
   `(rainbow-delimiters-depth-6-face ((t (:bold nil :foreground "#D0D0D0"))))
   `(rainbow-delimiters-depth-7-face ((t (:bold nil :foreground "#999900"))))
   `(rainbow-delimiters-depth-8-face ((t (:bold nil :foreground "#AFD7FF"))))
   `(rainbow-delimiters-depth-9-face ((t (:bold nil :foreground "#01A6B2"))))

;;;;; basics
   `(cursor ((,class (:background ,cursor))))
   `(custom-button ((,class :background ,bg2 :foreground ,base :box (:line-width 2 :style released-button))))
                                        ; `(default ((,class (:background ,bg1 :foreground ,base))))
   `(default-italic ((,class (:italic t))))
   `(error ((,class (:foreground ,err))))
   `(eval-sexp-fu-flash ((,class (:background ,suc :foreground ,bg1))))
   `(eval-sexp-fu-flash-error ((,class (:background ,err :foreground ,bg1))))
   `(fringe ((,class (:background ,bg1 :foreground ,base))))
   `(header-line ((,class :background ,bg4)))
   `(highlight ((,class (:foreground ,base :background ,highlight))))
   `(hl-line ((,class (:background ,bg1))))
   `(isearch ((,class (:background ,highlight2 :foreground ,black))))
   `(lazy-highlight ((,class (:weight normal))))
   `(link ((,class (:foreground ,comment :underline t))))
   `(link-visited ((,class (:foreground ,comp :underline t))))
   `(match ((,class (:background ,highlight :foreground ,mat))))
   `(minibuffer-prompt ((,class (:inherit bold :foreground ,keyword))))
   `(page-break-lines ((,class (:foreground ,act2))))
   `(region ((,class (:background ,highlight :foreground ,black))))
   `(secondary-selection ((,class (:background ,bg3))))
   `(success ((,class (:foreground ,suc))))
   `(tooltip ((,class (:background ,ttip-sl :foreground ,base :bold nil :italic nil :underline nil))))
   `(vertical-border ((,class (:foreground ,bg1))))
   `(warning ((,class (:foreground ,war))))

;;;;; ahs
   `(ahs-face ((,class (:background ,highlight))))
   `(ahs-plugin-whole-buffer-face ((,class (:background ,mat :foreground ,bg1))))

;;;;; anzu-mode
   `(anzu-mode-line ((,class (:foreground ,yellow :inherit bold))))

;;;;; auto-complete
   `(ac-completion-face ((,class (:background ,bg1 :foreground ,ttip))))

;;;;; avy
   `(avy-lead-face   ((,class (:foreground ,magenta))))
   `(avy-lead-face-0 ((,class (:foreground ,blue))))
   `(avy-lead-face-1 ((,class (:foreground ,magenta))))
   `(avy-lead-face-2 ((,class (:foreground ,blue))))

;;;;; cider
   `(cider-enlightened ((,class (:background nil :box (:color ,yellow :line-width -1 :style nil) :foreground ,yellow))))
   `(cider-enlightened-local ((,class (:foreground ,yellow))))
   `(cider-instrumented-face ((,class (:background nil :box (:color ,red :line-width -1 :style nil) :foreground ,red))))
   `(cider-result-overlay-face ((,class (:background nil :box (:color ,blue :line-width -1 :style nil) :foreground ,blue))))
   `(cider-test-error-face ((,class (:background ,war :foreground ,bg1))))
   `(cider-test-failure-face ((,class (:background ,err :foreground ,bg1))))
   `(cider-test-success-face ((,class (:background ,suc :foreground ,bg1))))
   `(cider-traced-face ((,class :box (:color ,cyan :line-width -1 :style nil))))

;;;;; company
   `(company-echo-common ((,class (:background ,base :foreground ,bg1))))
   `(company-preview ((,class (:background ,bg1 :foreground ,ttip))))
   `(company-preview-common ((,class (:background ,bg1 :foreground ,base))))
   `(company-preview-search ((,class (:inherit match))))
   `(company-scrollbar-bg ((,class (:background ,bg2))))
   `(company-scrollbar-fg ((,class (:background ,act2))))
   `(company-template-field ((,class (:inherit region))))
   `(company-tooltip ((,class (:background ,bg1 :foreground ,ttip))))
   `(company-tooltip-annotation ((,class (:foreground ,keyword))))
   `(company-tooltip-common ((,class (:background ,bg1 :foreground ,base))))
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
   `(dired-directory ((,class (:foreground ,keyword :background ,bg1 :inherit bold))))
   `(dired-flagged ((,class (:foreground ,red))))
   `(dired-header ((,class (:foreground ,comp :inherit bold))))
   `(dired-ignored ((,class (:inherit shadow))))
   `(dired-mark ((,class (:foreground ,comp :inherit bold))))
   `(dired-marked ((,class (:foreground ,magenta :inherit bold))))
   `(dired-perm-write ((,class (:foreground ,base :underline t))))
   `(dired-symlink ((,class (:foreground ,cyan :background ,bg1 :inherit bold))))
   `(dired-warning ((,class (:foreground ,war))))

;;;;; ediff
   `(ediff-current-diff-A ((,class(:foreground ,red))))
   `(ediff-current-diff-Ancestor ((,class(:foreground ,aqua))))
   `(ediff-current-diff-B ((,class(:foreground ,green))))
   `(ediff-current-diff-C ((,class(:foreground ,blue))))
   `(ediff-even-diff-A ((,class(:background ,bg3))))
   `(ediff-even-diff-Ancestor ((,class(:background ,bg3))))
   `(ediff-even-diff-B ((,class(:background ,bg3))))
   `(ediff-even-diff-C ((,class(:background ,bg3))))
   `(ediff-fine-diff-A ((,class(:background nil :inherit bold))))
   `(ediff-fine-diff-Ancestor ((,class(:background nil :inherit bold))))
   `(ediff-fine-diff-B ((,class(:background nil :inherit bold))))
   `(ediff-fine-diff-C ((,class(:background nil :inherit bold))))
   `(ediff-odd-diff-A ((,class(:background ,bg4))))
   `(ediff-odd-diff-Ancestor ((,class(:background ,bg4))))
   `(ediff-odd-diff-B ((,class(:background ,bg4))))
   `(ediff-odd-diff-C ((,class(:background ,bg4))))

;;;;; ein
   `(ein:cell-input-area((,class (:background ,bg2))))
   `(ein:cell-input-prompt ((,class (:foreground ,suc))))
   `(ein:cell-output-prompt ((,class (:foreground ,err))))
   `(ein:notification-tab-normal ((,class (:foreground ,keyword))))
   `(ein:notification-tab-selected ((,class (:foreground ,suc :inherit bold))))

;;;;; eldoc
   `(eldoc-highlight-function-argument ((,class (:foreground ,mat :inherit bold))))

;;;;; elfeed
   `(elfeed-search-title-face ((,class (:foreground ,base-dim))))
   `(elfeed-search-unread-title-face ((,class (:foreground ,base))))
   `(elfeed-search-feed-face ((,class (:foreground ,blue))))
   `(elfeed-search-tag-face ((,class (:foreground ,func))))

;;;;; enh-ruby
   `(enh-ruby-string-delimiter-face ((,class (:foreground ,str))))
   `(enh-ruby-op-face ((,class (:background ,bg1 :foreground ,base))))

;;;;; erc
   `(erc-input-face ((,class (:foreground ,func))))
   `(erc-my-nick-face ((,class (:foreground ,keyword))))
   `(erc-nick-default-face ((,class (:foreground ,keyword))))
   `(erc-nick-prefix-face ((,class (:foreground ,yellow))))
   `(erc-notice-face ((,class (:foreground ,str))))
   `(erc-prompt-face ((,class (:foreground ,mat :inherit bold))))
   `(erc-timestamp-face ((,class (:foreground ,keyword))))

;;;;; eshell
   `(eshell-ls-archive ((,class (:foreground ,red :inherit bold))))
   `(eshell-ls-backup ((,class (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((,class (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((,class (:foreground ,keyword :inherit bold))))
   `(eshell-ls-executable ((,class (:foreground ,suc :inherit bold))))
   `(eshell-ls-missing ((,class (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((,class (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((,class (:foreground ,yellow :inherit bold))))
   `(eshell-ls-symlink ((,class (:foreground ,cyan :inherit bold))))
   `(eshell-ls-unreadable ((,class (:foreground ,base))))
   `(eshell-prompt ((,class (:foreground ,keyword :inherit bold))))

;;;;; evil
   `(evil-ex-substitute-matches ((,class (:foreground ,red))))
   `(evil-ex-substitute-replacement ((,class (:foreground ,green))))

;;;;; flycheck
   `(flycheck-error
     ((,(append '((supports :underline (:style line))) class)
       (:underline (:style line :color ,err)))
      (,class (:foreground ,base :background ,err :inherit bold :underline t))))
   `(flycheck-error-list-checker-name ((,class (:foreground ,keyword))))
   `(flycheck-fringe-error ((,class (:foreground ,err :inherit bold))))
   `(flycheck-fringe-info ((,class (:foreground ,keyword :inherit bold))))
   `(flycheck-fringe-warning ((,class (:foreground ,war :inherit bold))))
   `(flycheck-info
     ((,(append '((supports :underline (:style line))) class)
       (:underline (:style line :color ,keyword)))
      (,class (:foreground ,base :background ,keyword :inherit bold :underline t))))
   `(flycheck-warning
     ((,(append '((supports :underline (:style line))) class)
       (:underline (:style line :color ,war)))
      (,class (:foreground ,base :background ,war :inherit bold :underline t))))

;;;;; jabber
   `(jabber-activity-face ((,class (:inherit bold :foreground ,red))))
   `(jabber-activity-personal-face ((,class (:inherit bold :foreground ,blue))))
   `(jabber-chat-error ((,class (:inherit bold :foreground ,red))))
   `(jabber-chat-prompt-foreign ((,class (:inherit bold :foreground ,red))))
   `(jabber-chat-prompt-local ((,class (:inherit bold :foreground ,blue))))
   `(jabber-chat-prompt-system ((,class (:inherit bold :foreground ,green))))
   `(jabber-chat-text-foreign ((,class (:foreground ,base))))
   `(jabber-chat-text-local ((,class (:foreground ,base))))
   `(jabber-rare-time-face ((,class (:foreground ,green))))
   `(jabber-roster-user-away ((,class (:foreground ,yellow))))
   `(jabber-roster-user-chatty ((,class (:inherit bold :foreground ,green))))
   `(jabber-roster-user-dnd ((,class (:foreground ,red))))
   `(jabber-roster-user-error ((,class (:foreground ,err))))
   `(jabber-roster-user-offline ((,class (:foreground ,base))))
   `(jabber-roster-user-online ((,class (:inherit bold :foreground ,green))))
   `(jabber-roster-user-xa ((,class (:foreground ,aqua))))

;;;;; git-gutter-fr
   `(git-gutter-fr:added ((,class (:foreground ,green :inherit bold))))
   `(git-gutter-fr:deleted ((,class (:foreground ,war :inherit bold))))
   `(git-gutter-fr:modified ((,class (:foreground ,keyword :inherit bold))))

;;;;; git-timemachine
   `(git-timemachine-minibuffer-detail-face ((,class (:foreground ,blue :inherit bold))))

;;;;; gnus
   `(gnus-emphasis-highlight-words ((,class (:background ,suc :foreground ,bg1))))
   `(gnus-header-content ((,class (:foreground ,keyword))))
   `(gnus-header-from ((,class (:foreground ,var))))
   `(gnus-header-name ((,class (:foreground ,comp))))
   `(gnus-header-subject ((,class (:foreground ,func :inherit bold))))
   `(gnus-summary-cancelled ((,class (:background ,war :foreground ,bg1))))

;;;;; guide-key
   `(guide-key/highlight-command-face ((,class (:foreground ,base))))
   `(guide-key/key-face ((,class (:foreground ,keyword))))
   `(guide-key/prefix-command-face ((,class (:foreground ,keyword :inherit bold))))

;;;;; helm
   `(helm-bookmark-directory ((,class (:inherit helm-ff-directory))))
   `(helm-bookmark-file ((,class (:foreground ,base))))
   `(helm-bookmark-gnus ((,class (:foreground ,comp))))
   `(helm-bookmark-info ((,class (:foreground ,comp))))
   `(helm-bookmark-man ((,class (:foreground ,comp))))
   `(helm-bookmark-w3m ((,class (:foreground ,comp))))
   `(helm-buffer-directory ((,class (:foreground ,base :background ,bg1))))
   `(helm-buffer-file ((,class (:foreground ,base :background ,bg1))))
   `(helm-buffer-not-saved ((,class (:foreground ,comp :background ,bg1))))
   `(helm-buffer-process ((,class (:foreground ,keyword :background ,bg1))))
   `(helm-buffer-saved-out ((,class (:foreground ,base :background ,bg1))))
   `(helm-buffer-size ((,class (:foreground ,base :background ,bg1))))
   `(helm-candidate-number ((,class (:background ,bg1 :foreground ,keyword :inherit bold))))
   `(helm-ff-directory ((,class (:foreground ,keyword :background ,bg1 :inherit bold))))
   `(helm-ff-dotted-directory ((,class (:foreground ,keyword :background ,bg1 :inherit bold))))
   `(helm-ff-dotted-symlink-directory ((,class (:foreground ,cyan :background ,bg1 :inherit bold))))
   `(helm-ff-executable ((,class (:foreground ,suc :background ,bg1 :weight normal))))
   `(helm-ff-file ((,class (:foreground ,base :background ,bg1 :weight normal))))
   `(helm-ff-invalid-symlink ((,class (:foreground ,red :background ,bg1 :inherit bold))))
   `(helm-ff-prefix ((,class (:foreground ,bg1 :background ,keyword :weight normal))))
   `(helm-ff-symlink ((,class (:foreground ,cyan :background ,bg1 :inherit bold))))
   `(helm-grep-cmd-line ((,class (:foreground ,base :background ,bg1))))
   `(helm-grep-file ((,class (:foreground ,base :background ,bg1))))
   `(helm-grep-finish ((,class (:foreground ,base :background ,bg1))))
   `(helm-grep-lineno ((,class (:foreground ,type :background ,bg1 :inherit bold))))
   `(helm-grep-match ((,class (:foreground nil :background nil :inherit helm-match))))
   `(helm-header ((,class (:foreground ,base :background ,bg1 :underline nil :box nil))))
   `(helm-header-line-left-margin ((,class (:foreground ,keyword :background ,nil))))
   `(helm-match ((,class (:background ,bg1 :foreground ,header))))
   `(helm-match-item ((,class (:background ,bg1 :foreground ,header))))
   `(helm-moccur-buffer ((,class (:foreground ,var :background ,bg1))))
   `(helm-selection ((,class (:background ,highlight))))
   `(helm-selection-line ((,class (:background ,bg2))))
   `(helm-separator ((,class (:foreground ,comp :background ,bg1))))
   `(helm-source-header ((,class (:background ,comp :foreground ,bg1 :inherit bold))))
   `(helm-time-zone-current ((,class (:foreground ,keyword :background ,bg1))))
   `(helm-time-zone-home ((,class (:foreground ,comp :background ,bg1))))
   `(helm-visible-mark ((,class (:foreground ,keyword :background ,bg3))))

;;;;; helm-swoop
   `(helm-swoop-target-line-block-face ((,class (:foreground ,base :background ,highlight))))
   `(helm-swoop-target-line-face ((,class (:background ,highlight))))
   `(helm-swoop-target-word-face ((,class (:background ,highlight :foreground ,mat))))

;;;;; highlights
   `(hi-yellow ((,class (:foreground ,yellow))))
   `(hi-green  ((,class (:foreground ,green))))

;;;;; highlight-symbol
   `(highlight-symbol-face ((,class (:background ,bg2))))

;;;;; hydra
   `(hydra-face-blue ((,class (:foreground ,blue))))
   `(hydra-face-red ((,class (:foreground ,red))))

;;;;; ido
   `(ido-first-match ((,class (:foreground ,comp :inherit bold))))
   `(ido-only-match ((,class (:foreground ,mat :inherit bold))))
   `(ido-subdir ((,class (:foreground ,keyword))))
   `(ido-vertical-match-face ((,class (:foreground ,comp :underline nil))))

;;;;; info
   `(info-header-xref ((,class (:foreground ,func :underline t))))
   `(info-menu ((,class (:foreground ,suc))))
   `(info-node ((,class (:foreground ,func :inherit bold))))
   `(info-quoted-name ((,class (:foreground ,keyword))))
   `(info-reference-item ((,class (:background nil :underline t :inherit bold))))
   `(info-string ((,class (:foreground ,str))))
   `(info-title-1 ((,class (:height 1.4 :inherit bold))))
   `(info-title-2 ((,class (:height 1.3 :inherit bold))))
   `(info-title-3 ((,class (:height 1.3))))
   `(info-title-4 ((,class (:height 1.2))))

;;;;; ivy
   `(ivy-current-match ((,class (:background ,highlight :inherit bold))))
   `(ivy-minibuffer-match-face-1 ((,class (:inherit bold))))
   `(ivy-minibuffer-match-face-2 ((,class (:foreground ,header :underline t))))
   `(ivy-minibuffer-match-face-3 ((,class (:foreground ,header :underline t))))
   `(ivy-minibuffer-match-face-4 ((,class (:foreground ,header :underline t))))
   `(ivy-remote ((,class (:foreground ,cyan))))

;;;;; latex
   `(font-latex-bold-face ((,class (:foreground ,comp))))
   `(font-latex-italic-face ((,class (:foreground ,keyword :italic t))))
   `(font-latex-match-reference-keywords ((,class (:foreground ,const))))
   `(font-latex-match-variable-keywords ((,class (:foreground ,var))))
   `(font-latex-sectioning-0-face ((,class (:inherit bold :foreground ,head3 :background ,head3-bg))))
   `(font-latex-sectioning-1-face ((,class (:inherit bold :foreground ,head4 :background ,head4-bg))))
   `(font-latex-sectioning-2-face ((,class (:inherit bold :foreground ,header :background ,bg1))))
   `(font-latex-sectioning-3-face ((,class (:inherit bold :foreground ,header))))
   `(font-latex-sectioning-4-face ((,class (:bold nil :foreground ,header :background ,head3-bg))))
   `(font-latex-sectioning-5-face ((,class (:bold nil :foreground ,header :background ,head4-bg))))
   `(font-latex-string-face ((,class (:foreground ,str))))

;;;;; linum-mode
   `(linum ((,class (:foreground ,lnum :background ,bg2))))

;;;;; linum-relative
   `(linum-relative-current-face ((,class (:foreground ,comp))))

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
   `(magit-diff-context-highlight ((,class (:inherit magit-diff-context :background ,bg1))))
   `(magit-diff-file-header ((,class (:foreground ,comment))))
   `(magit-diff-file-heading ((,class (:foreground ,base))))
   `(magit-diff-file-heading-highlight ((,class (:inherit magit-diff-file-heading :background ,bg1))))
   `(magit-diff-hunk-header ((,class (:foreground ,ttip))))
   `(magit-diff-hunk-heading ((,class (:foreground ,ttip))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,bg1 :foreground ,ttip))))
   `(magit-hash ((,class (:foreground ,var))))
   `(magit-hunk-heading           ((,class (:background ,bg3))))
   `(magit-hunk-heading-highlight ((,class (:background ,bg1))))
   `(magit-item-highlight ((,class :background ,bg1 :foreground unspecified)))
   `(magit-log-author ((,class (:foreground ,func))))
   `(magit-log-head-label-head ((,class (:background ,yellow :foreground ,bg1 :inherit bold))))
   `(magit-log-head-label-local ((,class (:background ,keyword :foreground ,bg1 :inherit bold))))
   `(magit-log-head-label-remote ((,class (:background ,suc :foreground ,bg1 :inherit bold))))
   `(magit-log-head-label-tags ((,class (:background ,magenta :foreground ,bg1 :inherit bold))))
   `(magit-log-head-label-wip ((,class (:background ,cyan :foreground ,bg1 :inherit bold))))
   `(magit-log-sha1 ((,class (:foreground ,str))))
   `(magit-process-ng ((,class (:foreground ,war :inherit bold))))
   `(magit-process-ok ((,class (:foreground ,func :inherit bold))))
   `(magit-section-heading        ((,class (:foreground ,keyword :inherit bold))))
   `(magit-section-highlight ((t (:background ,bg1 :foreground nil))))
   `(magit-section-title ((,class (:background ,bg1 :foreground ,keyword :inherit bold))))
   `(magit-diff-added ((t (:inherit diff-added))))
   `(magit-diff-removed ((t (:inherit diff-removed))))
   `(magit-diff-added-highlight ((t (:inherit diff-added :background ,bg1))))
   `(magit-diff-removed-highlight ((t (:inherit diff-removed :background ,bg1))))
   
;;;;; man
   `(Man-overstrike ((,class (:foreground ,header :inherit bold))))
   `(Man-reverse ((,class (:foreground ,highlight))))
   `(Man-underline ((,class (:foreground ,comp :underline t))))



;;;;; markdown
   `(markdown-header-face-1 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-2 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-3 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-4 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-5 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(markdown-header-face-6 ((,class (:inherit bold :foreground ,header :background unspecified))))

;;;;; mode-line
   `(mode-line           ((,class (:foreground ,base :background ,act1 :box (:color ,border :line-width 1)))))
   `(mode-line-inactive  ((,class (:foreground ,base-dim :background ,bg1  :box (:color ,border :line-width 1)))))

;;;;; mu4e
   `(mu4e-cited-1-face ((,class (:foreground ,base))))
   `(mu4e-cited-7-face ((,class (:foreground ,base))))
   `(mu4e-header-marks-face ((,class (:foreground ,comp))))
   `(mu4e-header-key-face ((,class (:foreground ,header :inherit bold))))
   `(mu4e-view-url-number-face ((,class (:foreground ,comp))))
   `(mu4e-unread-face ((,class (:foreground ,yellow :inherit bold))))

;;;;; neotree
   `(neo-dir-link-face ((,class (:foreground ,keyword :inherit bold))))
   `(neo-expand-btn-face ((,class (:foreground ,base))))
   `(neo-file-link-face ((,class (:foreground ,base))))
   `(neo-root-dir-face ((,class (:foreground ,func :inherit bold))))

;;;;; org
   `(org-agenda-clocking ((,class (:background ,highlight :foreground ,comp))))
   `(org-agenda-date ((,class (:foreground ,var))))
   `(org-agenda-date-today ((,class (:foreground ,keyword :inherit bold))))
   `(org-agenda-date-weekend ((,class (:inherit bold :foreground ,var))))
   `(org-agenda-done ((,class (:foreground ,suc))))
   `(org-agenda-structure ((,class (:inherit bold :foreground ,comp))))
   `(org-block ((,class (:background ,cblk-bg :foreground ,cblk))))
   `(org-block-begin-line ((,class (:background ,cblk-ln-bg :foreground ,cblk-ln))))
   `(org-block-end-line ((,class (:background ,cblk-ln-bg :foreground ,cblk-ln))))
   `(org-clock-overlay ((,class (:foreground ,comp))))
   `(org-code ((,class (:foreground ,cyan))))
   `(org-column ((,class (:background ,highlight))))
   `(org-column-title ((,class (:background ,highlight))))
   `(org-date ((,class (:underline t :foreground ,var))))
   `(org-date-selected ((,class (:background ,func :foreground ,bg1))))
   `(org-document-info-keyword ((,class (:foreground ,meta))))
   `(org-document-title ((,class (:foreground ,func :inherit bold :underline t))))
   `(org-done ((,class (:foreground ,suc :inherit bold))))
   `(org-ellipsis ((,class (:foreground ,keyword))))
   `(org-footnote  ((,class (:underline t :foreground ,base))))
   `(org-hide ((,class (:foreground ,base))))
   `(org-kbd ((,class (:inherit region :foreground ,base :box (:line-width 1 :style released-button)))))
   `(org-level-1 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(org-level-2 ((,class (:inherit bold :foreground ,header :background unspecified))))
   `(org-level-3 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-level-4 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-level-5 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-level-6 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-level-7 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-level-8 ((,class (:bold nil :foreground ,header :background unspecified))))
   `(org-link ((,class (:underline t :foreground ,comment))))
   `(org-meta-line ((,class (:foreground ,meta))))
   `(org-mode-line-clock-overrun ((,class (:foreground ,err))))
   `(org-priority ((,class (:foreground ,war :inherit bold))))
   `(org-quote ((,class (:inherit org-block :slant italic))))
   `(org-scheduled ((,class (:foreground ,comp))))
   `(org-scheduled-today ((,class (:foreground ,func))))
   `(org-sexp-date ((,class (:foreground ,base))))
   `(org-special-keyword ((,class (:foreground ,func))))
   `(org-table ((,class (:foreground ,base :background ,bg1))))
   `(org-time-grid ((,class (:foreground ,str))))
   `(org-todo ((,class (:foreground ,war :inherit bold :background))))
   `(org-verbatim ((,class (:foreground ,keyword))))
   `(org-verse ((,class (:inherit org-block :slant italic))))
   `(org-warning ((,class (:foreground ,err))))

;;;;; perspective
   `(persp-selected-face ((,class (:inherit bold :foreground ,func))))

;;;;; popup
   `(popup-face ((,class (:background ,bg1 :foreground ,ttip))))
   `(popup-tip-face ((,class (:background ,ttip-sl :foreground ,base :bold nil :italic nil :underline nil))))
   `(popup-menu-face ((,class (:background ,bg1 :foreground ,base))))
   `(popup-enu-selection-face ((,class (:background ,ttip-sl :foreground ,base))))
   `(popup-menu-mouse-face ((,class (:inherit highlight))))
   `(popup-isearch-match ((,class (:inherit match))))
   `(popup-scroll-bar-foreground-face ((,class (:background ,act2))))
   `(popup-scroll-bar-background-face ((,class (:background ,bg2))))

;;;;; powerline
   `(powerline-active1 ((,class (:background ,act2 :foreground ,base))))
   `(powerline-active2 ((,class (:background ,act2 :foreground ,base))))
   `(powerline-inactive1 ((,class (:background ,bg2 :foreground ,base))))
   `(powerline-inactive2 ((,class (:background ,bg2 :foreground ,base))))


;;;;; show-paren
   `(show-paren-match ((,class (:background ,act1))))
   `(show-paren-mismatch ((,class (:foreground ,red))))

;;;;; smartparens
   `(sp-pair-overlay-face ((,class (:background ,highlight :foreground nil))))
   `(sp-show-pair-match-face ((,class (:foreground ,mat :inherit bold :underline t))))

;;;;; spaceline
   `(spaceline-python-venv ((,class (:foreground ,comp))))
   `(spaceline-flycheck-error  ((,class (:foreground ,err))))
   `(spaceline-flycheck-info   ((,class (:foreground ,keyword))))
   `(spaceline-flycheck-warning((,class (:foreground ,war))))

;;;;; swiper
   `(swiper-line-face ((,class (:background ,highlight :inherit bold))))
   `(swiper-match-face-1 ((,class (:inherit bold))))
   `(swiper-match-face-2 ((,class (:foreground ,header :underline t))))
   `(swiper-match-face-3 ((,class (:foreground ,header :underline t))))
   `(swiper-match-face-4 ((,class (:foreground ,header :underline t))))

;;;;; tabbar
   `(tabbar-default ((,class (:background ,bg1 :foreground ,header :height 0.9))))
   `(tabbar-button ((,class (:inherit tabbar-default ))))
   `(tabbar-button-highlight ((,class (:inherit tabbar-default))))
   `(tabbar-highlight ((,class (:underline t))))
   `(tabbar-selected ((,class (:inherit tabbar-default :foreground ,func :weight bold))))
   `(tabbar-separator ((,class (:inherit tabbar-default))))
   `(tabbar-unselected ((,class (:inherit tabbar-default :background ,bg1 :slant italic :weight light))))

;;;;; term
   `(term ((,class (:foreground ,base :background ,bg1))))
   `(term-color-black ((,class (:foreground ,bg4))))
   `(term-color-blue ((,class (:foreground ,keyword))))
   `(term-color-cyan ((,class (:foreground ,cyan))))
   `(term-color-green ((,class (:foreground ,green))))
   `(term-color-magenta ((,class (:foreground ,magenta))))
   `(term-color-red ((,class (:foreground ,red))))
   `(term-color-white ((,class (:foreground ,base))))
   `(term-color-yellow ((,class (:foreground ,yellow))))

;;;;; web-mode
   `(web-mode-builtin-face ((,class (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((,class (:inherit ,font-lock-constant-face))))
   `(web-mode-doctype-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-function-name-face ((,class (:inherit ,font-lock-function-name-face))))
   `(web-mode-html-attr-name-face ((,class (:foreground ,func))))
   `(web-mode-html-attr-value-face ((,class (:foreground ,keyword))))
   `(web-mode-html-tag-face ((,class (:foreground ,keyword))))
   `(web-mode-keyword-face ((,class (:foreground ,keyword))))
   `(web-mode-string-face ((,class (:foreground ,str))))
   `(web-mode-symbol-face ((,class (:foreground ,type))))
   `(web-mode-type-face ((,class (:inherit ,font-lock-type-face))))
   `(web-mode-warning-face ((,class (:inherit ,font-lock-warning-face))))

;;;;; which-key
   `(which-key-command-description-face ((,class (:foreground ,base))))
   `(which-key-group-description-face ((,class (:foreground ,keyword))))
   `(which-key-key-face ((,class (:foreground ,func :inherit bold))))
   `(which-key-separator-face ((,class (:background nil :foreground ,str))))
   `(which-key-special-key-face ((,class (:background ,func :foreground ,bg1))))

;;;;; which-function-mode
   `(which-func ((,class (:foreground ,func))))

;;;;; whitespace-mode
   `(whitespace-empty ((,class (:background nil :foreground ,yellow))))
   `(whitespace-indentation ((,class (:background nil :foreground ,war))))
   `(whitespace-line ((,class (:background nil :foreground ,comp))))
   `(whitespace-newline ((,class (:background nil :foreground ,comp))))
   `(whitespace-space ((,class (:background nil :foreground ,act2))))
   `(whitespace-space-after-tab ((,class (:background nil :foreground ,yellow))))
   `(whitespace-space-before-tab ((,class (:background nil :foreground ,yellow))))
   `(whitespace-tab ((,class (:background nil))))
   `(whitespace-trailing ((,class (:background ,err :foreground ,war))))

;;;;; other, need more work
   `(ac-completion-face ((,class (:underline t :foreground ,keyword))))
   `(ffap ((,class (:foreground ,base))))
   `(flx-highlight-face ((,class (:foreground ,comp :underline nil))))
   `(icompletep-determined ((,class :foreground ,keyword)))
   `(js2-external-variable ((,class (:foreground ,comp))))
   `(js2-function-param ((,class (:foreground ,const))))
   `(js2-jsdoc-html-tag-delimiter ((,class (:foreground ,str))))
   `(js2-jsdoc-html-tag-name ((,class (:foreground ,keyword))))
   `(js2-jsdoc-value ((,class (:foreground ,str))))
   `(js2-private-function-call ((,class (:foreground ,const))))
   `(js2-private-member ((,class (:foreground ,base))))
   `(js3-error-face ((,class (:underline ,war))))
   `(js3-external-variable-face ((,class (:foreground ,var))))
   `(js3-function-param-face ((,class (:foreground ,keyword))))
   `(js3-instance-member-face ((,class (:foreground ,const))))
   `(js3-jsdoc-tag-face ((,class (:foreground ,keyword))))
   `(js3-warning-face ((,class (:underline ,keyword))))
   `(slime-repl-inputed-output-face ((,class (:foreground ,comp))))
   `(trailing-whitespace ((,class :foreground nil :background ,err)))
   `(undo-tree-visualizer-current-face ((,class :foreground ,keyword)))
   `(undo-tree-visualizer-default-face ((,class :foreground ,base)))
   `(undo-tree-visualizer-register-face ((,class :foreground ,comp)))
   `(undo-tree-visualizer-unmodified-face ((,class :foreground ,var)))
   ))

;;; Variables
(kleene-dark-with-color-variables
  (custom-theme-set-variables
   'kleene-dark2
   `(ansi-color-names-vector [,bg4 ,red ,green ,yellow ,blue ,magenta ,cyan ,base]))
 )

(provide-theme 'kleene-dark2)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; kleene-dark2-theme.el ends here
