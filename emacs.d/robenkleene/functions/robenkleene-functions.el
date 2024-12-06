;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun rk/z-add ()
  "Add file or directory."
  (interactive)
  (if (executable-find "zoxide")
      (let ((file default-directory))
        (when (and file
                   (stringp file)
                   (file-readable-p file))
          (start-process "*z add*"
                         nil
                         "zoxide"
                         "add"
                         (expand-file-name file)
                         )))))

(defun rk/z (term)
  "Z directory."
  (shell-command-to-string (concat "zoxide query "
                                   term
                                   " | tr -d '\n'")
                           )
  )

(defun rk/safe-find-file (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file file))
  )

(defun rk/safe-find-file-other-window (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file-other-window file))
  )

(defun rk/safe-find-file-other-tab (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file-other-tab file))
  )

(defun rk/safe-find-file-other-frame (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file-other-frame file))
  )

;; Notes
(defun rk/notes-create-buffer (buffer-name &optional initial)
  "Return a new empty notes buffer in the other window."
  (let*
      ((default-directory (concat user-emacs-directory "notes.d"))
       (buffer (generate-new-buffer buffer-name))
       )
    (if (file-exists-p default-directory)
        (if (not (file-directory-p default-directory))
            (progn
              (error "Error: %s exists and is not a directory." default-directory))
          )
      (make-directory default-directory t))
    (set-buffer buffer)
    (when initial (insert initial))
    (auto-save-mode)
    buffer
    )
  )

(provide 'robenkleene-functions)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions.el ends here
