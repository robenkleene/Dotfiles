;;; robenkleene-git-gutter.el --- robenkleene-git-gutter
;;; Commentary:
;;; Code:


(require 'use-package)
(use-package git-gutter
  :ensure t
  :config
  (progn
    (global-git-gutter-mode +1)
    (custom-set-faces
     `(git-gutter:modified ((t (:inherit diff-changed))))
     )
    )
  )

(provide 'robenkleene-git-gutter)
;;; robenkleene-git-gutter.el ends here
