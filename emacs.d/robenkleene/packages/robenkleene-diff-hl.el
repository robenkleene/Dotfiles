;;; robenkleene-diff-hl.el --- robenkleene-diff-hl
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode)
  (setq diff-hl-margin-mode t)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  )

(provide 'robenkleene-diff-hl)
;;; robenkleene-diff-hl.el ends here
