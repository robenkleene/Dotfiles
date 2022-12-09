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
(defalias 'doc 'robenkleene/helm-documentation-edit)
;; (defalias 'doc 'robenkleene/documentation-view)
;; (defalias 'doce 'robenkleene/documentation-edit)
(defalias 'tags 'robenkleene/generate-tags)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'gac 'robenkleene/git-commit-all)
(defalias 'gacm 'robenkleene/git-commit-all-message)
(defalias 'gdg 'robenkleene/git-diff-grep)
(defalias 'hgdg 'robenkleene/hg-diff-grep)
(defalias 'hgdbg 'robenkleene/hg-diff-bottom-grep)
(defalias 'clear 'desktop-clear)
(defalias 'sgpt 'robenkleene/sgit-push-text-all)
(defalias 'urls 'robenkleene/urls-open)
(defalias 'readme 'robenkleene/cdg-readme)
(defalias 'erm 'robenkleene/cdg-readme)
(defalias 'writer 'robenkleene/open-in-writer)
(defalias 'nova 'robenkleene/open-in-nova)
(defalias 'repla 'robenkleene/open-in-repla)
(defalias 'vscode 'robenkleene/open-in-vscode)
(defalias 'work 'robenkleene/open-work)
(defalias 'archive 'robenkleene/open-archive)
(defalias 'title-case 'robenkleene/title-case)
(defalias 'lnk 'robenkleene/ido-links)
(defalias 'prj 'robenkleene/ido-project-open)
;; (defalias 'nte 'robenkleene/ido-frequent-open-file-or-dir)
(defalias 'nte 'robenkleene/helm-text-edit)
(defalias 'dired-write 'dired-toggle-read-only)
(defalias 'terminal (lambda ()
                      (interactive)
                      (split-window)
                      (other-window 1)
                      (eshell "new")))

;; Buffers & Files
;; (defalias 'daily 'robenkleene/browse-daily)
;; (defalias 'daily-new 'robenkleene/open-daily)
(defalias 'daily 'robenkleene/open-daily)
(defalias 'clip 'robenkleene/new-clipboard)
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'scratch-text 'robenkleene/new-empty)
(defalias 'messages 'robenkleene/open-emacs-messages)
(defalias 'new 'robenkleene/new-empty-other-window)
(defalias 'vnew 'robenkleene/new-empty-other-window-vertical)
(defalias 'untitled 'robenkleene/new-empty)
(defalias 'enew 'robenkleene/new-empty)
(defalias 'tweet 'robenkleene/tweets)
(defalias 'home 'robenkleene/open-home)
(defalias 'inbox 'robenkleene/inbox)
(defalias 'inbox-new 'robenkleene/new-inbox-document)
(defalias 'projects-new 'robenkleene/new-projects-document)
(defalias 'cg 'robenkleene/grep-from-clipboard)
(defalias 'today 'robenkleene/today)

;; Todos
(defalias 'check 'robenkleene/todos-check)
(defalias 'uncheck 'robenkleene/todos-uncheck)
;; (defalias 'todos-invert 'robenkleene/todos-invert)

;; Languages
(defalias 'md 'markdown-mode)

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
