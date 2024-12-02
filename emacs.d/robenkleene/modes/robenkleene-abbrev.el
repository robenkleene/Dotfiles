;;; robenkleene-abbrev.el --- robenkleene-abbrev
;;; Commentary:
;;; Code:

(add-hook 'minibuffer-setup-hook 'abbrev-mode)

(define-abbrev global-abbrev-table ":today:"
  ""
  (lambda () (insert (format-time-string "%Y-%m-%d"))))

;; Allow abbreviations with other characters
(abbrev-table-put
 global-abbrev-table
 :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[:_].*\\|.*\\)")

(provide 'robenkleene-abbrev)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-abbrev.el ends here
