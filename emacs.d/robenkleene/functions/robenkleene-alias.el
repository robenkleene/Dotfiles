;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defalias 'pull 'rk/egit-update)
(defalias 'sh 'buffer-shell-command)

(defun rk/egit-update (&optional arg)
  "Run update."
  (interactive)
  (async-shell-command "~/.bin/egit_update" "*egit*" "*egit*")
  )

(defun rk/git-pull-all-text (&optional arg)
  "Pull all text."
  (interactive)
  (async-shell-command "~/.bin/git_pull_all -t" "*egit*" "*egit*")
  )

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
