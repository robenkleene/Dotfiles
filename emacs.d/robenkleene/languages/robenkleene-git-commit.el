;;; robenkleene-git-commit.el --- robenkleene-git-commit
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package git-commit
  :mode "COMMIT_EDITMSG$"
  ;; (add-hook 'git-commit-mode-hook
  ;;           (lambda ()

  ;;             ))
  )

(provide 'robenkleene-git-commit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-git-commit.el ends here
