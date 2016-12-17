;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Load `C-x C-j' command for `dired-jump'
(require 'dired-x)

;; Hide details (show them with "\("
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Auto-refresh on file system change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; Suppress error message
(defvar dired-use-ls-dired)
(setq dired-use-ls-dired nil)

(provide 'robenkleene-dired)
;;; robenkleene-dired.el ends here
