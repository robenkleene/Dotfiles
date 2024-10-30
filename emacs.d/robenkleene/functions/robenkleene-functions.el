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

(defun rk/message-off-advice (oldfun &rest args)
  "Quiet down messages in adviced OLDFUN."
  (let ((message-off (make-symbol "message-off")))
    (unwind-protect
        (progn
          (advice-add #'message :around #'ignore (list 'name message-off))
          (apply oldfun args))
      (advice-remove #'message message-off))))

(provide 'robenkleene-functions)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions.el ends here
