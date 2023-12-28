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
  (defalias 's 'magit-egit)
  :config
  ;; Refresh magit on file system changes (not this is only necessary for
  ;; changes *outside* Emacs, Magit can already refresh itself for change in
  ;; Magit.)
  ;; This can cause a "Too many open files" on macOS
  ;; https://github.com/ruediger/magit-filenotify/issues/17
  ;; (use-package magit-filenotify
  ;;   :commands (magit-filenotify-mode)
  ;;   :init
  ;;   (add-hook 'magit-status-mode-hook 'magit-filenotify-mode))

  ;; Jump to the start of the first section in "magit-status-mode" buffers
  ;; (add-hook 'magit-refresh-buffer-hook
  ;;           (lambda ()
  ;;             (if (and (bobp)
  ;;                      (string-equal major-mode "magit-status-mode"))
  ;;                 (progn
  ;;                   (magit-section-forward-sibling)
  ;;                   ;; Not sure why this doesn't work
  ;;                   (magit-next-line)
  ;;                   )
  ;;               )
  ;;             )
  ;;           )

  ;; Open magit status full screen
  ;; (setq magit-display-buffer-function
  ;;       #'magit-display-buffer-fullframe-status-v1)

  ;; Show word diffs
  (setq magit-diff-refine-hunk t)
  ;; Refresh magit status after editing a buffer
  ;; This makes the cursor jump after saving, might be able to try
  ;; again later
  ;; Replicate by jumping to a file, editing it, then returning to
  ;; `magit-status', the cursor will go back to the beginning of the file.
  ;; (add-hook 'after-save-hook 'magit-after-save-refresh-status t)

  (defun magit-egit ()
    "`egit' `magit'"
    (interactive)
    (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
        (progn
          (async-shell-command "~/.bin/sgitt_auto" "*egit*" "*egit*")
          ;; (switch-to-buffer-other-window "*egit save*")
          ;; (view-mode)
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

  (defun rk/magit-status-startup ()
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
