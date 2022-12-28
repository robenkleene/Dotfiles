;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package magit
  :commands (
             robenkleene/magit-egit
             magit-status
             magit-log-current
             )
  :init
  (defalias 'ms 'magit-status)
  (defalias 'ml 'magit-log-current)
  (defalias 's 'robenkleene/magit-egit)
  :config
  ;; Refresh magit on file system changes
  ;; This can cause a "Too many open files" on macOS
  ;; https://github.com/ruediger/magit-filenotify/issues/17
  ;; (use-package magit-filenotify
  ;;   :commands (magit-filenotify-mode)
  ;;   :init
  ;;   (add-hook 'magit-status-mode-hook 'magit-filenotify-mode))

  ;; Jump to the start of the first section in "magit-status-mode" buffers
  (add-hook 'magit-refresh-buffer-hook
            (lambda ()
              (if (and (bobp)
                       (string-equal major-mode "magit-status-mode"))
                  (magit-section-forward-sibling)
                )
              )
            )

  ;; Open magit status full screen
  ;; (setq magit-display-buffer-function
  ;;       #'magit-display-buffer-fullframe-status-v1)

  ;; Show word diffs
  (setq magit-diff-refine-hunk t)
  ;; Refresh magit status after editing a buffer
  ;; This makes the cursor sometimes jump after saving, might be able to try
  ;; again later
  ;; (add-hook 'after-save-hook 'magit-after-save-refresh-status)

  (defun robenkleene/magit-egit ()
    "`egit' `magit'"
    (interactive)
    (unless (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
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
