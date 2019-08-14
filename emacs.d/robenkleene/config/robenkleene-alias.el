;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; The usual alias for this, `gcd' conflicts with a built-in common lisp
;; function with the same name
(defalias 'cdg 'robenkleene/go-to-project-root)
(defalias 'tdb 'toggle-debug-on-error)
(defalias 'df 'delete-frame)
(defalias 'rg 'robenkleene/rg)
(defalias 'oi 'robenkleene/edit-init)
(defalias 'osh 'robenkleene/other-window-shell)
(defalias 'os 'robenkleene/open-scratch-other-window)
(defalias 'doc 'robenkleene/documentation)
(defalias 'doce 'robenkleene/documentation-edit)
(defalias 'slug 'robenkleene/slug-project)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwf (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-f")))
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'journal 'robenkleene/open-journal)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
