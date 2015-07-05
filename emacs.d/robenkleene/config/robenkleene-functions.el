;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun robenkleene/system-is-mac ()
  "Test if this is a Mac."
  (string-equal system-type "darwin"))

(defun robenkleene/open-terminal-window ()
  "Open a new Terminal window at the current path."
  (interactive)
  (shell-command "open -a Terminal .")
  )

(defun robenkleene/reveal-in-finder ()
  "Open a new Finder window at the current path."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -R "
                             (shell-quote-argument buffer-file-name))
                     )
    (shell-command "open .")
    )
  )

(defun robenkleene/external-editor ()
  "Open a region or file in external editor."
  (interactive)
  (if (mark)
      (shell-command-on-region (point-min) (point-max) "mate -a")
    (if (buffer-file-name)
        (shell-command (concat "mate -a "
                               (shell-quote-argument buffer-file-name))
                       )
      )
    )
  )

(declare-function projectile-project-p "projectile")
(defun robenkleene/best-ag ()
  "Best ag search."
  (interactive)
  (if (projectile-project-p)
      (call-interactively 'helm-projectile-ag)
    (call-interactively 'helm-do-ag))
  )

(defun robenkleene/best-find-file ()
  "Best find file."
  (interactive)
  (if (projectile-project-p)
      (call-interactively 'helm-projectile-find-file)
    (call-interactively 'helm-find-files))
  )


(defun robenkleene/other-window-shell ()
  "Open shell in other window."
  (interactive)
  (switch-to-buffer-other-window "*shell*")
  (shell))

(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here
