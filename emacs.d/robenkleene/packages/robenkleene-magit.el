;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package magit
  :commands (robenkleene/magit-status-startup magit-status magit-log-current)
  :bind
  (:map robenkleene/leader-map
        ("m s" . magit-status)
        ("m l" . magit-log-current)
        ("m f" . magit-log-buffer-file)
        )
  :init
  (defalias 'ms 'magit-status)
  (defalias 'ml 'magit-log-current)  
  (defalias 'mf 'magit-log-buffer-file)  
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
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

  ;; Show word diffs
  (setq magit-diff-refine-hunk t)
  ;; Refresh magit status after editing a buffer
  (add-hook 'after-save-hook 'magit-after-save-refresh-status)
  ;; Magit Startup Helpers
  (defun robenkleene/magit-status-current-window ()
    "Magit in current window."
    (interactive)
    (progn (call-interactively 'magit-status)
           (delete-other-windows))
    )
  (defun robenkleene/magit-focus-selected-frame ()
    "Focus on current frame."
    (select-frame-set-input-focus (selected-frame))
    )
  (defun robenkleene/magit-status-startup ()
    "Startup magit full frame with focus."
    (interactive)
    (progn
      (robenkleene/magit-status-current-window)
      (robenkleene/magit-focus-selected-frame))
    )
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
