;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package magit
  :ensure t
  :commands (rk-magit-status-startup)
  :bind (
         ("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)
         )
  :config
  (progn
    (setq magit-push-always-verify nil)
    ;; Magit Startup Helpers
    (defun rk-magit-status-current-window ()  "Magit in current window."  (interactive) (progn (call-interactively
                                                                                                'magit-status) (delete-other-windows)))
    (defun
        rk-focus-selected-frame () "Focus on current frame."
        (select-frame-set-input-focus (selected-frame))
        )
    (defun
        rk-magit-status-startup () "Startup magit full frame with focus."
        (progn
          (rk-magit-status-current-window)
          (rk-magit-focus-selected-frame))
        )
    )
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
