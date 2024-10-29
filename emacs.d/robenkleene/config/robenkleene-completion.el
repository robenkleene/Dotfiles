;;; robenkleene-completion.el --- robenkleene-completion
;;; Commentary:
;;; Code:

;; Always show the completion buffer on first tab if there are multiple options
(setq completion-auto-help 'visible)

;; Show completion matches on second tab
(setq completion-auto-select 'second-tab)

;; Ignore case
(setq completion-ignore-case  t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;; In text and programming modes, use prefix completion which works more like
;; autocomplete
(add-hook 'text-mode-hook (lambda ()
                            (setq-local completion-styles '(partial-completion))
                            ))
(add-hook 'prog-mode-hook (lambda ()
                            (setq-local completion-styles '(partial-completion))
                            ))

(provide 'robenkleene-completion)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-completion.el ends here
