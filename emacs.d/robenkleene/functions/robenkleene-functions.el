;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun today (&optional arg)
  "Return the current date."
  (interactive)
  (shell-command-to-string "date +%Y-%m-%d | tr -d '\n'")
  )

(defun grep-line ()
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

;; For use in functions

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

(provide 'robenkleene-functions)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions.el ends here
