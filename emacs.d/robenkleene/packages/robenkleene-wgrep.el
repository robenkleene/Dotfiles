;;; robenkleene-wgrep.el --- robenkleene-wgrep
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :init
  (setq wgrep-auto-save-buffer t)
  (with-eval-after-load "grep"
    (define-key grep-mode-map (kbd "C-c C-p") 'wgrep-change-to-wgrep-mode))
  )

(provide 'robenkleene-wgrep)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-wgrep.el ends here
