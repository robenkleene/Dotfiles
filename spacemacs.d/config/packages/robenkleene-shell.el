;;; robenkleene-shell.el --- robenkleene-shell
;;; Commentary:
;;; Code:

(eval-after-load 'shell
  '(progn
     (defvar comint-preoutput-filter-functions)
     (add-to-list 'comint-preoutput-filter-functions
                  (lambda (output)
                    (replace-regexp-in-string "\\[[0-9]+[GK]" "" output)))
     )
  )

(provide 'robenkleene-shell)
;;; robenkleene-shell.el ends here
