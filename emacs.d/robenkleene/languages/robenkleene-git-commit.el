;;; robenkleene-git-commit.el --- robenkleene-git-commit
;;; Commentary:
;;; Code:

(use-package git-commit
  :ensure t
  :config
  (add-hook 'git-commit-mode-hook
            (lambda ()
              (when (boundp 'whitespace-style)
                (whitespace-mode 0)
                (setq-local whitespace-style (push 'lines-tail
                                                   whitespace-style))
                (whitespace-mode 1)
                )
              ))
  )

(provide 'robenkleene-git-commit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-git-commit.el ends here
