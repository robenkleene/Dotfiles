;;; robenkleene-editorconfig.el --- robenkleene-editorconfig
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package editorconfig
  :diminish
  :config
  (add-to-list 'editorconfig-indentation-alist '(markdown-mode markdown-list-indent-width))
  (editorconfig-mode 1)
  )

(provide 'robenkleene-editorconfig)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-editorconfig.el ends here
