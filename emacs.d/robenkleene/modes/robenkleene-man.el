;;; robenkleene-man.el --- robenkleene-man
;;; Commentary:
;;; Code:

;; Advise `man' using a function that does completion using filenames from
;; `MANPATH'. The built-in completion is slow and doesn't support all `MANPATH'
;; locations.
;;;###autoload
(defvar rk/man-history nil "History list for `man'.")
(defadvice man (around rk/man-interactive activate)
  (interactive (list (let* ((manpath (getenv "MANPATH"))
                            (man-dirs (delete-dups (split-string manpath ":" t)))
                            (files (mapcan (lambda (dir)
                                             (when (file-exists-p dir)
                                               (mapcar #'file-name-base
                                                       (directory-files-recursively dir ""))))
                                           man-dirs))
                            )
                       (completing-read "man: " files rk/man-history t)
                       )))
  ad-do-it)

(provide 'robenkleene-man)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-man.el ends here