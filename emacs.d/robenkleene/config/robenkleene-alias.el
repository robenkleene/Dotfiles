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
(defalias 'sho 'robenkleene/other-window-shell)
(defalias 'esho 'robenkleene/other-window-eshell)
(defalias 'es 'robenkleene/open-emacs-scratch)
(defalias 'os 'robenkleene/open-markdown-scratch)
(defalias 'ods 'robenkleene/open-development-scratch)
(defalias 'kb 'kill-this-buffer)
;; (defalias 'os 'robenkleene/open-scratch-ot/her-window)
(defalias 'doc 'robenkleene/documentation-view)
(defalias 'doce 'robenkleene/documentation-edit)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'journal 'robenkleene/open-journal)
(defalias 'ntweet 'robenkleene/new-tweet)
(defalias 'tweets 'robenkleene/open-tweets)
(defalias 'home 'robenkleene/open-home)
(defalias 'ninbox 'robenkleene/new-inbox-document)
(defalias 'inbox 'robenkleene/open-inbox)
(defalias 'gac 'robenkleene/git-commit-all)
(defalias 'gacm 'robenkleene/git-commit-all-message)
(defalias 'clear 'desktop-clear)
(defalias 'sgpt'robenkleene/sgit-push-text-all)

;; Longer
(defalias 'slug-project 'robenkleene/slug-project)
(defalias 'archive-current-file 'robenkleene/archive-current-file)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
