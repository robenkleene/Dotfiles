;;; robenkleene-git-gutter.el --- robenkleene-git-gutter
;;; Commentary:
;;; Code:


(require 'use-package)
(use-package git-gutter
  :config
  (global-git-gutter-mode t)
  )

(provide 'robenkleene-git-gutter)
;;; robenkleene-git-gutter.el ends here
