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

(defun grep-shell-command (command-args)
  "Create grep buffer from COMMAND-ARGS."
  (interactive
   (list (read-shell-command
          "Run grep command: "
          ;; "rg "
          ""
          'grep-history)
         ))
  (compilation-start command-args 'grep-mode)
  )

(defun find-shell-command (command-args)
  "Create grep buffer from COMMAND-ARGS."
  (interactive
   (list (read-shell-command
          "Run find command: "
          ;; "fd -l "
          ""
          'find-command-history)
         ))
  (let ((process-environment (copy-sequence process-environment)))
    ;; `fd' won't use colors, which interfere with `dired-mode' if `NO_COLOR' is
    ;; set
    (setenv "NO_COLOR" "1")
    (find-dired-with-command default-directory command-args)
    )
  )

;;;###autoload
(defvar rk/z-history nil "History list for z.")
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

(defun rk/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

;; Notes
(defun notes-find-file ()
  "Calls `find-file' starting from the notes directory."
  (interactive)
  (let
      ;; `notes' filename is used by `remember-mode' notes
      ((default-directory (concat user-emacs-directory "notes.d/")))
    (if (file-exists-p default-directory)
        (if (not (file-directory-p default-directory))
            (progn
              (error "Error: %s exists and is not a directory." default-directory))
          )
      (make-directory default-directory t))
    (call-interactively 'find-file)
    )
  )

(defun notes-find-file-other-window ()
  "Calls `find-file' starting from the notes direction in other window."
  (interactive)
  (let
      ;; `notes' filename is used by `remember-mode' notes
      ((default-directory (concat user-emacs-directory "notes.d/")))
    (if (file-exists-p default-directory)
        (if (not (file-directory-p default-directory))
            (progn
              (error "Error: %s exists and is not a directory." default-directory))
          )
      (make-directory default-directory t))
    (call-interactively 'find-file-other-window)
    )
  )

(defun kill-missing-file-buffers ()
  "Kills unmodified buffers with a filename if the file no longer exists, and
Dired buffers that no longer exist."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      (if (and filename
               (not (buffer-modified-p buf)))
          (if (not (file-readable-p filename))
              (let (kill-buffer-query-functions)
                (kill-buffer buf)
                (message "Killed missing buffer %s" filename))
            )
        (with-current-buffer buf
          (when (eq major-mode 'dired-mode)
            (let ((dir (dired-current-directory)))
              (when (not (file-directory-p dir))
                (kill-buffer buf)
                (message "Killed missing Dired buffer %s" dir))
              )
            )
          )
        )
      )
    ))

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
