;;; robenkleene-interactive.el --- robenkleene-interactive.el
;;; Commentary:
;;; Code:

;; Live

(defun eshell-other-window ()
  "Open eshell in other window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf))
  )

(defun grep-shell-command (command)
  "Create grep buffer from COMMAND."
  (interactive
   (list (read-from-minibuffer "Grep: ")
         ))
  (require 'grep)
  (compilation-start command 'grep-mode)
  )

(defun diff-shell-command (command)
  "Create diff buffer from COMMAND."
  (interactive
   (list (read-from-minibuffer "Diff: ")
         ))
  (async-shell-command command "*diff shell command*" "*diff shell command*")
  (switch-to-buffer
   "*diff shell command*")
  (diff-mode)
  (beginning-of-buffer)
  )

(defun z (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file
   (rk/z term)
   )
  )

(defun z-other-window (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-window
   (rk/z term)
   )
  )

(defun z-other-tab (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-tab
   (rk/z term)
   )
  )

(defun z-other-frame (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-frame
   (rk/z term)
   )
  )

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
