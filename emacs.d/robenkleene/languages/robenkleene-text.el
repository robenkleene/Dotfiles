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

  ;; Allow following paths grep line matches
  (define-key text-mode-map (kbd "C-x C-f") 'ffap)

  (define-key text-mode-map (kbd "C-c w g") 'kill-line-grep-dwim)
  (define-key text-mode-map (kbd "C-c w m")
              'kill-line-grep-markdown-dwim)

  ;; Set backtick as a string delimiter, this makes the `sexp' commands (like
  ;; `mark-sexp') work with backticks
  (modify-syntax-entry ?` "\"")
  ;; Set `"' as a string delimiter
  ;; This doesn't seem to be working? This might only work if a character pair
  ;; already defines a syntax?
  (modify-syntax-entry ?\" "\"")
  ;; Set `*' as a string delimiter
  (modify-syntax-entry ?* "\"")
  )

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
