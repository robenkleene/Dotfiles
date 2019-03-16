;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; The usual alias for this, `gcd' conflicts with a built-in common lisp
;; function with the same name
(defalias 'cg 'robenkleene/go-to-project-root)
(defalias 'tdb 'toggle-debug-on-error)
(defalias 'df 'delete-frame)
(defalias 'rg 'robenkleene/rg)
(defalias 'oi 'robenkleene/edit-init)
(defalias 'osh 'robenkleene/other-window-shell)
(defalias 'os 'robenkleene/open-scratch-other-window)
(defalias 'doc 'robenkleene/documentation)
(defalias 'slug 'robenkleene/slug-project)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwf (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-f")))

(provide 'robenkleene-alias)
;;; robenkleene-alias.el ends here
