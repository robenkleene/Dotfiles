;;; robenkleene-interactive.el --- robenkleene-interactive.el
;;; Commentary:
;;; Code:

(defun get-today (&optional arg)
  "Return the current date."
  (interactive)
  (let ((result (shell-command-to-string "date +%F | tr -d '\n'")))
    (message "%s" result)
    result
    )
  )

(defun get-line-grep ()
  "grep for current line."
  (interactive)
  (if buffer-file-name
      (let* (
             (path buffer-file-name)
             (line-number (number-to-string (line-number-at-pos)))
             (command (concat path ":" line-number))
             )
        (message "%s" command)
        command
        )
    ))

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
  (let* ((output-buffer "*Diff Shell Command*"))
    (if (get-buffer output-buffer)
        (kill-buffer output-buffer))
    (let ((process (start-process-shell-command "async-command" output-buffer command)))
      (set-process-sentinel process
                            (lambda (proc event)
                              (when (string-match-p "finished" event)
                                (with-current-buffer (process-buffer proc)
                                  (diff-mode)
                                  (view-mode)
                                  (beginning-of-buffer))
                                (display-buffer (process-buffer proc)))))))
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
