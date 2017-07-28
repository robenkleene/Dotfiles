;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package magit
  :commands (robenkleene/magit-status-startup)
  :bind (:map robenkleene/leader-map
              ("gs" . magit-status)
              )
  :config
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
