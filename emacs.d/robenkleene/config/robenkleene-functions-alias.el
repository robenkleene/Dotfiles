;;; robenkleene-functions-alias.el --- robenkleene-functions-alias
;;; Commentary:
;;; Code:

(defun robenkleene/edit-init ()
  "Edit init."
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el")
  )

(defun robenkleene/source-control-open-web (&optional arg)
  "Open the source control website for the current repository with ARG."
  (interactive)
  (shell-command (concat "~/.bin/source_control_open_site "
                         arg)
                 )
  )

(provide 'robenkleene-functions-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions-alias.el ends here
