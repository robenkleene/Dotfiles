;;; robenkleene-remember.el --- robenkleene-remember
;;; Commentary:
;;; Code:

;; Don't add the current buffer file name to the file
(setq remember-annotation-functions nil)

(add-hook 'remember-mode-hook
          (lambda ()
            ;; Set backtick as a string delimiter, this makes the `sexp'
            ;; commands (like `mark-sexp') work with backticks
            (modify-syntax-entry ?` "\"")
            ;; Set `"' as a string delimiter
            (modify-syntax-entry ?\" "\"")
            ;; Set `*' as a string delimiter
            (modify-syntax-entry ?* "\"")
            )
          )

(provide 'robenkleene-remember)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-remember.el ends here
