;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))


(use-package projectile
  :commands (robenkleene/rg-best-available robenkleene/projectile-go-to-root)
  :init
  (defalias 'rg 'robenkleene/rg-best-available)
  (defalias 'gcd 'robenkleene/projectile-go-to-root)
  :bind (:map evil-motion-state-map
              ("M-e" . robenkleene/find-file-best-available)
              ("M-c" . projectile-find-dir)
              )
  :bind (:map robenkleene/leader-map
              ("*" . robenkleene/rg-selection-best-available)
              ("f" . robenkleene/find-file-best-available)
              ("c" . projectile-find-dir)
              )
  :config

  (defun robenkleene/projectile-go-to-root ()
    "Go to the root of the project in a `dired' buffer."
    (interactive)
    (let ((project-root (robenkleene/projectile-safe-project-root)))
      (if (equal project-root nil)
          (message "Not in a project.")
        (dired project-root)
        )
      )
    )

  (defun robenkleene/projectile-safe-project-root ()
    "Return project's root, or nil if not in a project."
    (and (fboundp 'projectile-project-root)
         (projectile-project-p)
         (projectile-project-root))
    )

  (defun robenkleene/project-root-or-default-directory ()
    "Return the project's root, or default directory if not in a project."
    (or (robenkleene/projectile-safe-project-root) default-directory)
    )
  
  (defun robenkleene/projectile-find-file-default-directory ()
    "Run `projectile-find-file' with `default-directory'."
    (interactive)
    (projectile-find-file-in-directory default-directory)
    )

  (defun robenkleene/find-file-best-available (&optional arg)
    "Run best available `find-file'."
    (interactive "P")
    (require 'projectile)
    (let ((project-root (robenkleene/projectile-safe-project-root)))
      (if (equal project-root nil)
          (ido-find-file)
        (let ((current-prefix-arg nil))
          (if (equal arg nil)
              (projectile-find-file)
            (robenkleene/projectile-find-file-default-directory)
            )
          )
        )
      )
    )

  (defun robenkleene/rg-selection-best-available (&optional arg)
    "Call from project root, or current directory if unavailable."
    (interactive)
    (apply 'robenkleene/rg
           (robenkleene/grep-parameters (robenkleene/selection-or-word)
                                        nil
                                        (robenkleene/project-root-or-default-directory))
           ))

  (defun robenkleene/rg-best-available ()
    "Call from project root, or current directory if unavailable."
    (interactive)
    (apply 'robenkleene/rg
           (robenkleene/grep-parameters nil
                                        nil
                                        (robenkleene/project-root-or-default-directory))
           )
    )
  
  ;; `helm-projectile-ag' should do project level `rg' by default, but it isn't
  ;; compatible with `rg', so instead this is currently done with a function
  ;; using `helm-do-ag' with `projectile-project-root'
  ;; :init
  ;; (use-package helm-projectile
  ;;   :bind (:map robenkleene/leader-map
  ;;               ("a" . helm-projectile-ag)
  ;;               )
  ;;   )
  )

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
