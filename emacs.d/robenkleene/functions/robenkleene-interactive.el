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


;;;###autoload
(defvar rk/rg-history nil "History list for rg.")

(defun rg (command-args)
  "Create grep buffer for rg from COMMAND-ARGS."
  (interactive
   (list (read-shell-command
          "Run rg (like this): "
          "rg "
          'rg-history)
         ))
  (grep-shell-command command-args)
  )

(defun fd (terms)
  "Create dired buffer from `fd' TERMS."
  (interactive
   (list (read-from-minibuffer "Fd: ")
         ))
  (find-shell-command-dired (concat "fd " terms))
  )

(defun grep-shell-command (command)
  "Create grep buffer from COMMAND."
  (interactive
   (list (read-from-minibuffer "Grep Command: ")
         ))
  (require 'grep)
  (compilation-start command 'grep-mode)
  )

(defun find-shell-command-dired (command)
  "Create dired buffer from COMMAND."
  (interactive
   (list (read-from-minibuffer "Find Command: ")
         ))
  (let* ((output-buffer "*Find Shell Command*"))
    (if (get-buffer output-buffer)
        (progn
          (let ((proc (get-buffer-process output-buffer)))
            (when proc
              (delete-process proc)))
          (kill-buffer output-buffer)
          )
      )
    (let ((process (start-process-shell-command "async-command" output-buffer (concat command " | tr \\\\n \\\\0 | xargs -0 ls -l"))))
      (set-process-sentinel process
                            (lambda (proc event)
                              (when (string-match-p "finished" event)
                                (with-current-buffer (process-buffer proc)
                                  (require 'ansi-color)
                                  (ansi-color-apply-on-region (point-min) (point-max))
                                  (require 'dired-x)
                                  (dired-virtual default-directory)
                                  ;; Go to first file
                                  (beginning-of-buffer)
                                  (dired-next-line 1)
                                  )
                                ;; (display-buffer (process-buffer proc))
                                (switch-to-buffer-other-window (process-buffer proc))
                                ))))))

(defun buffer-shell-command (command)
  "Create buffer from COMMAND."
  (interactive
   (list (read-from-minibuffer "Command: ")
         ))
  (let* ((output-buffer "*Buffer Shell Command*"))
    (if (get-buffer output-buffer)
        (kill-buffer output-buffer))
    (let ((process (start-process-shell-command "async-command"
                                                output-buffer
                                                ;; Pipe the command through
                                                ;; `cat' which helps with
                                                ;; compatibility (e.g.,
                                                ;; disabling pagers)
                                                (concat command "| cat"))))
      (set-process-sentinel process
                            (lambda (proc event)
                              (when (string-match-p "finished" event)
                                (with-current-buffer (process-buffer proc)
                                  (set-auto-mode)
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
