;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm-projectile
  :ensure t
  :commands (helm-projectile-find-file helm-projectile-ag projectile-project-p)
  :config
  (progn
    (helm-projectile-on)
    (use-package projectile
      :ensure t
      )
    )
  )

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
