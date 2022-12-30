;;; robenkleene-git-commit.el --- robenkleene-git-commit
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
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
