;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

(with-eval-after-load 'text-mode
  ;; Add characters to wrap on (in particular this helps URLs wrap more naturally)
  (setq rk/text-category-table (copy-category-table))
  (modify-category-entry ?- ?| rk/text-category-table)
  (modify-category-entry ?/ ?| rk/text-category-table)
  (modify-category-entry ?_ ?| rk/text-category-table)
  (add-hook 'text-mode-hook (lambda ()
                              ;; Wrap in text modes
                              (set 'truncate-lines nil)
                              (set-category-table rk/text-category-table)
                              (setq-local word-wrap-by-category t)
                              ;; Show trailing whitespace
                              (setq-local show-trailing-whitespace t)
                              ;; Show tabs
                              (whitespace-mode)
                              ))

  ;; Allow following grep line matches
  (define-key prog-mode-map (kbd "C-x C-f") 'ffap)

  ;; Set backtick as a string delimiter, this makes the `sexp' commands (like
  ;; `mark-sexp') work with backticks
  (modify-syntax-entry ?` "\"")
  ;; Set `"' as a string delimiter
  (modify-syntax-entry ?\" "\"")
  ;; Set `*' as a string delimiter
  (modify-syntax-entry ?* "\"")
  )

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
