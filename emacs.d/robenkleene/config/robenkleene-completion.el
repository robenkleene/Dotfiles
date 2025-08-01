;;; robenkleene-completion.el --- robenkleene-completion
;;; Commentary:
;;; Code:

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

(icomplete-vertical-mode)

(provide 'robenkleene-completion)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-completion.el ends here
