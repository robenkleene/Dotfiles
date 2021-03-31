;;; robenkleene-diff-hl.el --- robenkleene-diff-hl
;;; Commentary:
;;; Code:

(use-package diff-hl
  :commands (global-diff-hl-mode)
  :ensure t
  :init
  (global-diff-hl-mode)
  (add-hook 'diff-hl-mode-on-hook
            (lambda ()
              (unless (window-system)
                (diff-hl-margin-mode)))))

(provide 'robenkleene-diff-hl)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-diff-hl.el ends here
