;;; robenkleene-diff.el --- robenkleene-diff
;;; Commentary:
;;; Code:

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "RET") 'diff-goto-source)
  )

(add-hook 'diff-mode-hook
          (lambda ()
            (read-only-mode)
            )
          )

(provide 'robenkleene-diff)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-diff.el ends here
