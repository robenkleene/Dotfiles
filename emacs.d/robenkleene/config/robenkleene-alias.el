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
(defalias 'esh 'eshell)
(defalias 'bd 'kill-this-buffer)
;; (defalias 'os 'robenkleene/open-scratch-other-window)
(defalias 'doc 'robenkleene/documentation-view)
(defalias 'doce 'robenkleene/documentation-edit)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'messages 'robenkleene/open-emacs-messages)
(defalias 'tweet 'robenkleene/tweets)
(defalias 'home 'robenkleene/open-home)
(defalias 'inbox 'robenkleene/inbox)
(defalias 'journal 'robenkleene/open-journal)
(defalias 'gac 'robenkleene/git-commit-all)
(defalias 'gacm 'robenkleene/git-commit-all-message)
(defalias 'clear 'desktop-clear)
(defalias 'sgpt 'robenkleene/sgit-push-text-all)
(defalias 'urls 'robenkleene/urls-open)
(defalias 'new 'robenkleene/new-empty-other-window)
(defalias 'untitled 'robenkleene/new-empty)
(defalias 'readme 'robenkleene/cdg-readme)
(defalias 'erm 'robenkleene/cdg-readme)
(defalias 'writer 'robenkleene/open-in-writer)
(defalias 'repla 'robenkleene/open-in-repla)
(defalias 'vscode 'robenkleene/open-in-vscode)

;; Todos
(defalias 'check 'robenkleene/todos-check)
(defalias 'uncheck 'robenkleene/todos-uncheck)
;; (defalias 'todos-invert 'robenkleene/todos-invert)

;; Longer
(defalias 'slug-project 'robenkleene/slug-project)
(defalias 'slug-project-archive 'robenkleene/slug-project-archive)
(defalias 'slug-project-archive-readme 'robenkleene/slug-project-archive-readme)
(defalias 'archive-current-file 'robenkleene/archive-current-file)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
