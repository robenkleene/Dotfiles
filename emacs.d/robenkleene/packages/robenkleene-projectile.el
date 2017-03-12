;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)


(use-package projectile
  :ensure t
  :init
  (use-package helm-projectile
    :ensure t
    :bind (
           ("C-c f" . helm-projectile-find-file)
           )
    )
  )

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
