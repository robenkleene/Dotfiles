;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Hide details (show them with "\("
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Evil Mode is managing hl-line state
;; (add-hook 'dired-mode-hook '(lambda () (setq global-hl-line-mode t)))

;; Suppress error message
(defvar dired-use-ls-dired)
(setq dired-use-ls-dired nil)


(provide 'robenkleene-dired)
;;; robenkleene-dired.el ends here
