;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defun rk/edit-init ()
  "Edit init."
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el")
  )

(defun rk/source-control-open-web (&optional arg)
  "Open the source control website for the current repository with ARG."
  (interactive)
  (shell-command (concat "~/.bin/source_control_open_site "
                         arg)
                 )
  )

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
