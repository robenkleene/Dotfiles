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

(defun kill-line-grep ()
  "grep for current line."
  (interactive)
  (kill-new (get-line-grep)))

(defun get-line-grep ()
  "grep for current line."
  (interactive)
  (if buffer-file-name
      (let* (
             (path buffer-file-name)
             (home-path
              (replace-regexp-in-string
               (concat "^" (regexp-quote (expand-file-name "~")))
               "~"
               path)
              )
             (line-number (number-to-string (line-number-at-pos)))
             (command (concat home-path ":" line-number))
             )
        (message "%s" command)
        command
        )
    ))

(defun go-grep (entry)
  "Go to the line specified in a grep formatted `entry'."
  (interactive
   (list (read-from-minibuffer "Go grep: ")
         ))
  (let* ((regex "^\\([^:]+\\):\\([0-9]+\\):?\\([0-9]*\\)")
         match file line col)
    (when (string-match regex entry)
      (setq file (match-string 1 entry)
            line (string-to-number (match-string 2 entry))
            col (if (> (length (match-string 3 entry)) 0)
                    (string-to-number (match-string 3 entry))
                  1))
      (if (file-exists-p file)
          (progn
            (find-file-other-window file)
            (goto-line line)
            (move-to-column (1- col))) ; columns in Emacs are 0-indexed, adjusting here
        (message "File does not exist: %s" file))
      )
    (unless (string-match regex entry)
      (message "Error: Invalid format in kill ring entry. Expected '<filename>:<linenumber>[:<columnumber>]'."))
    )
  )

(defun eshell-other-window ()
  "Open eshell in other window."
  (interactive)
  (let ((buf (eshell "new")))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf))
  )

;;;###autoload
(defvar rk/grep-shell-command-history nil "History list for `grep-shell-command'.")
(defun grep-shell-command (command-args)
  "Create grep buffer from COMMAND-ARGS."
  (interactive
   (list (read-shell-command
          "Run grep shell command: "
          nil
          'rk/grep-shell-command-history)
         ))
  (compilation-start command-args 'grep-mode)
  )

;;;###autoload
(defvar rk/find-shell-command-dired-history nil "History list for `find-shell-command-dired'.")
(defun find-shell-command-dired (command)
  "Create dired buffer from COMMAND."
  (interactive
   (list (list (read-shell-command
                "Run find command: "
                nil
                'rk/find-shell-command-dired-history)
               )
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
   (list (read-shell-command
          (concat
           "Command ("
           (substring default-directory (max 0 (- (length default-directory) 40)))
           "): "
           )
          )
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

;;;###autoload
(defvar rk/rg-history nil "History list for z.")
(defun z (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: " nil nil nil 'rk/z-history)
         ))
  (let ((file (rk/z term)))
    (if (file-readable-p file)
        (find-file file)
      (message "No match found" file)
      )
    )
  )

(defun z-other-window (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: " nil nil nil 'rk/z-history)
         ))
  (rk/safe-find-file-other-window
   (rk/z term)
   )
  )

(defun z-other-tab (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: " nil nil nil 'rk/z-history)
         ))
  (rk/safe-find-file-other-tab
   (rk/z term)
   )
  )

(defun z-other-frame (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: " nil nil nil 'rk/z-history)
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
