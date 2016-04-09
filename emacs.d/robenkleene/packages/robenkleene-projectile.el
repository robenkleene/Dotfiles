;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package projectile
  :ensure t
  :commands projectile-find-file-in-directory
  :init
  (bind-key "C-c f" (lambda () (interactive)
                      (projectile-find-file-in-directory default-directory)))
  
  )



(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
