;;; robenkleene-fasd.el --- robenkleene-fasd
;;; Commentary:
;;; Code:

(defun robenkleene/fasd-add ()
  "Add file or directory `fasd'."
  (if (executable-find "fasd")
      (let ((file (if (string= major-mode "dired-mode")
                      dired-directory
                    (buffer-file-name))))
        (when (and file
                   (stringp file)
                   (file-readable-p file))
          (start-process "*fasd*" nil "fasd" "--add" file)))))

(add-hook 'find-file-hook 'robenkleene/fasd-add)
(add-hook 'dired-mode-hook 'robenkleene/fasd-add)

(provide 'robenkleene-fasd)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-fasd.el ends here
