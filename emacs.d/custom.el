(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#000000" "#D32D1E" "#62D63F" "#E5E64B" "#005FFF" "#af00df" "#4AA4B0" "#ffffff"])
 '(custom-safe-themes
   '("ad114fd8820edf7d947f356a237468ae2c402565a60b813ee36f6cd3f1d325ae" "c6fb2c37975e0d8fcc91ae7501f06bc9c58f3fb55e658be0fce30cd58bd66f3e" default))
 '(helm-fd-switches
   '("--follow" "--hidden" "--exclude" ".git" "--exclude" ".hg" "--exclude" ".DS_Store" "--color" "never"))
 '(package-selected-packages
   '(esup eshell-syntax-highlighting monky better-defaults yaml-mode embark-consult kotlin-mode consult ef-themes rust-mode eglot evil-goggles use-package nodejs-repl csv-mode ledger-mode fish-mode markdown-mode swift-mode inf-ruby enh-ruby-mode slime smartparens rainbow-mode magit yasnippet editorconfig magit-filenotify wgrep jade-mode aggressive-indent page-break-lines expand-region adaptive-wrap vundo vertico orderless marginalia evil-visualstar evil-surround evil-numbers evil-commentary))
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:bold t))))
 '(evil-goggles-default-face ((t (:inherit region))))
 '(git-commit-summary ((t (:inherit rk-text :foreground nil :background nil))))
 '(helm-candidate-number ((t (:inherit rk-prompt))))
 '(helm-grep-file ((t (:inherit link :underline nil))))
 '(helm-grep-finish ((t (:inherit rk-prompt))))
 '(helm-grep-lineno ((t (:inherit rk-comment))))
 '(helm-match ((t (:inherit rk-match))))
 '(helm-match-item ((t (:inherit rk-match))))
 '(helm-selection ((t (:inherit rk-highlight-line))))
 '(helm-selection-line ((t (:inherit rk-highlight-line))))
 '(helm-source-header ((t (:inherit rk-modeline-inactive))))
 '(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
 '(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
 '(italic ((t (:underline nil :slant italic))))
 '(line-number-current-line ((t (:bold nil))))
 '(markdown-blockquote-face ((t (:inherit rk-text2))))
 '(markdown-code-face ((t (:inherit rk-text2 :foreground nil :background nil))))
 '(markdown-footnote-marker-face ((t (:inherit rk-comment :slant normal))))
 '(markdown-gfm-checkbox-face ((t (:inherit rk-text2))))
 '(markdown-header-delimiter-face ((t (:inherit rk-comment :foreground nil))))
 '(markdown-header-face-1 ((t (:inherit rk-header))))
 '(markdown-header-face-2 ((t (:inherit rk-header))))
 '(markdown-header-face-3 ((t (:inherit rk-header))))
 '(markdown-header-face-4 ((t (:inherit rk-header))))
 '(markdown-header-face-5 ((t (:inherit rk-header))))
 '(markdown-header-face-6 ((t (:inherit rk-header))))
 '(markdown-inline-code-face ((t (:inherit markdown-pre-face))))
 '(markdown-link-face ((t (:inherit rk-link))))
 '(markdown-list-face ((t (:inherit rk-text2))))
 '(markdown-markup-face ((t (:inherit rk-comment))))
 '(markdown-pre-face ((t (:inherit rk-text2))))
 '(markdown-url-face ((t (:inherit rk-comment))))
 '(nobreak-space ((t (:inherit rk-whitespace :background nil :underline nil))))
 '(region ((t (:background "#45475A"))))
 '(rk-bold ((t (:inherit rk-header))))
 '(rk-callout ((t (:background "#303030"))))
 '(rk-change ((t (:foreground "#3792E3"))))
 '(rk-change-highlight ((t (:background "#3792E3"))))
 '(rk-comment ((t (:foreground "#808080"))))
 '(rk-diff-add ((t (:inherit rk-success))))
 '(rk-diff-change ((t (:inherit rk-change))))
 '(rk-diff-remove ((t (:inherit rk-error :underline nil))))
 '(rk-error ((t (:foreground "#9D571A" :underline t))))
 '(rk-error-highlight ((t (:background "#9D571A"))))
 '(rk-header ((t (:foreground "#eeeeee" :bold t))))
 '(rk-highlight ((t (:background "#5f0087"))))
 '(rk-highlight-line ((t (:background "#3a3a3a"))))
 '(rk-italic ((t (:inherit rk-text :slant oblique))))
 '(rk-link ((t (:foreground "#87AFDF" :underline t))))
 '(rk-match ((t (:background "#5f0087"))))
 '(rk-modeline-active ((t (:foreground "#ffffff" :background "#808080"))))
 '(rk-modeline-inactive ((t (:foreground "#b2b2b2" :background "#4e4e4e"))))
 '(rk-none ((t (:foreground nil :background nil :bold nil :underline nil))))
 '(rk-popup-match ((t (:foreground "#87AFDF"))))
 '(rk-popup-selection ((t (:inherit rk-match))))
 '(rk-prompt ((t (:inherit rk-match :bold t))))
 '(rk-search ((t (:background "#822EB6" :foreground "#ffffff"))))
 '(rk-string ((t (:foreground "#75FF95"))))
 '(rk-success ((t (:foreground "#75FF95"))))
 '(rk-tag-active ((t (:inherit rk-modeline-active :bold t))))
 '(rk-tag-inactive ((t (:inherit rk-modeline-inactive :bold t))))
 '(rk-text ((t (:foreground "#eeeeee"))))
 '(rk-text2 ((t (:foreground "#b2b2b2"))))
 '(rk-warning ((t (:foreground "#E5E64B" :underline t))))
 '(rk-warning-highlight ((t (:background "#E5E64B" :foreground "#000000" :bold t))))
 '(rk-whitespace ((t (:inherit rk-highlight-line))))
 '(show-paren-match ((t (:underline t :background nil :foreground nil :bold nil))))
 '(show-paren-mismatch ((t (:inherit rk-error))))
 '(trailing-whitespace ((t (:inherit rk-whitespace))))
 '(whitespace-line ((t (:inherit rk-warning))))
 '(whitespace-space-after-tab ((t (:inherit rk-whitespace))))
 '(whitespace-space-before-tab ((t (:inherit rk-whitespace))))
 '(whitespace-tab ((t (:inherit rk-whitespace)))))
