;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package magit
  :bind
  ("C-c s" . magit-egit)
  :commands (
             magit-status-startup
             magit-egit
             magit-status
             magit-log-current
             )
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

  (defun magit-egit ()
    "`egit' `magit'"
    (interactive)
    (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
        (progn
          (async-shell-command "~/.bin/sgitt_auto" "*egit save*" "*egit save*")
          ;; (switch-to-buffer-other-window "*egit save*")
          (view-mode)
          )
      (let ((default-directory (shell-command-to-string "~/.bin/egit -n | tr -d '\n'")))
        (magit-status)
        )
      )
    )

  ;; Magit Startup Helpers
  (defun rk/magit-status-current-window ()
    "Magit in current window."
    (interactive)
    (progn (call-interactively 'magit-status)
           (delete-other-windows))
    )

  (defun rk/magit-focus-selected-frame ()
    "Focus on current frame."
    (select-frame-set-input-focus (selected-frame))
    )

  (defun magit-status-startup ()
    "Startup magit full frame with focus."
    (interactive)
    (progn
      (rk/magit-status-current-window)
      (rk/magit-focus-selected-frame))
    )

  )

(provide 'robenkleene-magit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-magit.el ends here
