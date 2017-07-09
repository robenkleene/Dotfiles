;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)


(use-package projectile
  :ensure t
  :bind (:map evil-motion-state-map
              ("M-e" . projectile-find-file)
              ("M-c" . projectile-find-dir)
              )
  :bind (:map robenkleene/leader-map
              ("f" . projectile-find-file)
              ("c" . projectile-find-dir)
              )
  :bind (:map robenkleene/relative-map
              ("a" . robenkleene/projectile-find-file-default-directory)
              )
  :config
  (defun robenkleene/projectile-find-file-default-directory ()
    "Run `projectile-find-file' with `default-directory'."
    (interactive)
    (projectile-find-file-in-directory default-directory)
    )


  
  ;; `helm-projectile-ag' should do project level `rg' by default, but it isn't
  ;; compatible with `rg', so instead this is currently done with a function
  ;; using `helm-do-ag' with `projectile-project-root'
  ;; :init
  ;; (use-package helm-projectile
  ;;   :ensure t
  ;;   :bind (:map robenkleene/leader-map
  ;;               ("a" . helm-projectile-ag)
  ;;               )
  ;;   )
  )

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
