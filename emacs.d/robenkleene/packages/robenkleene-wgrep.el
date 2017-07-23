;;; robenkleene-wgrep.el --- robenkleene-wgrep
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :ensure t
  :init
  (setq wgrep-auto-save-buffer t)
  (with-eval-after-load "grep"
    (define-key grep-mode-map (kbd "C-c C-p") 'wgrep-change-to-wgrep-mode))
  )

(provide 'robenkleene-wgrep)
;;; robenkleene-wgrep.el ends here
