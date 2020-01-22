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
(defalias 'es 'robenkleene/open-emacs-scratch)
(defalias 'os 'robenkleene/open-markdown-scratch)
;; (defalias 'os 'robenkleene/open-scratch-ot/her-window)
(defalias 'doc 'robenkleene/documentation-view)
(defalias 'doce 'robenkleene/documentation-edit)
(defalias 'slug 'robenkleene/slug-project)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'journal 'robenkleene/open-journal)
(defalias 'tweet 'robenkleene/new-tweet)
(defalias 'otweets 'robenkleene/open-tweets)
(defalias 'inbox 'robenkleene/new-inbox-document)
(defalias 'oinbox 'robenkleene/open-inbox)
(defalias 'gac 'robenkleene/git-commit-all)
(defalias 'gacm 'robenkleene/git-commit-all-message)
(defalias 'clear 'desktop-clear)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
