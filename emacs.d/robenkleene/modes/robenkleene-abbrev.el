;;; robenkleene-abbrev.el --- robenkleene-abbrev
;;; Commentary:
;;; Code:

(add-hook 'text-mode-hook 'abbrev-mode)
(add-hook 'prog-mode-hook 'abbrev-mode)
(add-hook 'minibuffer-setup-hook 'abbrev-mode)

(define-abbrev global-abbrev-table "rkdt"
  ""
  (lambda () (insert (format-time-string "%Y-%m-%d"))))

(provide 'robenkleene-abbrev)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-abbrev.el ends here
