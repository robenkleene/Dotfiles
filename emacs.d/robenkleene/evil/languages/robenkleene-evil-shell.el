;;; robenkleene-evil-shell.el --- robenkleene-evil-shell
;;; Commentary:
;;; Code:

(with-eval-after-load "sh-script"
  (add-hook 'sh-mode-hook (lambda ()
                            (let ((table (copy-syntax-table (syntax-table))))
                              (modify-syntax-entry ?- "w" table)
                              (modify-syntax-entry ?_ "w" table)
                              (set-syntax-table table)
                              )
                            )
            )
  )

(provide 'robenkleene-evil-shell)
;;; robenkleene-evil-shell.el ends here
