;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))


(use-package projectile
  :commands (robenkleene/projectile-go-to-root)
  :init
  (defalias 'gcd 'robenkleene/projectile-go-to-root)
  :bind
  ;; For some reason this isn't working
  ;; ("M-e". robenkleene/find-file-directory)
  ("M-c". projectile-find-dir)
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

  (defun robenkleene/projectile-find-file-default-directory ()
    "Run `projectile-find-file' with `default-directory'."
    (interactive)
    (projectile-find-file-in-directory default-directory)
    )

  (defun robenkleene/find-file-directory (dir)
    "Call `find-file' in the current directory or with prefix specify a directory."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        default-directory)))
    (let ((current-prefix-arg nil))
      (projectile-find-file-in-directory dir)
      )
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

  )

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
