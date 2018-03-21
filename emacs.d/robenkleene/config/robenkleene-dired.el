;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Load `C-x C-j' command for `dired-jump'
(require 'dired-x)

;; Hide details (show them with "\("
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; Auto-refresh on file system change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; Hack to allow `SPC' to work as leader in Dired buffers
(define-key dired-mode-map (kbd "SPC") nil)

;; Omit hidden files
(require 'dired-x)
(setq-default dired-omit-mode t)
(setq-default dired-omit-files
              (concat dired-omit-files "\\|^\\..+$"))

;; Suppress error message
(defvar dired-use-ls-dired)
(setq dired-use-ls-dired nil)

(provide 'robenkleene-dired)
;;; robenkleene-dired.el ends here
