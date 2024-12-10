;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(use-package magit
  :commands magit-status
  :init
  (defalias 'rk-push 'magit-egit)
  (defun magit-egit ()
    "`egit' `magit'"
    (interactive)
    (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
        (progn
          (async-shell-command "~/.bin/sgitt_auto" "*egit*" "*egit*")
          (with-current-buffer "*egit*"
            (viewmode))
          )
      (let ((default-directory
             (shell-command-to-string "~/.bin/egit -n | tr -d '\n'")))
        (magit-status)
        )
      )
    )
  )

(provide 'robenkleene-magit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-magit.el ends here
