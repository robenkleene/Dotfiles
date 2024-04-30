;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(use-package magit
  :commands (
             rk/magit-status-startup
             magit-egit
             magit-status
             magit-log-current
             )
  :bind (:map magit-file-section-map
              ("RET" . magit-diff-visit-file-other-window)
              :map magit-hunk-section-map
              ("RET" . magit-diff-visit-file-other-window))
  :init
  (defalias 'upush 'magit-egit)
  :config
  ;; Show word diffs
  (setq magit-diff-refine-hunk t)

  (defun magit-egit ()
    "`egit' `magit'"
    (interactive)
    (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
        (progn
          (async-shell-command "~/.bin/sgitt_auto" "*egit*" "*egit*")
          (with-current-buffer "*egit*"
            (view-mode))
          )
      (let ((default-directory (shell-command-to-string "~/.bin/egit -n | tr -d '\n'")))
        (magit-status)
        )
      )
    )

  )

(provide 'robenkleene-magit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-magit.el ends here
