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


(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here


