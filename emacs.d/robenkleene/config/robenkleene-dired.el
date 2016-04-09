;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Hide details (show them with "\("
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Auto-refresh on file system change
(add-hook 'dired-mode-hook 'auto-revert-mode)

(provide 'robenkleene-dired)
;;; robenkleene-dired.el ends here
