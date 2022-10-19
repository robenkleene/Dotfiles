;;; robenkleene-git-commit.el --- robenkleene-git-commit
;;; Commentary:
;;; Code:

(use-package git-commit
  :ensure t
  :config
  (add-hook 'git-commit-mode-hook
            (lambda ()
              (when (boundp 'whitespace-style)
                (setq-local whitespace-style (add-to-list 'lines-tail
                                                          whitespace-style)))
              ))
  )

(provide 'robenkleene-git-commit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-git-commit.el ends here
