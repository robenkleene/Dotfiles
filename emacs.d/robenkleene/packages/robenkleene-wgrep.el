;;; robenkleene-wgrep.el --- robenkleene-wgrep
;;; Commentary:
;;; Code:

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :init
  (setq wgrep-auto-save-buffer t)
  (with-eval-after-load 'grep
    ;; Use same binding as `dired-toggle-read-only'
    (define-key grep-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))
  )

(provide 'robenkleene-wgrep)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-wgrep.el ends here
