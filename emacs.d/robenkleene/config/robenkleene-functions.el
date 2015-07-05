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

(defun robenkleene/open-finder-window ()
  "Open a new Finder window at the current path."
  (interactive)
  (shell-command "open .")
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


(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here


