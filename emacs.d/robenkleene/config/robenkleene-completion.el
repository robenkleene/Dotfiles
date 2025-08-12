;;; robenkleene-completion.el --- robenkleene-completion
;;; Commentary:
;;; Code:

;; Adding `substring' allows `C-x C-r' then, e.g., `<string>' to quickly open a
;; file with that string in it's name, otherwise, it needs to be `*<string>'
(setq completion-styles '(basic partial-completion substring))
;; Not sure why this doesn't work instead, for just adding `substring' to file
;; completion
;; (setq completion-category-overrides '((file (styles basic partial-completion substring))))

;; Allow using tab to complete if the line is already properly indented, this
;; makes completion feel more consistent with completion in the minibuffer
;; It's not worth it trying to get this to work, e.g., `text-mode', and any C
;; derivative mode won't work with this setting because they have unique tab
;; behavior. Instead just use `M-tab' which is always bound to
;; `completion-at-point'
;; (setq tab-always-indent 'complete)

;; Always show the completion buffer on first tab if there are multiple options
(setq completion-auto-help 'visible)

;; Show completion matches on second tab
(setq completion-auto-select 'second-tab)

;; Shows completions, use `C-j` to accept current match
;; (icomplete-mode)
;; (icomplete-vertical-mode)

;; Like `icomplete-mode', but `<return>` to accept current match, and `C-d` to
;; accept as typed.
;; (fido-mode)
;; (fido-vertical-mode)

(provide 'robenkleene-completion)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-completion.el ends here
