;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defalias 'rg 'robenkleene/rg)
(defalias 'oi 'robenkleene/edit-init)
(defalias 'cg 'robenkleene/grep-from-clipboard)
(defalias 'esh 'eshell)
(defalias 'bd 'kill-this-buffer)
(defalias 'doc 'robenkleene/consult-doc)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'clear 'desktop-clear)
(defalias 'repla 'robenkleene/open-in-repla)
(defalias 'title-case 'robenkleene/title-case)
(defalias 'archive-current-file 'robenkleene/archive-current-file)
(defalias 'today 'robenkleene/today)

;; Kill
(defalias 'kill-path 'robenkleene/kill-path)
(defalias 'kill-dir 'robenkleene/kill-dir)
(defalias 'kill-filename 'robenkleene/kill-filename)

;; cd
(defalias 'git-cd 'robenkleene/git-cd)
(defalias 'hg-cd 'robenkleene/hg-cd)
(defalias 'pwd-cd 'robenkleene/pwd-cd)

;; Buffers
(defalias 'scratch 'robenkleene/open-emacs-scratch)
(defalias 'messages 'robenkleene/open-emacs-messages)
(defalias 'home 'robenkleene/open-home)

;; Vim
(defalias 'new 'robenkleene/new-empty-other-window)
(defalias 'vnew 'robenkleene/new-empty-other-window-vertical)
(defalias 'enew 'robenkleene/new-empty)

;; Text
(defalias 'daily 'robenkleene/open-daily)
(defalias 'clip 'robenkleene/new-clipboard)
(defalias 'inbox 'robenkleene/inbox)
(defalias 'inbox-new 'robenkleene/new-inbox-document)

;; Slug Project
(defalias 'slug-project 'robenkleene/slug-project)
(defalias 'slug-project-archive 'robenkleene/slug-project-archive)
(defalias 'slug-project-archive-readme 'robenkleene/slug-project-archive-readme)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
