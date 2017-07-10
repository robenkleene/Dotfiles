;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)


(use-package projectile
  :ensure t
  :bind (:map evil-motion-state-map
              ("M-e" . robenkleene/find-file-best-available)
              ("M-c" . projectile-find-dir)
              )
  :bind (:map robenkleene/leader-map
              ("f" . robenkleene/find-file-best-available)
              ("c" . projectile-find-dir)
              )
  :config
  (defun robenkleene/projectile-find-file-default-directory ()
    "Run `projectile-find-file' with `default-directory'."
    (interactive)
    (projectile-find-file-in-directory default-directory)
    )

  (defun robenkleene/find-file-best-available (&optional arg)
    "Run best available `find-file'."
    (interactive "P")
    (use-package projectile)
    (if (and (boundp 'projectile-project-root) projectile-project-root)
        (let ((current-prefix-arg nil))
          (if (equal arg nil)
              (projectile-find-file)
            (robenkleene/projectile-find-file-default-directory)
            )
          )
      (ido-find-file)
      )
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
